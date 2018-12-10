#!/bin/bash

#Nome: Leonardo Vargas    Turma: Redes    Professor: Diego Tumelero    Data: 10/12

Menu(){
   clear    #Limpa a tela
   
   echo "-----Escolha o método de backup-----"   	#Opções do menu
   echo "[1] SCP"
   echo "[2] Rsync"
   echo "[3] Apresentar diretório com Rsync"
   echo "[4] Sair"
   echo
   echo -n "Qual a opcao desejada ? "
   read op
   case $op in			#le a opção
      1) cp_r_r_scp;;		#Cópia utilizando o SCP
      2) cp_r_l_rsync;;		#Cópia utilizando o Rsync
      3) list_rsync ;;		#Listagem utilizando o rsync
      4) exit ;;
      *) "Opcao inválida." ; echo ; Principal ;;
   esac
}
cp_r_r_scp() {
echo "Cópia via SCP..."
read 
clear

echo "Informe a origem do arquivo: "
echo "Qual Path está o arquivo?  "
read origem_scp
clear
echo "Informe o destino do arquivo: "
echo "Qual Path deverá receber o arquivo? "
read dest_scp
clear
echo "Informe o ip da estação de origem: "
read ip_origem
clear
echo "Informe o IP da estação de destino: "
read ip_dest
clear
echo "Informe a porta do serviço SSH: "
read porta
clear
echo "Deseja copiar todos as pastas e sub-pastas? s/n "
read copia_geral
clear
echo "Informe o usuário de acesso: "
read usr_scp
clear
par="-r" #parametro de cópia de todos arquivos, -r para recursivo
por="-P" #adição da porta para conexão
parameters=`echo "$par $por $porta"`
parameters2=`echo "$por $porta"`
login=`echo "$usr_scp@$ip_dest"`
if [ $copia_geral == "s" ]; then
	scp $parameters $origem_scp $login:$dest_scp
	echo "Cópia realizada para: $dest_scp "
elif [ $copia_geral == "n"] ; then
	echo "Informe o nome do arquivo que deseja copiar: "
	echo "Ex.: /home/user/meu_arquivo.conf "
read arquivo_scp
    scp $parameters2 $arquivo_scp $login:$dest_scp
	echo "Cópia realziada para: $dest_scp "
elif [$copia_geral =! "s"] || [$copia_geral =!"n" ] ; then
	echo "Nenhum arquivo foi copiado "
fi
	Menu
}

cp_r_l_rsync() {
echo "Cópia via RSYNC..."
read 
clear
echo "Informe a origem do arquivo: "
echo "Qual Path está o arquivo? Ex.: /home/user/Xyz "
read origem_rsync
clear
echo "Informe o destino do arquivo: "
echo "Qual Path deverá receber o arquivo? Ex.: /home/user/Xyz "
read dest_rsync
clear
echo "Informe o ip da estação de origem:   "
read ip_origem
clear
echo "Informe o ip da estação de destino: "
read ip_dest
clear
echo "Informe o usuário de acesso: "
read usr_rsync
clear
echo "Iniciar Cópia? s/n "
read inicio
par="-Cravzp" 
parameters=`echo "$par"`
login=`echo "$usr_rsync@$ip_dest"`
if [ $inicio == "s" ]; then
	rsync $parameters $origem_rsync $login:$dest_rsync
	echo "Cópia realizada para: $dest_rsync "
elif [ $inicio == "n"] ; then
	echo "Informe o nome do arquivo que deseja copiar: "
	echo "Ex.: /home/user/meu_arquivo.conf  "
read arquivo_scp
    rsync $parameters $arquivo_rsync $login:$dest_rsync
	echo "Cópia realizada para: $dest_rsync "
elif [$inicio =! "s"] || [$inicio =!"n" ] ; then
	echo "Nenhum arquivo foi copiado "
fi
	Menu
}

list_rsync() {
echo "Listagem de Diretórios..."
read 
clear
echo "Informe o destino da Pasta: "
echo "Qual Path deverá receber o arquivo? Ex.:/home;/etc;/var;"
read dest_list
clear
echo "Informe o ip da estação de destino: "
read ip_dest
clear
echo "Informe o usuário de acesso: "
read usr_list
clear
echo "Iniciar Listagem? s/n "
read begin
par="-Cravzp" 
parameters=`echo "$par"`
login=`echo "$usr_rsync@$ip_dest"`
if [ $begin == "s" ]; then
	rsync $parameters  $login:$dest_list
else [$begin =! "n"];
echo "Voltaremos ao Menu principal, tecle enter"
read
fi
Menu
}
Menu
