$url = 'https://updateids.infotecs.ru/#updatesRulesBase'

Import-Module "D:\vscodeProjects\PowerShell\WebDriver.dll"
$chromeDriver = New-Object OpenQA.Selenium.Chrome.ChromeDriver
$chromeDriver.Navigate().GoToUrl($url)

$chromeDriver.FindElementByXPath("//input[@name='login']").SendKeys('******')
$chromeDriver.FindElementByXPath("//input[@name='password']").SendKeys('*****')
$chromeDriver.FindElementByXPath("//div[contains(text(),'Log on')]").Click()
Start-Sleep -Seconds '5'
$chromeDriver.FindElementByXPath("//div[contains(text(),'ver.2.4')]").Click()
Start-Sleep -Seconds '3'
$chromeDriver.FindElementByXPath("//a[@id='button-1068']").Click()
Start-Sleep -Seconds '15'
$chromeDriver.Close() 
$chromeDriver.Quit()