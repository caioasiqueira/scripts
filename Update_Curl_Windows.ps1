#######################################################################################
# Script para corrigir Vulnerabilidade Curl 7.69 < 8.4.0 Heap Buffer Overflow         #
# Criado por Caio Siqueira                                                            #
# Versão 4.0 - Curl 8.4.0                                                             #
#######################################################################################

# Versão x64
# Backup do Arquivo Curl
Remove-Item -Path "C:\Windows\System32\curlx64.exe.old" -Force
Copy-Item -Path "C:\Windows\System32\curl.exe" -Destination "C:\Windows\System32\curlx64.exe.old"

# Permissionamento no arquivo Curl para Full Control
takeown /A /F "C:\Windows\System32\curl.exe"
$NewAcl = Get-Acl -Path "C:\Windows\System32\curl.exe"
$identity = "BUILTIN\Administrators"
$fileSystemRights = "FullControl"
$type = "Allow"
$fileSystemAccessRuleArgumentList = $identity, $fileSystemRights, $type
$fileSystemAccessRule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $fileSystemAccessRuleArgumentList
$NewAcl.SetAccessRule($fileSystemAccessRule)
Set-Acl -Path "C:\Windows\System32\curl.exe" -AclObject $NewAcl

# Remoção do arquivo Curl
Remove-Item -Path "C:\Windows\System32\curl.exe" -Force

# Cópia do novo arquivo atualizado
$URL = "http://bigfix:52311/Uploads/x64/8.4.0/curl.exe"
$Path= "C:\Windows\System32\curl.exe"
Invoke-WebRequest -URI $URL -OutFile $Path


# Versão x86
# Backup do Arquivo Curl
Remove-Item -Path "C:\Windows\SysWOW64\curlx86.exe.old" -Force
Copy-Item -Path "C:\Windows\SysWOW64\curl.exe" -Destination "C:\Windows\SysWOW64\curlx86.exe.old"

# Permissionamento no arquivo Curl para Full Control
takeown /A /F "C:\Windows\SysWOW64\curl.exe"
$NewAcl = Get-Acl -Path "C:\Windows\SysWOW64\curl.exe"
$identity = "BUILTIN\Administrators"
$fileSystemRights = "FullControl"
$type = "Allow"
$fileSystemAccessRuleArgumentList = $identity, $fileSystemRights, $type
$fileSystemAccessRule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $fileSystemAccessRuleArgumentList
$NewAcl.SetAccessRule($fileSystemAccessRule)
Set-Acl -Path "C:\Windows\SysWOW64\curl.exe" -AclObject $NewAcl

# Remoção do arquivo Curl
Remove-Item -Path "C:\Windows\SysWOW64\curl.exe" -Force

# Cópia do novo arquivo atualizado
$URL = "http://bigfix:52311/Uploads/x86/8.4.0/curl.exe"
$Path= "C:\Windows\SysWOW64\curl.exe"
Invoke-WebRequest -URI $URL -OutFile $Path
