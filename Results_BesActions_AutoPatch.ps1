####################################################################################
# Script para exportar em CSV informaçoes dos Resultados das Actions Bigfix        #
# Criado por Caio Siqueira                                                         #
# Versão 2.0 - Patches                                                             #
####################################################################################

## Ignorar SSL Invoke-RestMethod
add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Ssl3, [Net.SecurityProtocolType]::Tls, [Net.SecurityProtocolType]::Tls11, [Net.SecurityProtocolType]::Tls12

## Usuario e senha com permissao no BIGFIX
$usuario = "xxxx"
$encrypted = "01000000d08c9ddf0115d1118c7a00c04fc297eb010000008252199c99237f4b8417cd837a7170470000000002000000000003660000c000000010000000912b0ff2f1786ce527ad07615eec9e0e0000000004800000a000000010000000b926c6a7e064f899a5ddd26836bfe8eb200000009057787a58d6a30a4d40af5392c4fbe6600d4116a220dc7a46fb004b1ac8405c140000006b6f82426e3a030c57a411fbea003e159eb16cb3"
$pass = ConvertTo-SecureString -string $encrypted
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $usuario, $pass

## Get na API do Bigfix para buscar os IDs das Actions de Auto Patch nos últimos 365 dias
$uri = "https://bigfix:52311"
$apiquery = "/api/query"
$queryactionids = "?relevance=(ids%20of%20it)%20of%20bes%20actions%20whose%20(name%20of%20it%20contains%20%22PP_Auto%20Patch%22%20and%20now%20-%20time%20issued%20of%20it%20%3C%20365%20*%20day%20)"
$besqueryids = $uri + $apiquery + $queryactionids
$xmlqueryids = Invoke-RestMethod -Method GET -Credential $cred -Uri $besqueryids
$actionids = $xmlqueryids.BESAPI.Query.Result.Answer."#text" | %{ $_.Split('.')[0]; }

## Get na API do Bigfix para buscar os resultados das Actions e extrair o detalhe das informações
$api = "/api/action/"
$actionstatus = "/status"

foreach ($actionid in $actionids)
{
    $querybesactions = $uri + $api + $actionid + $actionstatus
    $querybesactionname = $uri + $api + $actionid
    $xmlactionname = Invoke-RestMethod -Method GET -Credential $cred -Uri $querybesactionname
    $xmlaction = Invoke-RestMethod -Method GET -Credential $cred -Uri $querybesactions
    $actionname = $xmlactionname.BES.MultipleActionGroup.Title
    $actionidresults = $xmlaction.BESAPI.ActionResults.MemberActionResult.ActionID

    foreach ($actionidresult in $actionidresults)
    {
        $querybesactionsresult = $uri + $api + $actionidresult + $actionstatus
        $querybesactionnameresult = $uri + $api + $actionidresult
        $xmlactionnameresult = Invoke-RestMethod -Method GET -Credential $cred -Uri $querybesactionnameresult
        $xmlactionresult = Invoke-RestMethod -Method GET -Credential $cred -Uri $querybesactionsresult
        $actionnameresult = $xmlactionnameresult.BES.SingleAction.Title
        $actiondetails = $xmlactionresult.BESAPI.ActionResults.Computer
        $actiondetails | select @{l="Action";e={$actionname}}, @{l="ActionDetail";e={$actionnameresult}}, Name, Status, StartTime, EndTime | Export-Csv -Path .\besactions_autopatches_v2.csv -NoTypeInformation -Append
    }
}
