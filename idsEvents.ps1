# ----------------Enter credentials----------------------------------
$username = Read-Host 'Enter Login'
$passwordSecureString = Read-Host 'Enter password' -AsSecureString
$passwdPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($passwordSecureString))
# ---------------------------------------------------------------------

Import-Module "C:\Users\a.bobkov\Desktop\script\WebDriver.dll" #  Where WebDriver.dll Selenium located
$chromeDriver = New-Object OpenQA.Selenium.Chrome.ChromeDriver

$url = 'http://10.61.63.13/#ids_main_wrapper/events_tabs/search2Set'

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
$chromeDriver.FindElementByXPath("//input[@name='period_num']").SendKeys("30") # How much days!!!!
$chromeDriver.FindElementByXPath("//a[@id='button-2672']").Click()
Start-Sleep -Seconds '40' # Determinate time untile all your events download into page
$chromeDriver.FindElementByXPath("//a[@id='button-2579']").Click()
$chromeDriver.FindElementByXPath("//a[@id='button-2738']").Click()
Start-Sleep -Seconds '120' # Determinate time untile all your events download from Chrome into folder

# ----------Close Chrome and Stop ChromeDriverProcess----------
$chromeDriver.Close() 
$chromeDriver.Quit()
# ------------------------------------------------------------- 

# ---------------------Expand Archive--------------------------
$pathToFile = "C:\Users\a.bobkov\Downloads\events.csv.zip"
Expand-Archive -Path $pathToFile -DestinationPath $pathToFile.Replace(".zip","")
Remove-Item -Path $pathToFile -Recurse -Force -Confirm:$false
# ------------------------------------------------------------- 

# -----------------------------Search needed Events in CSV--------------------------------------------
$pathToParse = "C:\Users\a.bobkov\Downloads\events.csv\events.csv"
$SearchItems = "trojan-activity","attempted-dos", "malware-cnc", "web-application-attack" # List of events 

$GrpObjResults = Import-Csv $pathToParse -Delimiter ";" | Where-Object {$_.Class -in $SearchItems} | Group-Object Class -NoElement

$ObjProps = @{
    Name = [String]
    Count = [int]
}

$Results = @()

Foreach($Term in $SearchItems){
    $ListEntry = New-Object -TypeName PSObject -Property $ObjProps
    $ListEntry.Name = $Term
    $ListEntry.Count = ($GrpObjResults | Where-Object {$_.Name -eq $Term}).Count
    $Results += $ListEntry
}
$text = $Results | Out-String
Remove-Item -Path "C:\Users\a.bobkov\Downloads\events.csv" -Recurse -Force -Confirm:$false
# ------------------------------------------------------------------------------------------------------

#  -------------------------------Send message to Telegram-----------------------------------------------
$token = "*****"
$chat_id = "*******"
$URI = "https://api.telegram.org/bot" + $token + "/sendMessage?chat_id=" + $chat_id + "&text=" + $text
$Request = Invoke-RestMethod -URI ($URI)
#  ------------------------------------------------------------------------------------------------------ 