$token = "***"
$chat_id = "****"
$text = Get-Content -Path 'C:\Users\User\Desktop\networks.pdf'
$URI = "https://api.telegram.org/bot" + $token + "/sendMessage?chat_id=" + $chat_id + "&text=" + $text
$Request = Invoke-RestMethod -URI ($URI) 