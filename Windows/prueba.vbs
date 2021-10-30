Dim wshShell, RegKey
Set wshShell = Wscript.CreateObject("Wscript.Shell")
msgIntro = msgBox("Este script deshabilitará la paginación del nucleo" & vbCrlf & "Desea continuar?", vbYesNo+vbQuestion)
If msgIntro = vbNo then Wscript.Quit

RegKey = "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\"
wshShell.regWrite RegKey & "DisablePagingExecutive", 00000001, "REG_DWORD"
Set objWshell = Nothing
Wscript.Quit