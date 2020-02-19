@ECHO OFF

REM =========================================================================
IF %1 == mkdir GOTO cmd_mkdir
IF %1 == rmdir GOTO cmd_rmdir
IF %1 == rm    GOTO cmd_rm
GOTO end

REM =========================================================================
:cmd_mkdir
IF NOT EXIST %2 GOTO do_mkdir
GOTO end

:do_mkdir
@echo mkdir %2
mkdir %2
GOTO end

REM =========================================================================
:cmd_rmdir
IF EXIST %2 goto do_rmdir
goto end

:do_rmdir
@ECHO rmdir %2
REM del /s /q %2
rmdir /S /Q %2
GOTO end


REM =========================================================================
:cmd_rm
IF EXIST %2 goto do_rm
goto end

:do_rm
SET MakefileShellCommand_Variable=%2
SET MakefileShellCommand_Variable=%MakefileShellCommand_Variable:/=\%
@ECHO rm %MakefileShellCommand_Variable%
del /q %MakefileShellCommand_Variable%

REM @ECHO rm %2
REM del /q %2
GOTO end


REM =========================================================================
:end


