# Pasta dos SCCM Cache
Remove-Item -Path C:\Windows\ccmcache\* -Recurse

# Pasta dos Trace Logs do Service Fabric (7 dias)
If (test-path "C:\ProgramData\Microsoft Service Fabric\Log\Traces") {Get-ChildItem -Path "C:\ProgramData\Microsoft Service Fabric\Log\Traces" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item}

# Pasta do LiveKernelReports (7 dias)
if (test-path "C:\Windows\LiveKernelReports\") {Get-ChildItem -Path "C:\Windows\LiveKernelReports\" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item}

# Pasta do DebugDiag (7 dias)
if (test-path "C:\Program Files\DebugDiag\Logs\") {Get-ChildItem -Path "C:\Program Files\DebugDiag\Logs\" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item}

# Pasta do Winodws\Temp (7 dias)
if (test-path "C:\Windows\Temp") {Get-ChildItem -Path "C:\Windows\Temp\" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item}

# Pastas Download do CustomSite BigFix & Cache do Global BigFix (7 dias)
Get-ChildItem -Path "C:\Program Files (x86)\BigFix Enterprise\BES Client\__BESData\CustomSite_Infraestrutura\__Download" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-1))} | Remove-Item
Get-ChildItem -Path "C:\Program Files (x86)\BigFix Enterprise\BES Client\__BESData\__Global\__Cache\Downloads" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-1))} | Remove-Item

# Pasta do Inetpub (7 dias)
if (test-path "C:\inetpub\logs\LogFiles") {Get-ChildItem -Path "C:\inetpub\logs\LogFiles" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item}
if (test-path "C:\inetpub\mailroot\Badmail") {Get-ChildItem -Path "C:\inetpub\mailroot\Badmail" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item}

# Pasta Temp (7 dias)
if (test-path "C:\Temp") {Get-ChildItem -Path "C:\Temp" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item}

# Pasta Temp do AspNet (7 dias)
if (test-path "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Temporary ASP.NET Files") {Get-ChildItem -Path "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Temporary ASP.NET Files" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item}
if (test-path "C:\Windows\Microsoft.NET\Framework\v4.0.30319\Temporary ASP.NET Files") {Get-ChildItem -Path "C:\Windows\Microsoft.NET\Framework\v4.0.30319\Temporary ASP.NET Files" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item}

# Arquivos Dump e Logs
dir "C:\Windows\*.dmp" | where { ((Get-Date)-$_.CreationTime).days -gt 7} | Remove-Item -Force
if (test-path "C:\Program Files (x86)\Kaspersky Lab\NetworkAgent\~dumps") {Get-ChildItem -Path "C:\Program Files (x86)\Kaspersky Lab\NetworkAgent\~dumps" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item}
if (test-path "C:\ProgramData\Kaspersky Lab") {dir "C:\ProgramData\Kaspersky Lab\*.dmp" | where { ((Get-Date)-$_.CreationTime).days -gt 7} | Remove-Item -Force}
if (test-path "C:\Windows\System32\config\systemprofile\AppData\Local\CrashDumps") {Get-ChildItem -Path "C:\Windows\System32\config\systemprofile\AppData\Local\CrashDumps" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item}
if (test-path "C:\Windows\ServiceProfiles\NetworkService\AppData\Local\CrashDumps") {Get-ChildItem -Path "C:\Windows\ServiceProfiles\NetworkService\AppData\Local\CrashDumps" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item}
if (test-path "C:\Windows\System32\%LOCALAPPDATA%\CrashDumps") {Get-ChildItem -Path "C:\Windows\System32\%LOCALAPPDATA%\CrashDumps" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item}
if (test-path "C:\Program Files\BMC Software\Control-M Agent\Default") {dir "C:\Program Files\BMC Software\Control-M Agent\Default\*.mdmp" | where { ((Get-Date)-$_.CreationTime).days -gt 7} | Remove-Item -Force}
if (test-path "C:\Program Files\BMC Software\Control-M Agent\Default") {dir "C:\Program Files\BMC Software\Control-M Agent\Default\*.log" | where { ((Get-Date)-$_.CreationTime).days -gt 7} | Remove-Item -Force}
if (test-path "C:\Program Files\BMC Software\Control-M Agent\Default\CM\AFT") {dir "C:\Program Files\BMC Software\Control-M Agent\Default\CM\AFT\*.mdmp" | where { ((Get-Date)-$_.CreationTime).days -gt 7} | Remove-Item -Force}
if (test-path "C:\Program Files\BMC Software\Control-M Agent\Default\CM\AFT") {dir "C:\Program Files\BMC Software\Control-M Agent\Default\CM\AFT\*.log" | where { ((Get-Date)-$_.CreationTime).days -gt 7} | Remove-Item -Force}
if (test-path "C:\Program Files\BMC Software\Control-M Agent\Default\PROCLOG") {dir "C:\Program Files\BMC Software\Control-M Agent\Default\PROCLOG\*.tmp" | where { ((Get-Date)-$_.CreationTime).days -gt 7} | Remove-Item -Force}
if (test-path "C:\Program Files\BMC Software\Control-M Agent\Default\PROCLOG") {dir "C:\Program Files\BMC Software\Control-M Agent\Default\PROCLOG\*.log" | where { ((Get-Date)-$_.CreationTime).days -gt 7} | Remove-Item -Force}
if (test-path "C:\ProgramData\FINCAD\logs") {dir "C:\ProgramData\FINCAD\logs\*.log" | where { ((Get-Date)-$_.CreationTime).days -gt 7} | Remove-Item -Force}

