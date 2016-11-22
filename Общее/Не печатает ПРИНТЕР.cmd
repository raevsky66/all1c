net stop spooler
del /f /q %systemroot%\system32\spool\printers\*.shd
del /f /q %systemroot%\system32\spool\printers\*.spl
net start spooler