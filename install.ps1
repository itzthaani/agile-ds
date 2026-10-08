$zipUrl = "https://github.com/itzthaani/agile-ds/archive/refs/heads/main.zip"
$zipPath = "$env:TEMP\agile-ds.zip"
# Points directly to the current user's Desktop folder
$desktopPath = [Environment]::GetFolderPath("Desktop")
$extractPath = Join-Path -Path $desktopPath -ChildPath "agile-ds"
$tempExtractPath = "$env:TEMP\agile-ds-temp"

Write-Host "Downloading agile-ds..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath

if (Test-Path $tempExtractPath) { 
    Remove-Item -Path $tempExtractPath -Recurse -Force 
}

Write-Host "Extracting files..." -ForegroundColor Cyan
Expand-Archive -Path $zipPath -DestinationPath $tempExtractPath -Force

if (-not (Test-Path $extractPath)) { 
    New-Item -ItemType Directory -Path $extractPath | Out-Null 
}

# Find the nested 'agile-ds-main' directory and move its contents up directly into Desktop\agile-ds
$nestedFolder = Get-ChildItem -Path $tempExtractPath | Where-Object { $_.PSIsContainer } | Select-Object -First 1
Get-ChildItem -Path $nestedFolder.FullName | Move-Item -Destination $extractPath -Force

# Clean up temporary downloads
Remove-Item -Path $zipPath -Force
Remove-Item -Path $tempExtractPath -Recurse -Force

Write-Host "Successfully installed to $extractPath" -ForegroundColor Green
