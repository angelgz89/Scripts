@echo off
cls
@echo ----------------------------------------------------------------------
@echo                           Configuracion
@echo ----------------------------------------------------------------------
@echo.
@echo  Este script:
@echo       - Habilita los scripts de powershell
@echo       - Habilita el apagado remoto de windows
@echo       - Oculta los archivos recientes en acceso rapido
@echo       - Ocultar archivos recientes en acceso rapido
@echo       - Ocultar archivos recientes en menu de inicio
@echo       - Deshabilita IPv6
@echo       - Iniciar explorador de archivos en mi PC
@echo       - Elimina historial de archivos recientes al cerrar sesion
@echo       - 
@echo.
@echo.
@echo ----------------------------------------------------------------------

pause

@REM @echo Habilitando Scripts de powershell para este usuario 
@REM :: powershell.exe -executionpolicy RemoteSigned -File XXXX.ps1

@echo.

cd C:\Users\MiniServer\Desktop
@echo.
powershell.exe -executionpolicy RemoteSigned -File Funciones.ps1
cd
@echo Habilitando apagado remoto
@REM ::Registro
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
pause

@echo.
echo Deshabilitando telemetria
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection /v AllowTelemetry /t REG_DWORD /d 0 /f

@echo.
echo Ocultando archivos recientes en acceso rapido
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoRecentDocsHistory /t REG_DWORD /d 1 /f

@echo.
@echo Deshabilitando IPv6 ...
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\TCPIP6\Parameters /v NoRecentDocsHistory /t REG_DWORD /d 4294967295
::[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\TCPIP6\Parameters]
::"DisabledComponents"=dword:ffffffff

@echo.
@echo Iniciar explorador de archivos en mi PC
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v LaunchTo /t REG_DWORD /d 1 /f

@echo.
@echo Ocultar archivos recientes en acceso rapido
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoRecentDocsHistory /t REG_DWORD /d 1 /f

@echo.
@echo Ocultar archivos recientes en menu de inicio
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoRecentDocsMenu /t REG_DWORD /d 1 /f

@echo.
@echo Eliminar historial de archivos recientes al cerrar sesion
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v ClearRecentDocsOnExit /t REG_DWORD /d 1 /f

@echo.
@echo Deshabilitando tareas programadas innecesarias ...
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsToastTask" /disable
schtasks /Change /TN "Microsoft\Windows\HelloFace\FODCleanupTask" /disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable

@echo.
@echo ---------------------------------------------------------------------
@echo                       EJECUCION FINALIZADA 
@echo ---------------------------------------------------------------------
pause
cls






@REM @echo Deshabilitando Dr Watson ...
@REM del c:\scripts\drwatson.reg
@REM reg export "HKLM\Software\Microsoft\Windows NT\CurrentVersion\AeDebug" c:\scripts\drwatson.reg
@REM reg delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\AeDebug" /f
@REM @echo.


@REM @echo Deshabilitando POSIX ...
@REM reg import c:\scripts\posix.reg
@REM @echo.


@REM :: No mover fichero a la papelera de reciclaje
@REM reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoRecycleFiles /t REG_DWORD /d 1 /f
@REM reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v ConfirmFileDelete /t REG_DWORD /d 1 /f


@REM :: Ocultar opcion contextual Compartir
@REM reg delete HKCR\*\shellex\ContextMenuHandlers\ModernSharing /ve /f

