@echo off
chcp 65001

setlocal

pushd "%~dp0"
set "CURRENT_DIR=%CD%"
popd

set SERVICE_NAME=frpc
set FRPC_EXE=%CURRENT_DIR%\frpc.exe
set FRPC_CONFIG=%CURRENT_DIR%\frpc.toml
set NSSM_EXE=%CURRENT_DIR%\nssm.exe

if not exist "%FRPC_EXE%" (
    echo 错误：未找到 frpc.exe，路径：%FRPC_EXE%
    pause
    goto :eof
)
if not exist "%FRPC_CONFIG%" (
    echo 错误：未找到 frpc.toml，路径：%FRPC_CONFIG%
    pause
    goto :eof
)
if not exist "%NSSM_EXE%" (
    echo 错误：未找到 nssm.exe，路径：%NSSM_EXE%
    pause
    goto :eof
)

sc query "%SERVICE_NAME%" >nul 2>&1
if %errorlevel%==0 (
    echo 服务 [%SERVICE_NAME%] 已存在，尝试启动服务...
    goto :START_SERVICE
)

echo 正在安装服务 [%SERVICE_NAME%] ...
"%NSSM_EXE%" install "%SERVICE_NAME%" "%FRPC_EXE%" -c "%FRPC_CONFIG%"
if %errorlevel% neq 0 (
    echo 服务安装失败！
    pause
    goto :eof
)

"%NSSM_EXE%" set "%SERVICE_NAME%" AppDirectory "%CURRENT_DIR%"
sc config "%SERVICE_NAME%" start= auto

:START_SERVICE
echo 正在启动服务 [%SERVICE_NAME%] ...
net start "%SERVICE_NAME%" >nul 2>&1

set WAITSEC=0
:WAIT_LOOP
timeout /t 1 /nobreak >nul
set /a WAITSEC+=1

sc query "%SERVICE_NAME%" | findstr /i "RUNNING" >nul
if %errorlevel%==0 (
    echo 服务已成功启动！
    goto :END
)

sc query "%SERVICE_NAME%" | findstr /i "START_PENDING" >nul
if %errorlevel%==0 (
    if %WAITSEC% GEQ 30 (
        echo 等待启动超时，请检查服务日志或配置。
        goto :END
    )
    goto WAIT_LOOP
)

echo 服务启动失败，状态异常，请检查配置和日志。
goto :END

:END
pause
endlocal

