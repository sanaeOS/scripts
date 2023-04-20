@echo off
color 06

@echo [+] flushing dns
ipconfig /flushdns

@echo [+] deleting logs
cd/
del *.log /a /s /q /f

@echo [+] deleting cache

RD /S /Q %temp%
MKDIR %temp%
takeown /f "%temp%" /r /d y
takeown /f "C:\Windows\Temp" /r /d y
RD /S /Q C:\Windows\Temp
MKDIR C:\Windows\Temp
takeown /f "C:\Windows\Temp" /r /d y
takeown /f %temp% /r /d y
pause
