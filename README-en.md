# frp_windows_with_script

## [中文版](https://github.com/Vekixx/frp_windows_with_script/blob/main/README-en.md)

frp windows client with onekey script

---
## 01 Original Repo fatedier/frp
A fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet. 

Github: [https://github.com/fatedier/frp](https://github.com/fatedier/frp)

---
## 02 Reason

When using the STCP function of FRP and SSH remotely, manual command line startup is inconvenient and cannot close the command line window. So, using AI and NSSM to achieve one click running of frpc, injecting services, making it start up automatically, and developing scripts to stop running and delete services.

## 03 File Path

```bash
frp/         #root dir          
│
├── frpc.toml     #config
│
├── ssl/          #Certificate folder
│   ├── ca.crt
│   ├── client.crt
│   └── client.key
│
├── src/         #Nssm script folder
├── nssm.exe     #convert commands into Windows services
│ 
├── install.bat     #install script
│
└── uninstall.bat   #uninstall script
```

## 04 File source

### 4.1 frps/frpc.exe

- Download link for the latest version on Github: [https://github.com/fatedier/frp/releases](https://github.com/fatedier/frp/releases)  
- **frp windows amd64.zip**. only **amd64**.  If your machine is an ARM architecture, please go to [fatedier/frp](https://github.com/fatedier/frp/releases) to download the ARM version, unzip it, and replace frps/frpc.exe

### 4.2 nssm.exe

- Download link for the latest version on the website：https://nssm.cc/release/nssm-2.24.zip

### 4.3 install.bat / uninstall.bat

Create by using AI

### 4.4 frps/frpc.toml

- Modify frps.toml according to https://github.com/fatedier/frp/blob/dev/conf/frps_full_example.toml](https://github.com/fatedier/frp/blob/dev/conf/frps_full_example.toml)
- Modify frpc.toml according to https://github.com/fatedier/frp/blob/dev/conf/frpc_full_example.toml](https://github.com/fatedier/frp/blob/dev/conf/frpc_full_example.toml)


## 05 使用

- First run: Double click `install.bat`.

- Modify configuration: After modifying `frpc.toml`, double-click `uninstall.bat` and `install.bat` in sequence.
- Stop running: Double click `uninstall.bat` .
