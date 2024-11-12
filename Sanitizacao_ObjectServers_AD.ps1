$daysInactive = 60
$inactiveDate = (Get-Date).AddDays(-$daysInactive)
#$computers = (Get-ADComputer -Filter { ((LastLogonTimestamp -lt $inactiveDate) -and (OperatingSystem -like "*Server*")) -or ((LastLogonTimestamp -lt $inactiveDate) -and (OperatingSystem -like "*linux*"))} -Properties LastLogonTimestamp, OperatingSystem, DistinguishedName).Name | Where-Object {$_ -NotLike "*CNF:*"}
$computers = Get-Content -Path "C:\Temp\servers.txt"
foreach ($computer in $computers) 
{           

#$date = Get-Date
$Name = (Get-ADComputer -Identity $computer).Name
$OS = (Get-ADComputer -Identity $computer -Properties OperatingSystem).OperatingSystem
$OU = (Get-ADComputer -Identity $computer -Properties DistinguishedName).DistinguishedName.Split(',')[1].split('=')[1]
$LastLogonTimestamp = (Get-ADComputer -Identity $computer -Properties LastLogonTimestamp).LastLogonTimestamp
$LastLogonTime = [datetime]::FromFileTime($LastLogonTimestamp)
$namedel = $computer + "*"
Get-ADComputer -Identity $computer | Remove-ADComputer -Confirm:$False
$IsDeleted = (get-adobject -filter 'name -like $namedel' -IncludeDeletedObjects -properties IsDeleted).Deleted
$WhenDeleted = (get-adobject -filter 'name -like $namedel' -IncludeDeletedObjects -properties WhenChanged).WhenChanged
 New-Object -TypeName PSCustomObject -Property @{
    Name=$Name
    OS=$OS
    LastLogonTimestamp=$LastLogonTime
    OU=$OU
    Deleted=$IsDeleted
    Execucao=$WhenDeleted
 }|Export-Csv -path C:\temp\sanitizacao.csv -NoTypeInformation -Append
}
