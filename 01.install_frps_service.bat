@echo off
chcp 65001
setlocal

pushd "%~dp0"
set "CURRENT_DIR=%CD%"
popd

set SERVICE_NAME=frps
set FRPC_EXE=%CURRENT_DIR%\frps.exe
set FRPC_CONFIG=%CURRENT_DIR%\frps.toml
set NSSM_EXE=%CURRENT_DIR%\nssm.exe

if not exist "%FRPC_EXE%" (
    echo 错误：未找到 frps.exe，路径：%FRPC_EXE%   Error: frps.exe not found, path:%FRPC_EXE%
    pause
    goto :eof
)
if not exist "%FRPC_CONFIG%" (
    echo 错误：未找到 frps.toml，路径：%FRPC_CONFIG%    Error: frps.toml not found, path:%FRPC_CONFIG%
    pause
    goto :eof
)
if not exist "%NSSM_EXE%" (
    echo 错误：未找到 nssm.exe，路径：%NSSM_EXE%   Error: nssm.exe not found, path:%NSSM_EXE% 
    pause
    goto :eof
)

sc query "%SERVICE_NAME%" >nul 2>&1
if %errorlevel%==0 (
    echo 服务 [%SERVICE_NAME%] 已存在，尝试启动服务...  Service [%SERVICE_NAME%] already exists, try starting the service ..
    goto :START_SERVICE
)

echo 正在安装服务 [%SERVICE_NAME%] ...  Installing service [%SERVICE_NAME%] ...
"%NSSM_EXE%" install "%SERVICE_NAME%" "%FRPC_EXE%" -c "%FRPC_CONFIG%"
if %errorlevel% neq 0 (
    echo 服务安装失败！Service installation failed!
    pause
    goto :eof
)

"%NSSM_EXE%" set "%SERVICE_NAME%" AppDirectory "%CURRENT_DIR%"
sc config "%SERVICE_NAME%" start= auto

:START_SERVICE
echo 正在启动服务 [%SERVICE_NAME%] ... Starting service [%SERVICE_NAME%] ...
net start "%SERVICE_NAME%" >nul 2>&1

set WAITSEC=0
:WAIT_LOOP
timeout /t 1 /nobreak >nul
set /a WAITSEC+=1

sc query "%SERVICE_NAME%" | findstr /i "RUNNING" >nul
if %errorlevel%==0 (
    echo 服务已成功启动！Service started!
    goto :END
)

sc query "%SERVICE_NAME%" | findstr /i "START_PENDING" >nul
if %errorlevel%==0 (
    if %WAITSEC% GEQ 30 (
        echo 等待启动超时，请检查服务日志或配置。Startup timeout, please check logs or configuration.
        goto :END
    )
    goto WAIT_LOOP
)

echo 服务启动失败，状态异常，请检查配置和日志。Service startup failed with abnormal status, please check the configuration and logs.
goto :END

:END
pause
endlocal
