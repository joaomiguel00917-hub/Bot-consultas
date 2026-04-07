#!/bin/bash
# ZEUS HUB v1.3 - Painel completo
# Autor: Cypherlock & Erro404
# Data: 2026-04-07

# ===== Cores =====
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
CYAN="\033[1;36m"
MAGENTA="\033[1;35m"
RESET="\033[0m"

# ===== LOGIN =====

USER_LOGIN="cypherlock"
PASS_LOGIN="zeus@123"

login() {

clear

echo -e "${CYAN}"
echo "🔐 LOGIN ZEUS"
echo -e "${RESET}"

read -p "Usuário: " user
read -s -p "Senha: " pass
echo ""

if [[ "$user" == "$USER_LOGIN" && "$pass" == "$PASS_LOGIN" ]]; then

echo -e "${GREEN}Acesso permitido${RESET}"
sleep 1

else

echo -e "${RED}Usuário ou senha incorretos${RESET}"
sleep 2
login

fi

}

# ===== Chaves =====
CPF_KEY="a226a8a6d4b5eab60686baab5a424d4cf3a25d0c6f9e72172eb99cfc6de3b5a6"

# ===== Funções =====

linha_animada() {
    for i in {1..50}; do
        echo -ne "${RED}─${RESET}"
        sleep 0.01
    done
    echo ""
}

