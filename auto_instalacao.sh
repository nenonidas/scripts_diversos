#!/bin/bash

# Solicita o nome do programa ao usuário
read -p "Digite o nome do programa que deseja instalar: " programa

# Verifica se o programa já está instalado
if dpkg -l | grep -q $programa; then
    echo "$programa já está instalado."
else
    # Atualiza a lista de pacotes
    apt-get update

    # Instala as dependências do programa (caso seja necessário houver)
    apt-get install -y $programa

    # Verifica se a instalação deu certo
    if [ $? -eq 0 ]; then
        echo "$programa foi instalado com sucesso."
    else
        echo "Ocorreu um erro durante a instalação de $programa."
        exit 1
    fi
fi

# Atualiza a base de pacotes e instala as atualizações caso seja necessário
apt-get update
apt-get upgrade

echo "Base de pacotes atualizada com sucesso"

