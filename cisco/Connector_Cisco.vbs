'Получение ip, пароля и enable пароля
Set ArgObj = WScript.Arguments 
cisco_ip = ArgObj.Item(0)
cisco_user = ArgObj.Item(1)
cisco_pass = ArgObj.Item(2)
cisco_enable = ArgObj.Item(3)

'Поиск putty
Set objFSO = WScript.CreateObject("Scripting.FileSystemObject")
If objFSO.FileExists("C:\windows\system32\putty.exe") Then putty = """C:\windows\system32\putty.exe"""
If objFSO.FileExists("C:\Program Files (x86)\PuTTY\putty.exe") Then putty = """C:\Program Files (x86)\PuTTY\putty.exe"""
If objFSO.FileExists("C:\Program Files\PuTTY\putty.exe") Then putty = """C:\Program Files\PuTTY\putty.exe"""
If putty = "" then WScript.Echo "putty not found at:" & vbCrLf & "1. C:\windows\system32\putty.exe" & vbCrLf & "2. C:\Program Files (x86)\PuTTY\putty.exe" & vbCrLf & "3. C:\Program Files\PuTTY\putty.exe"

'Проверка уже установленного соединения
Dim WshShell, oExec
Set WshShell = CreateObject("WScript.Shell")
oExec = WshShell.Exec("tasklist /v /NH /fo csv /FI ""WINDOWTITLE eq "+cisco_ip+"*""").StdOut.ReadAll()
Set objRegExp = CreateObject("VBScript.RegExp")
objRegExp.Pattern = "" + cisco_ip+ " - PuTTY"""

'Проверяем есть ли уже запущенное окно коннекта к данной Cisco
If objRegExp.Test(oExec) = True Then
    WshShell.AppActivate cisco_ip & " - PuTTY"
Else
    'Запуск putty c параметрами
	Return = WshShell.Run (putty & " -ssh " & cisco_ip & " -l " & cisco_user & " -pw " & cisco_pass, 1, false) 

	'Вычисление паузы
	WScript.Sleep(1500)

	'Enable Cisco
	WshShell.AppActivate cisco_ip & " - PuTTY"
	WshShell.SendKeys "enable"
	WshShell.SendKeys "{ENTER}"
	WshShell.SendKeys cisco_enable
	WshShell.SendKeys "{ENTER}"
End If
