$pathToFile = "C:\Users\a.bobkov\Downloads\events.csv.zip"
Expand-Archive -Path $pathToFile -DestinationPath $pathToFile.Replace(".zip","")
Remove-Item -Path $pathToFile