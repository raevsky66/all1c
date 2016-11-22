rem net stop "1C:Enterprise 8.3 Server Agent" && net start 1C:Enterprise 8.3 Server Agent
rem @Echo Off
Net Stop "1C:Enterprise 8.3 Server Agent"
PING -n 1 -w 10000 192.168.253.253 > nul
:ReStartService
Net Start "1C:Enterprise 8.3 Server Agent"
SC query "1C:Enterprise 8.3 Server Agent" | find /i "1  STOPPED" > nul
if %errorlevel%==0 echo GoTo ReStartService
EXIT