#!/bin/bash

# =========================
# ZEUS SEARCH v3.3 FULL
# =========================

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RESET="\033[0m"
CYAN="\033[1;36m"

LOG="logs.txt"
CPF_KEY="a226a8a6d4b5eab60686baab5a424d4cf3a25d0c6f9e72172eb99cfc6de3b5a6"

# =========================
# BOOT
# =========================
boot() {
    clear
    echo -e "${RED}"
    echo "Inicializando ZEUS..."
    for i in 10 30 50 70 90 100; do
        echo -ne "Carregando: $i% \r"
        sleep 0.4
    done
    sleep 1
}

# =========================
# LOG
# =========================
logar() {
    echo "$(date) | $1" >> $LOG
}

# =========================
# LOGIN USERS.TXT
# =========================
login() {
    while true; do
        clear
        echo -e "${RED}🔐 LOGIN ZEUS SEARCH${RESET}"
        read -p "Usuário: " user
        read -s -p "Senha: " pass
        echo ""
        if grep -q "^$user:$pass$" users.txt; then
            echo -e "${GREEN}Acesso permitido${RESET}"
            logar "LOGIN OK - $user"
            sleep 1
            break
        else
            echo -e "${RED}Login inválido${RESET}"
            logar "LOGIN FAIL - $user"
            sleep 2
        fi
    done
}

# =========================
# CRIAR USUÁRIO
# =========================
criar_usuario() {
    read -p "Novo usuário: " user
    read -p "Nova senha: " pass
    echo "$user:$pass" >> users.txt
    echo -e "${RED}Usuário criado${RESET}"
    logar "NOVO USER - $user"
    read -p "Enter..."
}

# =========================
# BANNER
# =========================
banner() {
    clear
    echo -e "${RED}"
    echo "        <^\()/^>"
    echo "         \/  \/"
    echo "          /  \\"
    echo "          \`\`\`"
    echo ""
    echo "███████╗███████╗██╗   ██╗███████╗"
    echo "╚══███╔╝██╔════╝██║   ██║██╔════╝"
    echo "  ███╔╝ █████╗  ██║   ██║███████╗"
    echo " ███╔╝  ██╔══╝  ██║   ██║╚════██║"
    echo "███████╗███████╗╚██████╔╝███████║"
    echo "╚══════╝╚══════╝ ╚═════╝ ╚══════╝"
    echo ""
    echo "👼 ZEUS SEARCH v3 [PoweredBy & cypherlock & erro404]"
    echo ""
}

# =========================
# JSON CHECK
# =========================
exibir_json() {
    if command -v jq &>/dev/null; then
        echo "$1" | jq
    else
        echo -e "${YELLOW}⚠ jq não encontrado. Mostrando JSON cru:${RESET}"
        echo "$1"
    fi
}

# =========================
# CONSULTAS COMPLETAS
# =========================
consulta_cpf() {
    read -p "CPF: " cpf
    result=$(curl -s -X GET "https://apicpf.com/api/consulta?cpf=$cpf" -H "X-API-KEY: $CPF_KEY")
    exibir_json "$result"
    logar "CPF $cpf"
    read -p "Enter..."
}

consulta_cnpj() {
    read -p "CNPJ: " cnpj
    result=$(curl -s "https://brasilapi.com.br/api/cnpj/v1/$cnpj")
    exibir_json "$result"
    logar "CNPJ $cnpj"
    read -p "Enter..."
}

consulta_telefone() {
    read -p "Telefone (+55DDDNUM): " tel
    read -p "API Key AbstractAPI: " chave
    result=$(curl -s "https://phonevalidation.abstractapi.com/v1/?api_key=$chave&phone=$tel")
    exibir_json "$result"
    logar "TELEFONE $tel"
    read -p "Enter..."
}

consulta_cep() {
    read -p "CEP: " cep
    result=$(curl -s "https://cep.awesomeapi.com.br/json/$cep")
    exibir_json "$result"
    logar "CEP $cep"
    read -p "Enter..."
}

consulta_ddd() {
    read -p "DDD: " ddd
    result=$(curl -s "https://brasilapi.com.br/api/ddd/v1/$ddd")
    exibir_json "$result"
    logar "DDD $ddd"
    read -p "Enter..."
}

consulta_ip() {
    read -p "IP: " ip
    result=$(curl -s "http://ip-api.com/json/$ip")
    exibir_json "$result"
    logar "IP $ip"
    read -p "Enter..."
}

consulta_ip_detalhado() {
    read -p "IP: " ip
    result=$(curl -s "https://ipinfo.io/$ip/json")
    exibir_json "$result"
    logar "IP DETALHADO $ip"
    read -p "Enter..."
}

