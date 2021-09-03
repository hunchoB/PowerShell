$pathToFile = "C:\Users\a.bobkov\Desktop\events.csv.zip"
Expand-Archive -Path $pathToFile -DestinationPath $pathToFile.Replace(".zip","")
Remove-Item -Path $pathToFile