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
set LESSCHARSET=utf-8

REM PATH
set SYSTEM_PATH=%PATH%
if x"%ProgramsDir%" == x"" (
  echo ProgramsDir is empty
  set ProgramsDir=D:\Programs
  echo setting ProgramsDir to %ProgramsDir%
)
set CONDA_BIN=%ProgramsDir%\Anaconda3\condabin
set GIT_BIN=%ProgramsDir%\Git\usr\bin;%ProgramsDir%\Git\cmd
set GECKO_BIN=%ProgramsDir%\GeckoDriver
set PANDOC_BIN=%ProgramsDir%\Anaconda3\Scripts
set VIM_BIN=%ProgramsDir%\Vim\vim81
set GTAGS_BIN=%ProgramsDir%\global\bin
set TEX_BIN=%ProgramsDir%\texlive\2018\bin\win32
set StarDict=%ProgramsDir%\StarDict
set GTK_BIN=%ProgramsDir%\GTK\2.0\bin
set PYTHON_VERSION=3.7.3.amd64
set PYTHON_BIN=%ProgramsDir%\Python\%PYTHON_VERSION%;%ProgramsDir%\Python\%PYTHON_VERSION%\Scripts
set PATH=%SYSTEM_PATH%;%GIT_BIN%;%GECKO_BIN%;%StarDict%;%GTK_BIN%;%VIM_BIN%;%GTAGS_BIN%;%TEX_BIN%;%CONDA_BIN%;%PYTHON_BIN%;%~dp0%

REM 设置命令提示符
prompt $P$G$_$D$B$T$G$S$$$S


