@echo off

REM Upload world assets to Arena of Ideas server
REM This script runs the Arena of Ideas client in world upload mode

setlocal EnableDelayedExpansion

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "WORLD_REPO=%SCRIPT_DIR%"
set "AOI_REPO=%SCRIPT_DIR%..\arena-of-ideas"

REM Remove trailing backslash from WORLD_REPO if present
if "%WORLD_REPO:~-1%"=="\" set "WORLD_REPO=%WORLD_REPO:~0,-1%"

REM Check if arena-of-ideas repo exists
if not exist "%AOI_REPO%" (
    echo Error: Arena of Ideas repository not found at %AOI_REPO%
    echo Make sure the arena-of-ideas repository is cloned as a sibling to arena-of-ideas-world
    exit /b 1
)

REM Check if assets directory exists
if not exist "%WORLD_REPO%\assets" (
    echo Error: No assets directory found in %WORLD_REPO%
    echo Make sure you have downloaded world assets first using download.bat
    exit /b 1
)

REM Set environment variable to point to this world repo
set "AOI_WORLD_PATH=%WORLD_REPO%"

REM Change to the arena-of-ideas directory
cd /d "%AOI_REPO%"

echo Uploading world assets to server...
echo World repository: %WORLD_REPO%
echo Arena of Ideas repository: %AOI_REPO%

REM Run the client in world upload mode
cargo run --features bevy/dynamic_linking -- --mode world-upload

if %ERRORLEVEL% NEQ 0 (
    echo Error: World assets upload failed!
    exit /b %ERRORLEVEL%
)

echo World assets upload completed!
