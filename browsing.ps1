$url = 'http://10.61.63.13/#ids_main_wrapper/events_tabs/events_live'

# ----------------Enter credentials----------------------------------
# $username = Read-Host 'Enter Login'
# $passwordSecureString = Read-Host 'Enter password' -AsSecureString
# $passwdPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
#     [Runtime.InteropServices.Marshal]::SecureStringToBSTR($passwordSecureString))
# ---------------------------------------------------------------------

# ----------------------Autorization Form-----------------------------
$ie = New-Object -comobject InternetExplorer.Application 
$ie.visible = $true 
$ie.silent = $true 
$ie.Navigate( $url )
while( $ie.busy){Start-Sleep 1}
$ie.Document.getElementById("textfield-1185-inputEl").value = #$username
$ie.Document.getElementById("textfield-1187-inputEl").value =  #$passwdPlain
($ie.Document.getElementsByTagName("a") | ? { $_.className -eq "x-btn app-login-button x-unselectable x-box-item x-btn-default-small x-noicon x-btn-noicon x-btn-default-small-noicon"}).click()
Start-Sleep -Seconds '10'
#----------------------------Search all need info and download-------------------------------------------
($ie.Document.getElementById("tab-2502")).click()
while( $ie.busy){Start-Sleep 1}
Start-Sleep -Seconds '4'
($ie.Document.getElementById("combobox-2570-inputEl")).click()
Start-Sleep -Seconds '2'
($ie.Document.getElementsByTagName("li") | ? {$_.innerhtml -eq "REPORT"}).click()
($ie.Document.getElementById("button-2579")).click()
($ie.Document.getElementById("button-2624-btnInnerEl")).click()
Start-Sleep -Seconds '2'
$obj = new-object -com WScript.Shell
$obj.SendKeys('{TAB}')
$obj.SendKeys('{TAB}')
$obj.SendKeys('{Enter}')
# ----------------------------------------------------------------------
# --------------------Delay-----------------
# Start-Sleep -Seconds '15' ACTIVATE WHEN IT WILL BE REALIZED
# -------------------------------------------

#  -------------------------------Send message to Telegram-----------------------------------------------
# $token = "***"
# $chat_id = "****"
# $text = 'C:\Users\User\Desktop\networks.pdf'
# $URI = "https://api.telegram.org/bot" + $token + "/sendMessage?chat_id=" + $chat_id + "&text=" + $text
# $Request = Invoke-RestMethod -URI ($URI)
#  ------------------------------------------------------------------------------------------------------ 