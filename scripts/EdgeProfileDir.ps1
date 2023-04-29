Start-Process -Verb RunAs powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "reg add \"HKLM\SOFTWARE\Policies\Microsoft\Edge\" /v UserDataDir /t REG_SZ /d \"C:\profile\" /f"'
