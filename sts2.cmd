@echo off
rem sts2.cmd — Windows wrapper for STS2-Cli-Mod CLI
rem Resolution order:
rem   1. STS2_CLI_DIR environment variable (explicit override)
rem   2. %LOCALAPPDATA%\sts2-cli\sts2.exe (standard install path)

setlocal

rem 1. Explicit override
if defined STS2_CLI_DIR (
    if exist "%STS2_CLI_DIR%\sts2.exe" (
        "%STS2_CLI_DIR%\sts2.exe" %*
        exit /b %ERRORLEVEL%
    )
)

rem 2. Standard install path
if exist "%LOCALAPPDATA%\sts2-cli\sts2.exe" (
    "%LOCALAPPDATA%\sts2-cli\sts2.exe" %*
    exit /b %ERRORLEVEL%
)

echo Error: sts2 CLI not found. >&2
echo. >&2
echo Install it by publishing STS2-Cli-Mod: >&2
echo   dotnet publish STS2.Cli.Cmd\STS2.Cli.Cmd.csproj -c Release -r win-x64 >&2
echo. >&2
echo Or set STS2_CLI_DIR to the directory containing sts2.exe: >&2
echo   set STS2_CLI_DIR=C:\path\to\dir >&2
exit /b 1
