const axios = require("axios");
const readline = require("readline");

const TOKEN = "https://apis.gonzalesdev.shop/?token=${TOKEN}&r=cpf2&sp=${cpf}`";

async function consultarCPF(cpf){
  try {
    const res = await axios.get(
      `https://apis.gonzalesdev.shop/?token=${TOKEN}&r=fotos&sp=${cpf}`
    );
    return res.data;
  } catch (e) {
    return { erro: true, msg: "Erro ao consultar API" };
  }
}

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question("COLOQUE SEU CPF AQUI: ", async (cpf)=>{
  const data = await consultarCPF(cpf);
  console.log("\nRESULTADO:");
  console.log(data);
  rl.close();
});