consulta_whois() {
    read -p "Domínio: " dom
    result=$(curl -s "https://api.apilayer.com/whois?domain=$dom&apikey=$CPF_KEY")
    exibir_json "$result"
    logar "WHOIS $dom"
    read -p "Enter..."
}

consulta_dns() {
    read -p "Domínio: " dom
    nslookup $dom
    logar "DNS $dom"
    read -p "Enter..."
}

ping_host() {
    read -p "IP ou domínio: " ip
    ping -c 4 $ip
    logar "PING $ip"
    read -p "Enter..."
}

scanner_portas() {
    read -p "IP: " ip
    echo "Escaneando..."
    for p in 21 22 23 25 53 80 110 143 443 3306 8080; do
        nc -z -w1 $ip $p 2>/dev/null && echo "Porta aberta: $p"
    done
    logar "SCAN $ip"
    read -p "Enter..."
}

traceroute_host() {
    read -p "IP: " ip
    traceroute $ip
    logar "TRACEROUTE $ip"
    read -p "Enter..."
}

subdomain_fake() {
    read -p "Domínio: " dom
    echo "www.$dom"
    echo "mail.$dom"
    echo "api.$dom"
    echo "dev.$dom"
    logar "SUBDOMAIN $dom"
    read -p "Enter..."
}

# =========================
# GERADORES COMPLETOS
# =========================
gerar_cpf() {
    echo "$((RANDOM%900+100)).$((RANDOM%900+100)).$((RANDOM%900+100))-$((RANDOM%90+10))"
    logar "CPF GERADO"
    read -p "Enter..."
}

gerar_cnpj() {
    echo "$((RANDOM%90+10)).$((RANDOM%900+100)).$((RANDOM%900+100))/$((RANDOM%9000+1000))-$((RANDOM%90+10))"
    logar "CNPJ GERADO"
    read -p "Enter..."
}

gerar_rg() {
    read -p "Base RG: " rg
    echo "$rg-$(($RANDOM%9999))"
    logar "RG GERADO"
    read -p "Enter..."
}

gerar_senha() {
    # Substituindo openssl por /dev/urandom
    senha=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12)
    echo "$senha"
    logar "SENHA GERADA"
    read -p "Enter..."
}

gerar_username() {
    read -p "Nome base: " nome
    user="${nome}$(($RANDOM%9999))"
    echo "$user"
    logar "USERNAME GERADO"
    read -p "Enter..."
}

# =========================
# UTILIDADES
# =========================
gerar_template() {
    read -p "Link Discord: " link
    codigo=$(echo "$link" | awk -F'/' '{print $NF}')
    echo "https://discord.new/$codigo"
    logar "TEMPLATE GERADO"
    read -p "Enter..."
}

salvar_texto() {
    read -p "Texto: " txt
    echo "$txt" >> dados.txt
    logar "TEXTO SALVO"
    read -p "Enter..."
}

atualizar_script() {
    git pull
    logar "ATUALIZADO"
    read -p "Enter..."
}

# =========================
# EXECUÇÃO
# =========================
boot
login

while true; do
    banner

    echo "[01] Consulta CPF"
    echo "[02] Consulta CNPJ"
    echo "[03] Telefone"
    echo "[04] CEP"
    echo "[05] DDD"
    echo "[06] IP"
    echo "[07] IP Detalhado"
    echo "[08] WHOIS"
    echo "[09] DNS"

    echo ""
    echo "[10] Ping"
    echo "[11] Scanner Portas"
    echo "[12] Traceroute"
    echo "[13] Subdomain"

    echo ""
    echo "[21] Gerar CPF"
    echo "[22] Gerar CNPJ"
    echo "[23] Gerar RG"
    echo "[24] Gerar Senha"
    echo "[25] Gerar Username"

    echo ""
    echo "[31] Gerar Template"
    echo "[32] Salvar Texto"

    echo ""
    echo "[90] Criar Usuário"
    echo "[96] Atualizar Script"
    echo "[99] Sair"

    read -p "Escolha: " op

    case $op in
        01) consulta_cpf ;;
        02) consulta_cnpj ;;
        03) consulta_telefone ;;
        04) consulta_cep ;;
        05) consulta_ddd ;;
        06) consulta_ip ;;
        07) consulta_ip_detalhado ;;
        08) consulta_whois ;;
        09) consulta_dns ;;
        10) ping_host ;;
        11) scanner_portas ;;
        12) traceroute_host ;;
        13) subdomain_fake ;;
        21) gerar_cpf ;;
        22) gerar_cnpj ;;
        23) gerar_rg ;;
        24) gerar_senha ;;
        25) gerar_username ;;
        31) gerar_template ;;
        32) salvar_texto ;;
        90) criar_usuario ;;
        96) atualizar_script ;;
        99) exit ;;
        *) echo -e "${RED}Opção inválida${RESET}" ; sleep 1 ;;
    esac
done
