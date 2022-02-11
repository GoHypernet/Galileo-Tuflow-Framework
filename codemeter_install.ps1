Write-Host "Downloading CodeMeter runtime installer..."
# Find direct link at https://www.wibu.com/support/user/user-software.html
# Link for Windows version 7.40 2021-12-17 multilanguage 64-bit
ARG CODEMETER_URL=https://www.wibu.com/support/user/user-software/file/download/8858.html?tx_wibudownloads_downloadlist%5BdirectDownload%5D=1&tx_wibudownloads_downloadlist%5BuseAwsS3%5D=0&cHash=1357cb7ae0883c984f3d6b130dc16a96
RUN powershell.exe -Command "Invoke-WebRequest -Uri $CODEMETER_URL -OutFile ./codemeter.exe

Write-Host "Installing CodeMeter runtime..."
Start-Process ./codemeter.exe -ArgumentList "/ComponentArgs ""*"":""/qn""" -Wait -Verbose

Write-Host "Done installing CodeMeter runtime"
