#!/bin/bash
# Nexus Hub - Painel de Consultas Funcional v3
# Autor: Kyara e Erro404
# Data: 2026-04-07

# ===== Cores =====
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
CYAN="\033[1;36m"
RESET="\033[0m"

# ===== Chaves =====
CPF_KEY="a226a8a6d4b5eab60686baab5a424d4cf3a25d0c6f9e72172eb99cfc6de3b5a6"

# ===== Funções =====
gerar_cpf() {
    n1=$((RANDOM % 10)); n2=$((RANDOM % 10)); n3=$((RANDOM % 10))
    n4=$((RANDOM % 10)); n5=$((RANDOM % 10)); n6=$((RANDOM % 10))
    n7=$((RANDOM % 10)); n8=$((RANDOM % 10)); n9=$((RANDOM % 10))
    d1=$(( (10*n1+9*n2+8*n3+7*n4+6*n5+5*n6+4*n7+3*n8+2*n9) % 11 ))
    [ $d1 -ge 10 ] && d1=0
    d2=$(( (11*n1+10*n2+9*n3+8*n4+7*n5+6*n6+5*n7+4*n8+3*n9+2*d1) % 11 ))
    [ $d2 -ge 10 ] && d2=0
    echo "$n1$n2$n3.$n4$n5$n6.$n7$n8$n9-$d1$d2"
}

gerar_cnpj() {
    n1=$((RANDOM % 10)); n2=$((RANDOM % 10)); n3=$((RANDOM % 10)); n4=$((RANDOM % 10))
    n5=$((RANDOM % 10)); n6=$((RANDOM % 10)); n7=$((RANDOM % 10)); n8=$((RANDOM % 10))
    n9=$((RANDOM % 10)); n10=$((RANDOM % 10)); n11=$((RANDOM % 10)); n12=$((RANDOM % 10))
    d1=$(( (5*n1+4*n2+3*n3+2*n4+9*n5+8*n6+7*n7+6*n8+5*n9+4*n10+3*n11+2*n12) % 11 ))
    [ $d1 -ge 10 ] && d1=0
    d2=$(( (6*n1+5*n2+4*n3+3*n4+2*n5+9*n6+8*n7+7*n8+6*n9+5*n10+4*n11+3*n12+2*d1) % 11 ))
    [ $d2 -ge 10 ] && d2=0
    echo "$n1$n2.$n3$n4$n5.$n6$n7$n8/$n9$n10$n11$n12-$d1$d2"
}

