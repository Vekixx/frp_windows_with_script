# frp_windows_with_script
frp windows client with onekey script

---
## 01.Frp
A fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet. 
frp 是一个专注于内网穿透的高性能的反向代理应用，支持 TCP、UDP、HTTP、HTTPS 等多种协议，且支持 P2P 通信。可以将内网服务以安全、便捷的方式通过具有公网 IP 节点的中转暴露到公网。
url: [https://github.com/fatedier/frp](https://github.com/fatedier/frp)
frp开源地址: [https://github.com/fatedier/frp](https://github.com/fatedier/frp)

---
## frp_windows_with_script reason
When using the STCP function of FRP and SSH remotely, manual command line startup is inconvenient and cannot close the command line window. So, using AI and NSSM to achieve one click running of frpc, injecting services, making it start up automatically, and developing scripts to stop running and delete services.
使用frp的STCP功能、远程SSH时，手动命令行启动既不方便而且不能关闭命令行窗口。于是使用AI、通过[NSSM](https://nssm.cc)实现一键运行frpc、注入服务，使之开机自启，并开发配套停止运行、删除服务的脚本。
