' Written by Harley Schaeffer 8:57 AM 4/30/2019 version 1.1
Set getShell = WScript.CreateObject("WScript.Shell")
getShell.run ("explorer.exe Shell:::{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0}")
wscript.Sleep 500
getShell.Sendkeys "REPLACEME\scripts\remoteget.bat"
getShell.SendKeys "{ENTER}"
