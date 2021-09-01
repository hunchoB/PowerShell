$url = 'https://account.habr.com/login/?state=30d8674ee45901b22eed19ac36f01344&consumer=habr&hl=ru_RU'

# ----------------Enter credentials----------------------------------
$username = Read-Host 'Enter Login'
$passwordSecureString = Read-Host 'Enter password' -AsSecureString
$passwdPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($passwordSecureString))
# ---------------------------------------------------------------------
# ----------------------Autorization Form-----------------------------
$ie = New-Object -comobject InternetExplorer.Application 
$ie.visible = $true 
$ie.silent = $true 
$ie.Navigate( $url )
while( $ie.busy){Start-Sleep 1}
$ie.Document.getElementById("email_field").value = $username
$ie.Document.getElementById("password_field").value = $passwdPlain
$confirmButtom = $ie.Document.getElementsByTagName("button")
$confirmButtom.click()
# ----------------------------------------------------------------------
# Start-Sleep -Seconds '15'
# $ie.Navigate( 'google.com' )
# Start-Process -FilePath 'C:\Program Files\Google\Chrome\Application\chrome.exe' -ArgumentList $url




# --------------------Delay-----------------
# Start-Sleep -Seconds '15'
# --------------------Delay-----------------

# Stop-Process -Name 'Chrome' 

#  -------------------------------Send message to Telegram-----------------------------------------------
# $token = "***"
# $chat_id = "****"
# $text = 'C:\Users\User\Desktop\networks.pdf'
# $URI = "https://api.telegram.org/bot" + $token + "/sendMessage?chat_id=" + $chat_id + "&text=" + $text
# $Request = Invoke-RestMethod -URI ($URI)
#  ------------------------------------------------------------------------------------------------------ 