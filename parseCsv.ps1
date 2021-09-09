# -----------------------------Search needed Events in CSV--------------------------------------------
$pathToFile = "C:\Users\a.bobkov\Desktop\events.csv\events.csv"
$SearchItems = "icmp-event","check"

$GrpObjResults = Import-Csv $pathToFile -Delimiter ";" | Where-Object {$_.Class -in $SearchItems} | Group-Object Class -NoElement

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
# Remove-Item -Path $pathToFile -Force