# Pasta Temp do Kaspersky
if (test-path "C:\ProgramData\Kaspersky Lab\Kaspersky Security for Windows Server\10.1\Bases\Temp") {Get-ChildItem -Path "C:\ProgramData\Kaspersky Lab\Kaspersky Security for Windows Server\10.1\Bases\Temp" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item}

# Pasta do HTTPERR (7 dias)
if (test-path "C:\Windows\System32\LogFiles\HTTPERR") {Get-ChildItem -Path "C:\Windows\System32\LogFiles\HTTPERR" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item}

# Arquivos pasta Users Dump (7 Dias)
$paths = Get-ChildItem -Directory c:\users | Select-Object $_.Name

ForEach ($path in $paths){
    If (test-path "c:\users\$path\AppData\Local\CrashDumps")
    {
        Get-ChildItem -Path "C:\Users\$path\AppData\Local\CrashDumps" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-item

    }
}

# Arquivos pasta Users Downloads (7 Dias)
$paths = Get-ChildItem -Directory c:\users | Select-Object $_.Name

ForEach ($path in $paths){
    If (test-path "c:\users\$path\Downloads")
    {
        Get-ChildItem -Path "C:\Users\$path\Downloads" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-item

    }
}

# Arquivos pasta Users Temp (7 Dias)
$paths = Get-ChildItem -Directory c:\users | Select-Object $_.Name

ForEach ($path in $paths){
    If (test-path "c:\users\$path\AppData\Local\Temp")
    {
        Get-ChildItem -Path "C:\Users\$path\AppData\Local\Temp" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-item

    }
}

# Arquivos pasta Users Desktop (7 Dias)
$paths = Get-ChildItem -Directory c:\users | Select-Object $_.Name

ForEach ($path in $paths){
    If (test-path "c:\users\$path\Desktop")
    {
        Get-ChildItem -Path "C:\Users\$path\Desktop" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-item

    }
}

# Arquivos pasta Users Documents (7 Dias)
$paths = Get-ChildItem -Directory c:\users | Select-Object $_.Name

ForEach ($path in $paths){
    If (test-path "c:\users\$path\Documents")
    {
        Get-ChildItem -Path "C:\Users\$path\Documents" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-item

    }
}

# Arquivos pasta Users Google Chrome Cache (7 Dias)
$paths = Get-ChildItem -Directory c:\users | Select-Object $_.Name

ForEach ($path in $paths){
    If (test-path "c:\users\$path\AppData\Local\Google\Chrome\User Data\Default\Cache")
    {
        Get-ChildItem -Path "C:\Users\$path\AppData\Local\Google\Chrome\User Data\Default\Cache" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-item

    }
}

