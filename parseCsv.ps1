# -----------------------------Search needed Events in CSV--------------------------------------------
$pathToParse = "C:\Users\a.bobkov\Downloads\events.csv\events.csv"
$SearchItems = "trojan-activity","attempted-dos", "malware-cnc", "web-application-attack"

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
# ------------------------------------------------------------------------------------------------------
$Results
Remove-Item -Path "C:\Users\a.bobkov\Downloads\events.csv" -Recurse -Force -Confirm:$false