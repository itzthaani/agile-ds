$zipUrl = "https://github.com/user/repository/archive/refs/heads/main.zip"
$zipPath = "$env:TEMP\agile-ds.zip"
$extractPath = ".\agile-ds"

# 1. Download the zip file
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath

# 2. Extract to a temporary folder to handle nested structure
$tempExtractPath = "$env:TEMP\agile-ds-temp"
if (Test-Path $tempExtractPath) { Remove-Item -Path $tempExtractPath -Recurse -Force }
Expand-Archive -Path $zipPath -DestinationPath $tempExtractPath -Force

# 3. Move contents from the nested folder directly into the target folder
if (-not (Test-Path $extractPath)) { New-Item -ItemType Directory -Path $extractPath | Out-Null }

$nestedFolder = Get-ChildItem -Path $tempExtractPath | Where-Object { $_.PSIsContainer } | Select-Object -First 1
Get-ChildItem -Path $nestedFolder.FullName | Move-Item -Destination $extractPath -Force

# 4. Cleanup temporary files
Remove-Item -Path $zipPath -Force
Remove-Item -Path $tempExtractPath -Recurse -Force