# Arquivos pasta Users Google Chrome Code Cache (7 Dias)
$paths = Get-ChildItem -Directory c:\users | Select-Object $_.Name

ForEach ($path in $paths){
    If (test-path "c:\users\$path\AppData\Local\Google\Chrome\User Data\Default\Code Cache")
    {
        Get-ChildItem -Path "C:\Users\$path\AppData\Local\Google\Chrome\User Data\Default\Code Cache" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-item

    }
}

# Arquivos pasta Users Power Query Cache (7 Dias)
$paths = Get-ChildItem -Directory c:\users | Select-Object $_.Name

ForEach ($path in $paths){
    If (test-path "c:\users\$path\AppData\Local\Microsoft\Office\16.0\PowerQuery\Cache")
    {
        Get-ChildItem -Path "C:\Users\$path\AppData\Local\Microsoft\Office\16.0\PowerQuery\Cache" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-item

    }
}

# Arquivos pasta Users Power BI Cache (7 Dias)
$paths = Get-ChildItem -Directory c:\users | Select-Object $_.Name

ForEach ($path in $paths){
    If (test-path "c:\users\$path\AppData\Local\Microsoft\Power BI Desktop\Cache")
    {
        Get-ChildItem -Path "C:\Users\$path\AppData\Local\Microsoft\Power BI Desktop\Cache" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-item

    }
}

# Arquivos pasta Users Power BI LuciaCache (7 Dias)
$paths = Get-ChildItem -Directory c:\users | Select-Object $_.Name

ForEach ($path in $paths){
    If (test-path "c:\users\$path\AppData\Local\Microsoft\Power BI Desktop\LuciaCache")
    {
        Get-ChildItem -Path "C:\Users\$path\AppData\Local\Microsoft\Power BI Desktop\LuciaCache" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-item

    }
}

# Arquivos pasta Users Power BI TempSaves (7 Dias)
$paths = Get-ChildItem -Directory c:\users | Select-Object $_.Name

ForEach ($path in $paths){
    If (test-path "c:\users\$path\AppData\Local\Microsoft\Power BI Desktop\TempSaves")
    {
        Get-ChildItem -Path "C:\Users\$path\AppData\Local\Microsoft\Power BI Desktop\TempSaves" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-item

    }
}

# Arquivos pasta Users local npm-cache (7 Dias)
$paths = Get-ChildItem -Directory c:\users | Select-Object $_.Name

ForEach ($path in $paths){
    If (test-path "c:\users\$path\AppData\Local\npm-cache")
    {
        Get-ChildItem -Path "C:\Users\$path\AppData\Local\npm-cache" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-item

    }
}

# Arquivos pasta Users roaming npm-cache (7 Dias)
$paths = Get-ChildItem -Directory c:\users | Select-Object $_.Name

ForEach ($path in $paths){
    If (test-path "c:\users\$path\AppData\Roaming\npm-cache")
    {
        Get-ChildItem -Path "C:\Users\$path\AppData\Roaming\npm-cache" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-item

    }
}

# Arquivos pasta Users Cypress cache (7 Dias)
$paths = Get-ChildItem -Directory c:\users | Select-Object $_.Name

ForEach ($path in $paths){
    If (test-path "c:\users\$path\AppData\Local\Cypress\Cache")
    {
        Get-ChildItem -Path "C:\Users\$path\AppData\Local\Cypress\Cache" -File -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-item

    }
}

# Arquivos pasta Users Teams (7 Dias)
$paths = Get-ChildItem -Directory c:\users | Select-Object $_.Name

ForEach ($path in $paths){
    If (test-path "c:\users\$path\AppData\Roaming\Microsoft\Teams")
    {
        dir "c:\users\$path\AppData\Roaming\Microsoft\Teams\*.txt" | where { ((Get-Date)-$_.CreationTime).days -gt 7} | Remove-Item -Force
    }
}

# Lixeira do Windows
Remove-item -Path 'C:\$Recycle.Bin\*' -Recurse -Force
Clear-RecycleBin -Force 'C:\'

# Pasta Software Distribution do Windows
Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse
