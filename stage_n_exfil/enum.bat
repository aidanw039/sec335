whoami /all > C:\temp\whoami.log 2>&1
tasklist > C:\temp\processes.log 2>&1
netstat > C:\temp\conn.log 2>&1
net start > C:\temp\services.log 2>&1
net user > C:\temp\users.log 2>&1
net localgroup > C:\temp\groups.log 2>&1
net localgroup "Administrators" > C:\temp\admin_members.log 2>&1
ipconfig /all > C:\temp\net.log 2>&1
netsh advfirewall firewall show rule name=all > C:\temp\firewall_rules.log 2>&1
arp -a > C:\temp\arptable.log 2>&1
net sessions > C:\temp\smb_sess.log 2>&1
systeminfo > C:\temp\sysinfo.log
quser > C:\temp\rdp_sess 2>&1
route.exe print > C:\temp\routes.log 2>&1
sc.exe queryex type=driver > C:\temp\drivers.log 2>&1
sc.exe queryex type=service status=all > C:\temp\service_ex.log 2>&1
wmic.exe product get name > C:\temp\products.log 2>&1

C:\temp\7za.exe -a  C:\temp\enums.zip "C:\temp\*.log" -pcompressed
