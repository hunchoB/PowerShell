$url = 'http://10.61.63.13/#ids_main_wrapper/events_tabs/search2Set'
#  ----------------Enter credentials----------------------------------
$username = Read-Host 'Enter Login'
$passwordSecureString = Read-Host 'Enter password' -AsSecureString
$passwdPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($passwordSecureString))
# # ---------------------------------------------------------------------


Import-Module "C:\Users\a.bobkov\Desktop\script\WebDriver.dll"
$chromeDriver = New-Object OpenQA.Selenium.Chrome.ChromeDriver
$chromeDriver.Navigate().GoToUrl($url)
$chromeDriver.FindElementById("textfield-1185-inputEl").SendKeys($username)
$chromeDriver.FindElementById("textfield-1187-inputEl").SendKeys($passwdPlain)
$chromeDriver.FindElementById("button-1190-btnWrap").Click()

$chromeDriver.FindElementByXPath("//a[@class='x-tab addNewReportSet-button x-unselectable x-tab-after-title x-box-item x-tab-default x-noicon x-tab-noicon x-tab-default-noicon x-top x-tab-top x-tab-default-top']").Click()

$chromeDriver.FindElementByXPath("//input[@id='combobox-2570-inputEl']").Click()
$chromeDriver.FindElementByXPath("//li[@class='add-new-filter']").Click() 
$chromeDriver.FindElementByXPath("//input[@name='eventClass']").Click()

$chromeDriver.FindElementByXPath("//li[contains(text(),'web-application-attack')]").Click()
$chromeDriver.FindElementByXPath("//li[contains(text(),'attempted-dos')]").Click()
$chromeDriver.FindElementByXPath("//li[contains(text(),'malware-cnc')]").Click()
$chromeDriver.FindElementByXPath("//li[contains(text(),'trojan-activity')]").Click()
$chromeDriver.FindElementByXPath("//input[@name='period_num']").Clear()
$chromeDriver.FindElementByXPath("//input[@name='period_num']").SendKeys("60")
$chromeDriver.FindElementByXPath("//a[@id='button-2672']").Click()
Start-Sleep -Seconds '15'
$chromeDriver.FindElementByXPath("//a[@id='button-2579']").Click()
$chromeDriver.FindElementByXPath("//a[@id='button-2738']").Click()
Start-Sleep -Seconds '15'
# # ----------Close Chrome and Stop ChromeDriverProcess----------
$chromeDriver.Close() 
$chromeDriver.Quit()
# # ------------------------------------------------------------- 


# # --------------------Delay-----------------
# # Start-Sleep -Seconds '15'   #ACTIVATE WHEN IT WILL BE REALIZED
# # -------------------------------------------

#  -------------------------------Send message to Telegram-----------------------------------------------
$token = "******"
$chat_id = "*****"
$URI = "https://api.telegram.org/bot" + $token + "/sendMessage?chat_id=" + $chat_id + "&text=" + $text
$Request = Invoke-RestMethod -URI ($URI)
#------------------------------------------------------------------------------------------------------ 