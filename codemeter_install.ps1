Write-Host "Downloading CodeMeter runtime installer..."
# Find direct link at https://www.wibu.com/support/user/user-software.html
# Link for Windows version 7.40 2021-12-17 multilanguage 64-bit
Invoke-WebRequest -Uri $Env:CODEMETER_URL -OutFile ./codemeter.exe

Write-Host "Installing CodeMeter runtime..."
Start-Process ./codemeter.exe -ArgumentList "/ComponentArgs ""*"":""/qn""" -Wait -Verbose

Write-Host "Done installing CodeMeter runtime"