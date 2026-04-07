const axios = require("axios");
const readline = require("readline");
const fs = require("fs");
const PDFDocument = require("pdfkit");

// TOKEN CPF
const CPF_TOKEN = "113643e7a870f9189f62502529b47d3e";

// LOGIN
const usuarios = {
  admin1: "7788",
  admin2: "1100",
  gratis1: "77880",
  gratis2: "66009"
};

// CONTADOR
let contador = 0;

if (fs.existsSync("contador.txt")) {
  contador = parseInt(fs.readFileSync("contador.txt"));
}

// READLINE
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// LIMPAR
function limpar() {
  console.clear();
}

// 🚗 DRIFT
async function drift() {

  const frames = [

`        ______
   ____/_____|___
  |  _     _     |
='-(_)--(_)--(_)-'  💨`,

`     ______
 ____/_____|___
|  _     _     |
='-(_)--(_)--(_)-'   💨`,

`  ______
_/_____|___
  _     _     
(_)--(_)--(_)-  💨`

  ];

  for (let i = 0; i < 6; i++) {

    limpar();

    console.log(
      frames[i % frames.length]
    );

    await new Promise(r =>
      setTimeout(r, 200)
    );

  }

}

// SALVAR PDF
function salvarPDF(tipo, dados) {

  if (!fs.existsSync("consultas")) {
    fs.mkdirSync("consultas");
  }

  contador++;

  fs.writeFileSync(
    "contador.txt",
    contador.toString()
  );

  const nome =
    `consultas/consulta${contador}.pdf`;

  const doc = new PDFDocument();

  doc.pipe(
    fs.createWriteStream(nome)
  );

  doc.fontSize(16)
     .text("CONSULTA REALIZADA");

  doc.moveDown();

  doc.text("Tipo: " + tipo);

  doc.text(
    "Data: " +
    new Date().toLocaleString()
  );

  doc.moveDown();

  if (typeof dados === "object") {

    for (let c in dados) {

      doc.text(`${c}: ${dados[c]}`);

    }

  } else {

    doc.text(dados);

  }

  doc.moveDown();

  doc.text("----------------------");
  doc.text("DESENVOLVEDORES:");
  doc.text("ERRO404 e KYARA");

  doc.end();

}

// VOLTAR
function voltar() {

  console.log("\n----------------------");
  console.log("DESENVOLVEDORES: ERRO404 e KYARA");

  rl.question(
    "\n[+] ENTER para voltar",
    () => menu()
  );

}

// LOGIN
async function login() {

  await drift();

  limpar();

  console.log("=== LOGIN ===\n");

  rl.question("Usuário: ", user => {

    rl.question("Senha: ", pass => {

      if (usuarios[user] === pass) {

        console.log("\nLogin OK");

        setTimeout(menu, 1000);

      } else {

        console.log("\nLogin inválido");

        setTimeout(login, 1500);

      }

    });

  });

}

// MENU
function menu() {

  limpar();

  console.log(`
╔══════════════════════════════╗
║       PAINEL CONSULTAS       ║
╠══════════════════════════════╣
║ 8 → CPF                      ║
║ 0 → SAIR                     ║
╠══════════════════════════════╣
║ Consultas hoje: ${contador}           ║
║ DESENV: ERRO404 | KYARA      ║
╚══════════════════════════════╝
`);

  rl.question("[+] Escolha: ", op => {

    if (op === "8") cpf();
    else if (op === "0") process.exit();
    else menu();

  });

}

// CPF (CORRIGIDO COM HEADERS)
async function cpf() {

  rl.question("Digite CPF: ", async cpfInput => {

    try {

      let cpf =
        cpfInput.replace(/\D/g,"");

      if (cpf.length !== 11) {

        console.log("CPF inválido.");
        return voltar();

      }

      console.log("\nConsultando CPF...\n");

      const url =
`https://apis.gonzalesdev.shop/?token=${CPF_TOKEN}&r=credilink&cpf=${cpf}`;

      console.log("URL usada:");
      console.log(url);

      const response =
        await axios.get(url, {

          headers: {

            "User-Agent":
"Mozilla/5.0 (Windows NT 10.0; Win64; x64)",

            "Accept":
"application/json"

          }

        });

      const dados =
        response.data;

      console.log("\n===== RESULTADO CPF =====\n");

      if (typeof dados === "object") {

        for (let chave in dados) {

          console.log(
            `${chave}: ${dados[chave]}`
          );

        }

      } else {

        console.log(dados);

      }

      salvarPDF("CPF", dados);

    }

    catch (erro) {

      console.log("\nErro CPF:");

      if (erro.response) {

        console.log(
          "Status:",
          erro.response.status
        );

        console.log(
          erro.response.data
        );

      } else {

        console.log(
          erro.message
        );

      }

    }

    voltar();

  });

}

// START
login();
