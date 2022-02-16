# This script takes in a list of IP addresses and saves them in the
# CodeMeter server search list in the Windows registry

# CodeMeter configuration on Windows can also be done with a
# CodeMeter.ini file placed next to CodeMeter.exe (Usually at
# \Program Files (x86)\CodeMeter\Runtime\bin\CodeMeter.ini)

# To generate this file, stop the CodeMeter service, place an empty
# file at the correct location with the correct name, and then
# restart the CodeMeter service. This causes CodeMeter to dump the
# current config held in the Windows registry into the file. You can
# then use that file as a template for your own modifications.

# Example:
# Stop-Service CodeMeter.exe
# New-Item -Type File -Path 'Program Files (x86)\CodeMeter\Runtime\bin\CodeMeter.ini'
# Start-Service CodeMeter.exe
# type 'Program Files (x86)\CodeMeter\Runtime\bin\CodeMeter.ini' # Causes contents to print to screen

Write-Host "Configuring CodeMeter..."

### ENABLES REMOTE WEB ADMIN ###
# New-Item -Path HKLM:\SOFTWARE\WIBU-SYSTEMS\CodeMeter\Server\CurrentVersion\HTTP -Force
# New-ItemProperty -Path HKLM:\SOFTWARE\WIBU-SYSTEMS\CodeMeter\Server\CurrentVersion\HTTP -Name RemoteRead -Value 2
################################

### ADD SERVER ADDRESSES ###
for ($i = 0; $i -lt $args.count; $i++) {
		$j = $i + 1
		Write-Host "Saving $($args[$i]) to server $j in search list"
		#New-Item -Path HKLM:\SOFTWARE\WIBU-SYSTEMS\CodeMeter\Server\CurrentVersion\ServerSearchList\Server$j -Force
		#New-ItemProperty -Path HKLM:\SOFTWARE\WIBU-SYSTEMS\CodeMeter\Server\CurrentVersion\ServerSearchList\Server$j -Name Address -Value $args[$i]
}

### RESTART SERVICE ###
Write-Host "Restarting CodeMeter"
Restart-Service CodeMeter.exe


Write-Host "Configuration of CodeMeter complete."