digitar() {
    texto=$1
    cor=$2
    for ((i=0; i<${#texto}; i++)); do
        echo -ne "${cor}${texto:$i:1}${RESET}"
        sleep 0.05
    done
    echo ""
}

loading_menu() {
    echo -ne "${CYAN}Carregando ZEUS CONULTAS"
    for i in {1..5}; do
        echo -ne "."
        sleep 0.3
    done
    echo ""
    sleep 0.2
}

banner() {
    clear
    linha_animada
    digitar "CONSULTAS ZEUS" $YELLOW
    digitar "Desenvolvido por [Cypherlock] e [ERRO404]" $CYAN
    linha_animada
    echo ""

    echo -e "${CYAN}███████╗███████╗██╗   ██╗███████╗${RESET}"
    echo -e "${CYAN}╚══███╔╝██╔════╝██║   ██║██╔════╝${RESET}${BLUE}  ██║   ██║██╔════╝${RESET}"
    echo -e "${CYAN}  ███╔╝ █████╗  ██║   ██║███████╗${RESET}${BLUE}  ██║   ██║███████╗${RESET}"
    echo -e "${CYAN} ███╔╝  ██╔══╝  ██║   ██║╚════██║${RESET}${BLUE}  ██║   ██║╚════██║${RESET}"
    echo -e "${CYAN}███████╗███████╗╚██████╔╝███████║${RESET}${BLUE}╚██████╔╝███████║${RESET}"
    echo -e "${CYAN}╚══════╝╚══════╝ ╚═════╝ ╚══════╝${RESET}${BLUE} ╚═════╝ ╚══════╝${RESET}"
    echo -e "${YELLOW}📡 ZEUS CONSULTAS 📡t.me/DENVOLVEDORZEUS ${RESET}"
    linha_animada
}

# ===== TEMPLATE DISCORD =====

gerar_template() {

echo ""
echo -e "${CYAN}GERADOR TEMPLATE DISCORD${RESET}"
echo ""

read -p "Cole o link do servidor: " link

codigo=$(echo "$link" | awk -F'/' '{print $NF}')

if [[ -z "$codigo" ]]; then

echo -e "${RED}Link inválido${RESET}"

else

template="https://discord.new/$codigo"

echo ""
echo -e "${GREEN}Template gerado:${RESET}"
echo "$template"

fi

echo ""
read -p "Enter para voltar..."

}

# ===== Geradores =====

gerar_cpf() {
    n1=$((RANDOM%10)); n2=$((RANDOM%10)); n3=$((RANDOM%10))
    n4=$((RANDOM%10)); n5=$((RANDOM%10)); n6=$((RANDOM%10))
    n7=$((RANDOM%10)); n8=$((RANDOM%10)); n9=$((RANDOM%10))
    d1=$(( (10*n1+9*n2+8*n3+7*n4+6*n5+5*n6+4*n7+3*n8+2*n9)%11 ))
    [ $d1 -ge 10 ] && d1=0
    d2=$(( (11*n1+10*n2+9*n3+8*n4+7*n5+6*n6+5*n7+4*n8+3*n9+2*d1)%11 ))
    [ $d2 -ge 10 ] && d2=0
    echo "$n1$n2$n3.$n4$n5$n6.$n7$n8$n9-$d1$d2"
}

gerar_cnpj() {
    n1=$((RANDOM%10)); n2=$((RANDOM%10)); n3=$((RANDOM%10)); n4=$((RANDOM%10))
    n5=$((RANDOM%10)); n6=$((RANDOM%10)); n7=$((RANDOM%10)); n8=$((RANDOM%10))
    n9=$((RANDOM%10)); n10=$((RANDOM%10)); n11=$((RANDOM%10)); n12=$((RANDOM%10))
    d1=$(( (5*n1+4*n2+3*n3+2*n4+9*n5+8*n6+7*n7+6*n8+5*n9+4*n10+3*n11+2*n12)%11 ))
    [ $d1 -ge 10 ] && d1=0
    d2=$(( (6*n1+5*n2+4*n3+3*n4+2*n5+9*n6+8*n7+7*n8+6*n9+5*n10+4*n11+3*n12+2*d1)%11 ))
    [ $d2 -ge 10 ] && d2=0
    echo "$n1$n2.$n3$n4$n5.$n6$n7$n8/$n9$n10$n11$n12-$d1$d2"
}

gerar_rg() {
    read -p "Digite a base RG: " rg
    echo "$rg-$(($RANDOM%9999))"
}

gerar_senha() {
    if command -v openssl >/dev/null 2>&1; then
        openssl rand -base64 12
    else
        echo -e "${RED}OpenSSL não encontrado. Instale com: pkg install openssl${RESET}"
    fi
}

check_ip() {
    ip=$1
    ping -c 1 $ip &>/dev/null
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}IP ativo${RESET}"
        return 0
    else
        echo -e "${RED}IP inativo ou bloqueado${RESET}"
        return 1
    fi
}

# ===== INICIAR LOGIN =====

login

# ===== Loop do Menu =====
while true; do
    loading_menu
    banner

    echo -e "${CYAN}===== CONSULTAS =====${RESET}"
    echo "[01] CPF"
    echo "[02] CNPJ"
    echo "[03] RG (simulado)"
    echo "[04] Telefone"
    echo "[05] CEP"
    echo "[06] IP"
    echo "[07] DDD"
    echo "[08] Whois"
    echo "[09] DNS"
    echo "[10] Ping"
    echo "[11] Port Check"
    echo "[12] Username Generator"

    echo ""
    echo -e "${YELLOW}===== GERADORES =====${RESET}"
    echo "[21] Gerar CPF"
    echo "[22] Gerar CNPJ"
    echo "[23] Gerar RG"
    echo "[24] Gerar senha forte"

    echo ""
    echo -e "${GREEN}===== UTILIDADES =====${RESET}"
    echo "[31] Traceroute"
    echo "[32] Subdomain Finder"
    echo "[33] Salvar resultado"
    echo "[34] Gerar Template Discord"

    echo ""
    echo -e "${RED}===== SISTEMA =====${RESET}"
    echo "[96] Atualizar"
    echo "[97] Contato"
    echo "[99] Sair"

    read -p "Escolha uma opção: " opcao

    case $opcao in

        34) gerar_template;;

        99) exit;;

        *) echo -e "${RED}Opção inválida${RESET}"; read -p "Enter...";;

    esac

done
