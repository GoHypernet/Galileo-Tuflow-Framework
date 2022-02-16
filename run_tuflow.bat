powershell -command "Expand-Archive -DestinationPath . -Force '%MODELARCHIVE%'"
powershell -command "Remove-Item -Path '%MODELARCHIVE%%'"
powershell -command "Write-Host 'Configuring CodeMeter...'"
"\Program Files (x86)\CodeMeter\Runtime\bin\cmu32.exe" --add-server %CODEMETERADDRESS%
powershell -command "Restart-Service CodeMeter.exe"
cd %RUNS_DIR%
".\%TUFLOW_BAT%"