# ===== Loop do menu =====
while true; do
    clear
    echo -e "${RED}"
    echo "╔════════════════════════════════╗"
    echo "║erro404 NEXUS HUB v3.0 kyara    ║"
    echo "║   Painel de Consultas Termux   ║"
    echo "╚════════════════════════════════╝"
    echo -e "${RESET}"
    echo ""

    echo -e "${CYAN}========== CONSULTAS ==========${RESET}"
    echo "[01] Consulta CPF"
    echo "[02] Consulta CNPJ"
    echo "[03] Consulta RG (simulado)"
    echo "[04] Consulta CNS (simulado)"
    echo "[05] Consulta Telefone"
    echo "[06] Consulta CEP"
    echo "[07] Consulta IP"
    echo "[08] Consulta DDD"
    echo "[09] Consulta DDI (simulado)"
    echo "[10] Consulta Placa (simulado)"

    echo ""
    echo -e "${YELLOW}========== GERADORES ==========${RESET}"
    echo "[11] Gerador de CPF"
    echo "[12] Gerador de CNPJ"
    echo "[13] Gerador de RG (simulado)"

    echo ""
    echo -e "${GREEN}========== VALIDADORES ==========${RESET}"
    echo "[14] Validador CPF"
    echo "[15] Validador CNPJ"
    echo "[16] Validador RG"

    echo ""
    echo -e "${BLUE}========== FERRAMENTAS ==========${RESET}"
    echo "[17] Criar Script"
    echo "[18] Manual Termux"
    echo "[19] Scanear Portas"
    echo "[20] Tema Termux"

    echo ""
    echo -e "${RED}========== SISTEMA ==========${RESET}"
    echo "[96] Atualizar Painel"
    echo "[97] Canais para Contato"
    echo "[98] Informações"
    echo "[99] Sair"

    echo ""
    read -p "Escolha uma opção: " opcao

    case $opcao in
    01)
        read -p "Digite o CPF: " cpf
        echo -e "${GREEN}Consultando CPF...${RESET}"
        resposta=$(curl -s -X GET \
        "https://apicpf.com/api/consulta?cpf=$cpf" \
        -H "X-API-KEY: $CPF_KEY")
        [ -z "$resposta" ] && resposta="${RED}API de CPF indisponível${RESET}"
        echo "$resposta"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    02)
        read -p "Digite o CNPJ (somente números): " cnpj
        echo -e "${GREEN}Consultando CNPJ...${RESET}"
        resposta=$(curl -s "https://brasilapi.com.br/api/cnpj/v1/$cnpj")
        [[ "$resposta" == *"404"* || -z "$resposta" ]] && resposta="${RED}API de CNPJ indisponível ou CNPJ inválido${RESET}"
        echo "$resposta"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    03)
        read -p "Digite o RG: " rg
        echo -e "${GREEN}Consulta RG simulada...${RESET}"
        echo "RG informado: $rg (simulado)"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    04)
        read -p "Digite o CNS: " cns
        echo -e "${GREEN}Consulta CNS simulada...${RESET}"
        echo "CNS informado: $cns (simulado)"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    05)
        read -p "Digite o Telefone (+55DDDNUMERO): " tel
        echo -e "${GREEN}Consultando telefone...${RESET}"
        read -p "Insira sua chave AbstractAPI: " chave
        curl -s "https://phonevalidation.abstractapi.com/v1/?api_key=$chave&phone=$tel" \
        || curl -s "https://apilayer.com/phone_check?number=$tel&apikey=$chave" \
        || echo -e "${RED}APIs de telefone indisponíveis${RESET}"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    06)
        read -p "Digite o CEP: " cep
        echo -e "${GREEN}Consultando CEP...${RESET}"
        curl -s "https://cep.awesomeapi.com.br/json/$cep" \
        || echo -e "${RED}API de CEP indisponível${RESET}"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    07)
        read -p "Digite o IP: " ip
        echo -e "${GREEN}Consultando IP...${RESET}"
        curl -s "http://ip-api.com/json/$ip" \
        || echo -e "${RED}API de IP indisponível${RESET}"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    08)
        read -p "Digite o DDD: " ddd
        echo -e "${GREEN}Consultando DDD...${RESET}"
        curl -s "https://brasilapi.com.br/api/ddd/v1/$ddd" \
        || echo -e "${RED}API de DDD indisponível${RESET}"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    09)
        read -p "Digite o DDI: " ddi
        echo -e "${GREEN}Consulta DDI simulada...${RESET}"
        echo "DDI informado: $ddi (simulado)"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    10)
        read -p "Digite a Placa: " placa
        echo -e "${GREEN}Consulta Placa simulada...${RESET}"
        echo "Placa informada: $placa (simulado)"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    11)
        echo -e "${YELLOW}Gerando CPF...${RESET}"
        gerar_cpf
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    12)
        echo -e "${YELLOW}Gerando CNPJ...${RESET}"
        gerar_cnpj
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    13)
        read -p "Digite RG base: " rg
        echo -e "${YELLOW}Gerando RG simulado...${RESET}"
        echo "$rg-$(($RANDOM%9999))"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    14)
        read -p "Digite o CPF: " cpf
        echo -e "${GREEN}Validando CPF...${RESET}"
        echo "Simulação: CPF válido"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    15)
        read -p "Digite o CNPJ: " cnpj
        echo -e "${GREEN}Validando CNPJ...${RESET}"
        echo "Simulação: CNPJ válido"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    16)
        read -p "Digite o RG: " rg
        echo -e "${GREEN}Validando RG...${RESET}"
        echo "RG informado: $rg (simulado válido)"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    17)
        echo -e "${BLUE}Criar Script...${RESET}"
        read -p "Digite o nome do script (ex: teste.sh): " nome
        touch "$nome"
        chmod +x "$nome"
        echo -e "${GREEN}Arquivo $nome criado com permissão de execução!${RESET}"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    18)
        echo -e "${BLUE}Abrindo Manual Termux...${RESET}"
        echo "Digite 'q' para sair do manual."
        man bash
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    19)
        read -p "Digite IP para scan: " ip
        echo -e "${BLUE}Scan de portas iniciado em $ip...${RESET}"
        nmap $ip
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    20)
        echo -e "${BLUE}Tema Termux ativado...${RESET}"
        PS1="\[\033[1;32m\]\u@\h:\w\$ \[\033[0m\]"
        echo "Tema aplicado temporariamente. Para permanente, adicione no ~/.bashrc"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    96)
        echo -e "${RED}Atualizando painel...${RESET}"
        pkg update -y && pkg upgrade -y
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    97)
        echo -e "${RED}Canais para contato:${RESET}"
        echo "Telegram: @Kyara"
        echo "Discord: Erro404#0001"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    98)
        echo -e "${RED}Informações do Nexus Hub:${RESET}"
        echo "Versão: 3.0"
        echo "Autor: Kyara e Erro404"
        echo "Última atualização: 2026-04-07"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    99)
        echo -e "${RED}Saindo...${RESET}"
        exit
        ;;
    *)
        echo -e "${RED}Opção inválida${RESET}"
        read -p "Pressione Enter para voltar ao menu..."
        ;;
    esac
done
