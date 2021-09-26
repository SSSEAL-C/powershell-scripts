$imgPath = "File Path Goes Here"
$ClientID = "imgur client id" #Follow Steps Here https://ghostbin.com/yDrAJ
$imgInBase64 = [convert]::ToBase64String((get-content $imgPath -encoding byte))
$upload = Invoke-WebRequest -UseBasicParsing -uri "https://api.imgur.com/3/image" -method POST -body $imgInBase64 -headers @{"Authorization" = "Client-ID $ClientID"}
$Content = $upload.content|ConvertFrom-Json
$link = $Content.data.link
