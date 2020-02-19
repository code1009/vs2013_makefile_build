@ECHO OFF

REM =========================================================================
IF %1 == mkdir GOTO cmd_mkdir
IF %1 == rmdir GOTO cmd_rmdir
IF %1 == rm    GOTO cmd_rm
GOTO end

REM =========================================================================
:cmd_mkdir
IF NOT EXIST %2 GOTO run_mkdir
GOTO end

:run_mkdir
SET MakefileShellCommand_Variable=%2
SET MakefileShellCommand_Variable=%MakefileShellCommand_Variable:/=\%

@echo mkdir %MakefileShellCommand_Variable%
mkdir %MakefileShellCommand_Variable%

GOTO end

REM =========================================================================
:cmd_rmdir
IF EXIST %2 goto run_rmdir
goto end

:run_rmdir
SET MakefileShellCommand_Variable=%2
SET MakefileShellCommand_Variable=%MakefileShellCommand_Variable:/=\%

@ECHO rmdir /S /Q %MakefileShellCommand_Variable%
rmdir /S /Q %MakefileShellCommand_Variable%

GOTO end


REM =========================================================================
:cmd_rm
IF EXIST %2 goto run_rm
goto end

:run_rm
SET MakefileShellCommand_Variable=%2
SET MakefileShellCommand_Variable=%MakefileShellCommand_Variable:/=\%

@ECHO del /q %MakefileShellCommand_Variable%
del /q %MakefileShellCommand_Variable%

GOTO end


REM =========================================================================
:end


