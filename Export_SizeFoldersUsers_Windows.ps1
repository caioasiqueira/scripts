####################################################################################
# Script para exportar em texto o tamanho das pastas do C:\Users                   #
# Criado por Caio Siqueira                                                         #
# Versão 2.0                                                                       #
####################################################################################

$targetfolder = 'C:\Users'
$outputFile = 'C:\temp\userssize.csv'
$dataColl = Get-ChildItem -Force $targetfolder -Directory -ErrorAction SilentlyContinue | ForEach-Object {
   $len = Get-ChildItem -Recurse -Force $_.FullName -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum | Select-Object -ExpandProperty Sum
   $foldername = $_.FullName
   $foldersize = '{0:N2} GB' -f ($len / 1Gb)
   [PSCustomObject]@{
       foldername = $foldername
       foldersizeGb = $foldersize
   }
}
#Export the Result
$dataColl | Format-Table -HideTableHeaders | Out-File -FilePath "C:\temp\folderssize.txt"
