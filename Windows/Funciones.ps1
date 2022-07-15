"Para habilitar apagado remoto"
Get-Service -Name RemoteRegistry | Set-Service -StartupType Automatic
"Deshabilitar telemetria"
Get-Service -Name DPS | Set-Service -StartupType Disabled
Get-Service -Name DPS | Set-Service -status Stopped
Get-Service -Name DiagTrack | Set-Service -StartupType Disabled
Get-Service -Name DiagTrack | Set-Service -status Stopped