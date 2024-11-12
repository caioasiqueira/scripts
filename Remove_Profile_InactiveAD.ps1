####################################################################################
# Script para remover os perfils de usuários inativos                              #
# Criado por Caio Siqueira                                                         #
# Versão 1.0                                                                       #
####################################################################################

# Variável com a lista dos usuários inativos funcionarios
$users = Get-Content "C:\temp\Users_inactive.txt"

# Remoção dos perfis com base na lista de usuários
    foreach($user in $users){ 
        $localpath = 'c:\users\' + $user
        write-output "Removing profile $localpath"   
        Get-WmiObject -Class Win32_UserProfile | Where-Object {$_.LocalPath -eq $localpath} | Remove-WmiObject     
        }
