@ECHO OFF

REM �ж�Ŀ¼�Ƿ����, �����ھ��˳�
IF NOT EXIST Ipac_Client_E EXIT


REM �ͻ���Ŀ¼
CD Ipac_Client_E


REM ����[start ]
..\zulu17.30.15-ca-fx-jre17.0.1-win_x64\bin\javaw.exe -jar HMCL.jar


REM ɾ������־
FORFILES -P "Client_files\logs" -s -m *.log -d -32 -C "CMD /C DEL @PATH
FORFILES -P "Client_files\logs" -s -m *.gz -d -32 -C "CMD /C DEL @PATH
FORFILES -P "Client_files\crash-reports" -s -m *.* -d -32 -C "CMD /C DEL @PATH


REM ɾ�����ܴ��ڵ��ڴ�ת���ļ�
DEL /Q *.dmp


REM ������, ɾ��HMCL���µ���־�ļ�
FORFILES -P "%appdata%\.hmcl\logs" -s -m *.* -d -32 -C "CMD /C DEL @PATH