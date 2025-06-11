@echo off
chcp 65001
setlocal

set SERVICE_NAME=frpc
set NSSM_EXE=%~dp0nssm.exe


sc query "%SERVICE_NAME%" >nul 2>&1
if %errorlevel% neq 0 (
    echo 服务 [%SERVICE_NAME%] 不存在，无需卸载。The service [%SERVICE_NAME%] no exist.
    pause
    goto :eof
)


echo 正在停止服务 [%SERVICE_NAME%]... Stopping service [% SERVER NAME%]
net stop "%SERVICE_NAME%"
if %errorlevel% neq 0 (
    echo 停止服务失败或服务未运行。Stopping service failed or the service is not running.
) else (
    echo 服务已停止。Service stopped.
)

 
echo 正在卸载服务 [%SERVICE_NAME%]... Uninstalling service [%SERVICE_NAME%]...
"%NSSM_EXE%" remove "%SERVICE_NAME%" confirm
if %errorlevel% neq 0 (
    echo 卸载服务失败，请检查权限或nssm.exe路径。Uninstalling service failed, please check permissions or nssm.exe path.
) else (
    echo 服务已卸载成功。Uninstalled successfully.
)

pause
endlocal
