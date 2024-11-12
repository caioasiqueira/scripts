####################################################################################
# Script para coletar todos os usuários inativos no AD                             #
# Criado por Caio Siqueira                                                         #
# Versão 1.0                                                                       #
####################################################################################

# Selecionar OU dos usuários de funcionários Desativados no AD
$OU =(Get-ADOrganizationalUnit -Filter {name -like "OU_Desligados"}).DistinguishedName

# Salvar em txt filtrando os usuários encontrados na OU dos users inativos
Get-ADUser -SearchBase $OU -Filter {SamAccountName -like "*x"} | select -ExpandProperty SamAccountName | Out-File -FilePath "C:\Temp\Users_inactive.txt"
