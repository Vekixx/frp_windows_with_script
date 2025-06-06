@echo off
chcp 65001
setlocal

set SERVICE_NAME=frpc
set NSSM_EXE=%~dp0nssm.exe

rem --- 检查服务是否存在 ---
sc query "%SERVICE_NAME%" >nul 2>&1
if %errorlevel% neq 0 (
    echo 服务 [%SERVICE_NAME%] 不存在，无需卸载。
    pause
    goto :eof
)

rem --- 停止服务 ---
echo 正在停止服务 [%SERVICE_NAME%]...
net stop "%SERVICE_NAME%"
if %errorlevel% neq 0 (
    echo 停止服务失败或服务未运行。
) else (
    echo 服务已停止。
)

rem --- 卸载服务 ---
echo 正在卸载服务 [%SERVICE_NAME%]...
"%NSSM_EXE%" remove "%SERVICE_NAME%" confirm
if %errorlevel% neq 0 (
    echo 卸载服务失败，请检查权限或nssm.exe路径。
) else (
    echo 服务已卸载成功。
)

pause
endlocal
