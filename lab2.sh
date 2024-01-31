#!/bin/bash
echo
echo Digite nome do GRUPO para criação:
read "GRUPO"

while (getent group "$GRUPO")
do
    echo Grupo existente. Digite outro nome de grupo:
    read "GRUPO"
done

#Criação do grupo:
sudo groupadd "$GRUPO"

echo
echo Digite nome de USUARIO para criação:
read "USUARIO"

# Verificação de existencia da nomenclaruta do nome usuário
while (getent passwd | grep "^$USUARIO")
do
    echo Usuário Existente! Digite outro nome de Usuário:
    read "USUARIO"
done

#Criação do usuário do sistema:
useradd -m -s /bin/bash -g "$GRUPO" "$USUARIO"

#Criação da Senha:
echo
echo Digite sua senha e confirme em seguida:
sudo passwd "$USUARIO" 

#Verificando se o novo usuário criado é membro do novo grupo criado.
echo
echo Verificando usuário criado se é membro do novo grupo criado.
sudo groups "$USUARIO" 

#Criando um diretório na raiz do sistema de arquivos com o mesmo nome do usuário criado. /
echo
echo Criando um diretório na raiz do sistema de arquivos, com o mesmo nome do usuário criado.
sudo mkdir /"$USUARIO" 

#Defina a propriedade do diretório para o usuário e o grupo criados.
echo
echo Definindo a propriedade do diretório para o usuário e o grupo criados.
chown "$USUARIO":"$GRUPO" /"$USUARIO"

#Definindo permissões do diretório para controle total para o proprietário e controle total para o grupo criado.
echo
echo Definindo permissões do diretório para controle total para o proprietário e controle total para o grupo criado.
sudo chmod 770 /"$USUARIO"

#Defina as permissões para garantir que somente o proprietário de um arquivo possa excluí-lo do diretório.
echo
echo Defindo as permissões para garantir que somente o proprietário de um arquivo possa excluí-lo do diretório.
chmod 1770 /"$USUARIO"

#Verifique se o script é executável.
echo
echo Validando as execuções dos comandos anteriores e verificando se o script é executável.
ls -ld /"$USUARIO"

exit

