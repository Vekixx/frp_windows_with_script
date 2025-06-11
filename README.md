# frp_windows_with_script
## [En Version](https://github.com/Vekixx/frp_windows_with_script/blob/main/README-en.md)

frp Windows 服务端 + 一键部署脚本

---
## 01.原始项目Original Repo fatedier/frp
frp 是一个专注于内网穿透的高性能的反向代理应用，支持 TCP、UDP、HTTP、HTTPS 等多种协议，且支持 P2P 通信。可以将内网服务以安全、便捷的方式通过具有公网 IP 节点的中转暴露到公网。

开源地址: [https://github.com/fatedier/frp](https://github.com/fatedier/frp)

---
## 02.原因Reason

使用frp的STCP功能、远程SSH时，手动命令行启动既不方便而且不能关闭命令行窗口。于是使用AI、通过[NSSM](https://nssm.cc)实现一键运行frpc、注入服务，使之开机自启，并开发配套停止运行、删除服务的脚本。

## 03.文件路径

```bash
frp/         #根文件夹           
│
├── frpc.toml     #配置文件
│
├── ssl/          #证书文件夹
│   ├── ca.crt
│   ├── client.crt
│   └── client.key
│
├── src/         #nssm 脚本文件夹
├── nssm.exe     #可使命令转化为Windows服务（可开机自启）
│ 
├── install.bat     #运行服务脚本（开机自启）
│
└── uninstall.bat   #删除服务脚本
```

## 04.文件来源File source

### 4.1 frps/frpc.exe

- 下载地址：[https://github.com/fatedier/frp/releases](https://github.com/fatedier/frp/releases)

- **frp windows amd64.zip** 仅有x86_64 （amd64）版。如果你的机器是arm架构，请前往[fatedier/frp](https://github.com/fatedier/frp/releases) 下载arm v0.62.1版本、解压后替换frps/frpc.exe。

### 4.2 nssm.exe

- 官网最新版下载地址：https://nssm.cc/release/nssm-2.24.zip
  

### 4.3 install.bat / uninstall.bat

- 使用ai创建

### 4.4 frps/frpc.toml

- 模板frps.toml：[https://github.com/fatedier/frp/blob/dev/conf/frps_full_example.toml](https://github.com/fatedier/frp/blob/dev/conf/frps_full_example.toml)
- 模板frpc.toml：[https://github.com/fatedier/frp/blob/dev/conf/frpc_full_example.toml](https://github.com/fatedier/frp/blob/dev/conf/frpc_full_example.toml)


## 05.使用

- 初次运行：双击`install.bat`即可
  
- 修改配置：修改`frpc.toml`后先后双击`uninstall.bat`、`install.bat`即可
  
- 停止运行：双击`uninstall.bat`即可
