
:: > From-pErfo

@echo off
title windows_Buffer_�����Ż�����
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (
	echo [!] �ѻ�ȡ����ԱȨ��
	goto UACAdmin
)
:UACPrompt
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B
:UACAdmin

:: ���������ӳ� !n!
setlocal enabledelayedexpansion

echo windows Buffer �����Ż�����
echo.
set /p input=[1]�ָ��Ż�ǰ������  [Enter]����: 
if !input! equ 1 (
	echo.
	rem echo �ָ���������
	rem start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\RpcEptMapper" /v Start /t reg_dword /d 3 /f
	rem start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache" /v Start /t reg_dword /d 3 /f
	rem echo.
	rem echo �ָ�MaxCacheTtl
	rem echo.
	rem start /wait /b reg delete "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheTtl /f
	rem echo.
	echo �ָ� Buffer
	start /wait /b reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /f
	start /wait /b reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /f
	
	echo.
	echo �ָ� UdpRecvBufferSize
	start /wait /b reg delete "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /f
	
	echo.
	echo �ָ� MaxCacheSize
	start /wait /b reg delete "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheSize /f
	
	echo.
	echo �ָ����
	pause
	exit
)


echo.
if exist %temp%\url.txt (
	del /F /S /Q %temp%\url.txt
	del /F /S /Q %temp%\send.vbs
)

echo ������� 62 ��
echo �������ò�����ַ: %temp%\url.txt



echo https://api.mojang.com/>>%temp%\url.txt
echo https://www.minecraft.net/>>%temp%\url.txt
echo https://ipacamod.cc/>>%temp%\url.txt

echo https://cn.bing.com/>>%temp%\url.txt
echo https://baidu.com/>>%temp%\url.txt
echo https://www.mcbbs.net/>>%temp%\url.txt
echo https://www.bilibili.com/>>%temp%\url.txt
echo https://mail.qq.com/>>%temp%\url.txt
echo https://music.163.com/>>%temp%\url.txt
echo https://zhuanlan.zhihu.com/>>%temp%\url.txt
echo https://hypergryph.com/>>%temp%\url.txt

echo https://translate.google.cn/>>%temp%\url.txt



set /p input=[1]���ļ�/�༭  [Enter]����: 
if !input! equ 1 (
	%temp%\url.txt
	set /p input=[Enter]����: 
)


echo.
set seq=1
for /F "tokens=* delims=" %%t in (%temp%\url.txt) do (
	set url=%%t
	if !seq! equ 1 (
		echo Set client = CreateObject("MSXML2.ServerXMLHTTP"^)>%temp%\send.vbs
	) else (
		echo Set client = CreateObject("MSXML2.ServerXMLHTTP"^)>>%temp%\send.vbs
	)
	echo client.SetTimeOuts 120000,120000,120000,120000>>%temp%\send.vbs
	echo client.open "GET","!url!",false>>%temp%\send.vbs
	echo client.send(^)>>%temp%\send.vbs
	set /a seq+=1
)

set avgTime=0
set totalTime=0
set minTime=
set minBuffer=
set initBuffer=512

echo.
echo ��ʼ����������
start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\RpcEptMapper" /v Start /t reg_dword /d 2 /f
rem start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\DcomLaunch" /v Start /t reg_dword /d 2 /f
start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\nsi" /v Start /t reg_dword /d 2 /f
start /wait /b reg add  "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache" /v Start /t reg_dword /d 2 /f

echo.
echo ��������
call net start RpcEptMapper
rem call net start DcomLaunch
call net start nsi
call net start Dnscache

echo.
echo ��ʼ��MaxCacheTtl
start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheTtl /t reg_dword /d 255 /f



cls
echo �ű�ִ����Ҫһ��ʱ��, ������С������

for /L %%f in (1,1,5) do (
	
	echo.
	echo.
	:: echo ��ʼ�� Buffer Ϊ !initBuffer!
	start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !initBuffer! /f
	start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !initBuffer! /f
	
	:: echo  - ��ʼ�� UdpRecvBufferSize
	start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /t reg_dword /d !initBuffer! /f
	
	:: echo  - ��ʼ�� MaxCacheSize
	start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheSize /t reg_dword /d !initBuffer! /f
	
	
	echo.
	echo ��ʼ���� Buffer=!initBuffer!, �������Ҫһ��ʱ��...
	
	for /L %%t in (1,1,10) do (
		set start=!time!
		start /wait wscript /b %temp%\send.vbs
		set end=!time!
		set startHour=!start:~0,2!
		set /a startHour=1!startHour: =0!-100
		set /a startMin=1!start:~3,2!-100
		set /a startSec=1!start:~6,2!-100
		set /a startMil=1!start:~9,2!-100
		set endHour=!end:~0,2!
		set /a endHour=1!endHour: =0!-100
		set /a endMin=1!end:~3,2!-100
		set /a endSec=1!end:~6,2!-100
		set /a endMil=1!end:~9,2!-100
		set /a start=startHour*360000+startMin*6000+startSec*100+startMil
		set /a end=endHour*360000+endMin*6000+endSec*100+endMil
		set /a dura=!end!-!start!
		
		::�ж��Ƿ�Ϊ����
		if !dura! GTR 0 (
			echo  - [%%t] Buffer=!initBuffer! ʱ��: !dura!
			set /a totalTime+=!dura!
		) else (
			echo  - [%%t] [-] Buffer=!initBuffer! ʱ��: !dura!
		)
		
	)
	set /a avgTime=!totalTime!/10
	echo BufferΪ !initBuffer! ��ʱ��Ϊ !totalTime! ƽ��ʱ��Ϊ !avgTime!
	echo.
	
	if "!minTime!" equ "" (
		set minTime=!avgTime!
		set minBuffer=!initBuffer!
	) else (
		if !avgTime! lss !minTime! (
			set minTime=!avgTime!
			set minBuffer=!initBuffer!
		)
	)
	set /a initBuffer*=2
	set avgTime=0
	set totalTime=0
)


del /F /S /Q %temp%\url.txt
del /F /S /Q %temp%\send.vbs

echo.
echo.
echo ���ƽ��ʱ��Ϊ !minTime!  Buffer ����Ϊ !minBuffer!

set /p input=ʹ������ֵ���� Buffer: [512~8192]�ֶ�����  [Enter]�Զ�����: 
echo.
if !input! equ 0 (
	
	echo ����Buffer��ʼ
	start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !minBuffer! /f
	start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !minBuffer! /f
	
	echo.
	echo ��ʼ��UdpRecvBufferSize
	start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /t reg_dword /d !minBuffer! /f
	
	echo.
	echo ��ʼ��MaxCacheSize
	start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheSize /t reg_dword /d !minBuffer! /f
	
) else (
	if !input! leq 8192 (
		if !input! geq 512 (
			
			echo ���� Buffer
			start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketSendBufferLength /t reg_dword /d !input! /f
			start /wait /b reg add  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /v SocketReceiveBufferLength /t reg_dword /d !input! /f
			
			echo  - ��ʼ�� UdpRecvBufferSize
			start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v UdpRecvBufferSize /t reg_dword /d !input! /f
			
			echo  - ��ʼ�� MaxCacheSize
			start /wait /b reg add  "HKLM\System\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheSize /t reg_dword /d !input! /f
			
		) else (
			echo ������Χ
			pause
		)
	) else (
		echo ������Χ
		pause
	)
)


echo.
echo.
echo ���н��� windows_Buffer_�����Ż�����
pause
exit


