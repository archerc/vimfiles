@echo off

REM %0 : autorun.cmd
REM %~p0 \Documents\
REM %~d0 d:
REM %~dp0 d:\Documents\
REM %~dpf0 d:\Documents\autorun.cmd

REM 每次cmd启动后都自动运行本文件
set AUTORUN_REG_PATH="HKCU\Software\Microsoft\Command Processor"
reg query %AUTORUN_REG_PATH% /v AutoRun >NUL
if %ERRORLEVEL% neq 0 ( 
	reg add %AUTORUN_REG_PATH% /v AutoRun /t REG_EXPAND_SZ /d %~dpf0
)

REM 我的默认配置
set SYSTEM_PATH=%PATH%
set CONDA_BIN=D:\Programs\Anaconda3\condabin
set GIT_BIN=D:\Programs\Git\cmd
set PANDOC_BIN=D:\Programs\Anaconda3\Scripts
set VIM_BIN=D:\Programs\Vim\vim81
set GTAGS_BIN=D:\Programs\global\bin
set TEX_BIN=D:\Programs\texlive\2018\bin\win32
set PATH=%SYSTEM_PATH%;%VIM_BIN%;%GTAGS_BIN%;%TEX_BIN%;%GIT_BIN%;%CONDA_BIN%

REM 设置命令提示符
prompt $P$G$_$D$B$T$G$S$$$S


