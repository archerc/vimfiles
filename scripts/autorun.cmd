@echo off

REM %0 : autorun.cmd
REM %~p0 \Documents\
REM %~d0 d:
REM %~dp0 d:\Documents\
REM %~dpf0 d:\Documents\autorun.cmd

REM ÿ��cmd�������Զ����б��ļ�
set AUTORUN_REG_PATH="HKCU\Software\Microsoft\Command Processor"
reg query %AUTORUN_REG_PATH% /v AutoRun >NUL
if %ERRORLEVEL% neq 0 ( 
	reg add %AUTORUN_REG_PATH% /v AutoRun /t REG_EXPAND_SZ /d %~dpf0
)

REM �ҵ�Ĭ������
set LESSCHARSET=utf-8
set SYSTEM_PATH=%PATH%
set CONDA_BIN=D:\Programs\Anaconda3\condabin
set GIT_BIN=D:\Programs\Git\usr\bin;D:\Programs\Git\cmd
set GECKO_BIN=D:\Programs\GeckoDriver
set PANDOC_BIN=D:\Programs\Anaconda3\Scripts
set VIM_BIN=D:\Programs\Vim\vim81
set GTAGS_BIN=D:\Programs\global\bin
set TEX_BIN=D:\Programs\texlive\2018\bin\win32
set StarDict=D:\Programs\StarDict
set GTK_BIN=D:\Programs\GTK\2.0\bin
set PYTHON_BIN=D:\Programs\Python\3.7.4.amd64;D:\Programs\Python\3.7.4.amd64\Scripts
set PATH=%SYSTEM_PATH%;%GIT_BIN%;%GECKO_BIN%;%StarDict%;%GTK_BIN%;%VIM_BIN%;%GTAGS_BIN%;%TEX_BIN%;%CONDA_BIN%;%PYTHON_BIN%;%~dp0%

REM ����������ʾ��
prompt $P$G$_$D$B$T$G$S$$$S


