####################################################################################
# Script para corrigir Vulnerabilidade .NET Core SEoL                              #
# Criado por Caio Siqueira                                                         #
# Versão 1.0 - .NETCore Runtime                                                    #
####################################################################################

# Variáveis
$URL = "https://github.com/dotnet/cli-lab/releases/download/1.7.550802/dotnet-core-uninstall-1.7.550802.msi"
$Path= "C:\temp\dotnet-core-uninstall-1.7.550802.msi"
$PathNet64 = "C:\Program Files\dotnet\shared\Microsoft.NETCore.App"
$PathNet32 = "C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App"

# Download da ferramenta de remoção do .NETCore
Invoke-WebRequest -URI $URL -OutFile $Path

# Instalação da ferramenta de remoção do .NETCore
msiexec.exe /I $Path /quiet 
Start-Sleep -Seconds 30

# Captura as versões existentes na pasta e realiza a remoção via ferramenta
# 64 Bits
$versions = Get-Childitem -Path $PathNet64 | where-object {($_.Name -ilike "1.*" -or $_.Name -ilike "2.*" -or $_.Name -ilike "3.*" -or $_.Name -ilike "5.*" -or $_.Name -ilike "7.*")} | select -ExpandProperty Name

cd "C:\Program Files (x86)\dotnet-core-uninstall"

foreach ($version in $versions)
{
    .\dotnet-core-uninstall remove $version --x64 --runtime --force --yes
}

# 32 Bits
$versions = Get-Childitem -Path $PathNet32 | where-object {($_.Name -ilike "1.*" -or $_.Name -ilike "2.*" -or $_.Name -ilike "3.*" -or $_.Name -ilike "5.*" -or $_.Name -ilike "7.*")} | select -ExpandProperty Name

cd "C:\Program Files (x86)\dotnet-core-uninstall"

foreach ($version in $versions)
{
    .\dotnet-core-uninstall remove $version --x86 --runtime --force --yes
}

# Valida se ainda existe alguma pasta com versão obsoleta e realiza a remoção
# 64 Bits
Get-Childitem -Path $PathNet64 | where-object {($_.Name -ilike "1.*" -or $_.Name -ilike "2.*" -or $_.Name -ilike "3.*" -or $_.Name -ilike "5.*" -or $_.Name -ilike "7.*")} | Remove-Item -Force -Recurse

# 32 Bits
Get-Childitem -Path $PathNet32 | where-object {($_.Name -ilike "1.*" -or $_.Name -ilike "2.*" -or $_.Name -ilike "3.*" -or $_.Name -ilike "5.*" -or $_.Name -ilike "7.*")} | Remove-Item -Force -Recurse
