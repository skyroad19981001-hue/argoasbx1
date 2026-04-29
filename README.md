## 一键Argosbx：极简 + 轻量 + 快速

---------------------------------------

<img width="757" height="255" alt="d89e2542c513e705106371acc7fa1d33" src="https://github.com/user-attachments/assets/7d7a4678-4223-478c-afe2-d303ba0f85a4" />


### 【Argosbx当前版本：V25.11.20】

---------------------------------------

#### 1、基于Sing-box + Xray + Cloudflared-Argo 三内核自动分配

#### 2、支持Linux类主流VPS系统（建议最新版系统），SSH脚本支持非root环境运行，几乎无需依赖，一次回车搞定

#### 3、根据Sing-box与Xray不同内核，可选15种WARP出站组合，更换落地IP为WARP的IP，解锁流媒体

#### 4、所有代理协议都无需域名（除了argo固定隧道、IP端口CDN），支持单个或多个代理协议任意组合并快速重置更换
【 已支持：AnyTLS、Any-reality、Vless-xhttp-reality-vison-enc、Vless-tcp-reality-vision、Vless-xhttp-vison-enc、Vless-ws-vision-enc、Shadowsocks-2022、Vmess-ws、Socks5、Hysteria2、Tuic、Argo临时/固定隧道支持Vless-ws-vision-enc或Vmess-ws 】

#### 5、Argosbx客户端推荐：

安卓手机客户端：[Nekobox-starifly版(全协议支持)](https://github.com/starifly/NekoBoxForAndroid/releases)、[V2rayNG官方版](https://github.com/2dust/v2rayNG/releases)

电脑win客户端：[V2rayN官方版(全协议支持)](https://github.com/2dust/v2rayN/releases)

苹果IOS客户端：Happ、OneXray、Streisand

----------------------------------------------------------

## 一、自定义变量参数说明：

| 变量意义 | 变量名称| 在变量值""之间填写| 删除变量 | 在变量值""之间留空 | 变量要求及说明 |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1、启用vless-tcp-reality-v | vlpt | 端口指定 | 关闭vless-tcp-reality-v | 端口随机 | 必选之一 【xray内核：TCP】 |
| 2、启用vless-xhttp-reality-enc | xhpt | 端口指定 | 关闭vless-xhttp-reality-enc | 端口随机 | 必选之一 【xray内核：TCP】 |
| 3、启用vless-xhttp-enc | vxpt | 端口指定 | 关闭vless-xhttp-enc | 端口随机 | 必选之一 【xray内核：TCP】 |
| 4、启用vless-ws-enc | vwpt | 端口指定 | 关闭vless-ws-enc | 端口随机 | 必选之一 【xray内核：TCP】 |
| 5、启用shadowsocks-2022 | sspt | 端口指定 | 关闭shadowsocks-2022 | 端口随机 | 必选之一 【singbox内核：TCP】 |
| 6、启用anytls | anpt | 端口指定 | 关闭anytls | 端口随机 | 必选之一 【singbox内核：TCP】 |
| 7、启用any-reality | arpt | 端口指定 | 关闭any-reality | 端口随机 | 必选之一 【singbox内核：TCP】 |
| 8、启用vmess-ws | vmpt | 端口指定 | 关闭vmess-ws | 端口随机 | 必选之一 【xray/singbox内核：TCP】 |
| 9、启用socks5 | sopt | 端口指定 | 关闭socks5 | 端口随机 | 必选之一 【xray/singbox内核：TCP】 |
| 10、启用hysteria2 | hypt | 端口指定 | 关闭hy2 | 端口随机 | 必选之一 【singbox内核：UDP】 |
| 11、启用tuic | tupt | 端口指定 | 关闭tuic | 端口随机 | 必选之一 【singbox内核：UDP】 |
| 12、warp开关 | warp | 详见下方15种warp出站模式图 | 关闭warp | singbox与xray内核协议都启用warp全局V4+V6 | 可选，详见下方15种warp出站模式图 |
| 13、argo开关 | argo | 填写vwpt或者vmpt | 关闭argo隧道 | 关闭argo隧道 | 可选，填写vmpt或vwpt时，vmess-ws或vless-ws变量vmpt或vwpt必须启用，且固定隧道必须填写vmpt或vwpt端口 |
| 14、argo固定隧道域名 | agn | 托管在CF上的域名 | 使用临时隧道 | 使用临时隧道 | 可选，argo填写vmpt或vwpt时才可激活固定隧道|
| 15、argo固定隧道token | agk | CF获取的ey开头的token | 使用临时隧道 | 使用临时隧道 | 可选，argo填写vmpt或vwpt时才可激活固定隧道 |
| 16、uuid密码 | uuid | 符合uuid规定格式 | 随机生成 | 随机生成 | 可选 |
| 17、reality域名（仅支持reality类协议） | reym | 符合reality域名规定 | apple官网 | apple官网 | 可选，使用CF类域名时：服务器ip:节点端口的组合，可作为ProxyIP/客户端地址反代IP（建议高位端口或纯IPV6下使用，以防被扫泄露）|
| 18、vmess-ws、vless-xhttp/ws-enc在客户端的host地址 | cdnym | CF解析IP的域名 | vmess-ws、vless-xhttp/ws-enc为直连 | vmess-ws、vless-xhttp/ws-enc为直连 | 可选，使用80系CDN或者回源CDN时可设置，否则客户端host地址需手动更改为CF解析IP的域名|
| 19、切换ipv4或ipv6配置 | ippz | 填写4或者6 | 自动识别IP配置 | 自动识别IP配置 | 可选，4表示IPV4配置输出，6表示IPV6配置输出 |
| 20、添加所有节点名称前缀 | name | 任意字符 | 默认协议名前缀 | 默认协议名前缀 | 可选 |
| 21、当前系统开放所有端口 | oap | 填写y | 禁止开放所有端口 | 禁止开放所有端口 | 可选，开启运行一次即可，后续删除变量，没必要每次运行 |
| 22、【仅容器类docker】监听端口，网页查询 | PORT | 端口指定 | 3000 | 3000 | 可选 |
| 23、【仅容器类docker】启用vless-ws-tls | DOMAIN | 服务器域名 | 关闭vless-ws-tls | 关闭vless-ws-tls | 可选，vless-ws-tls可独立存在，uuid变量必须启用 |

------------------------------------------------------------------


## 二、SSH一键变量脚本模版说明：

### 脚本以 ```变量名称="变量值"的单个或多个组合 + 主脚本``` 的形式运行

* 默认主脚本curl：```bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)```

* 如报错curl not found 可换用主脚本wget：```bash <(wget -qO- https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)```

* 必选其一的协议端口变量：```vwpt=""```、```vmpt=""```、```vmpt="" argo="vmpt"```、```vwpt="" argo="vwpt"```、```vlpt=""```、```xhpt=""```、```anpt=""```、```arpt=""```、```hypt=""```、```tupt=""```、```sspt=""```、```vxpt=""```、```sopt=""```

* 可选的功能类变量：```warp=""```、```uuid=""```、```reym=""```、```cdnym=""```、```argo=""```、```agn=""```、```agk=""```、```ippz=""```、```name=""```、```oap=""```

请参考```一、自定义变量参数说明```中变量的作用说明，变量值填写在```" "```之间，变量之间空一格，不用的变量可以删除

-------------------------------------------------------------

* ### 模版1：多个任意协议组合运行
```
sspt="" vlpt="" vmpt="" vwpt="" hypt="" tupt="" xhpt="" vxpt="" anpt="" arpt="" sopt="" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

* ### 模版2：主流TCP或UDP单个协议运行

Vless-Tcp-Reality-vision协议节点
```
vlpt="" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

Vless-Xhttp-Reality-vision-enc协议节点 (默认开启ENC加密)
```
xhpt="" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

Vless-Xhttp-vision-enc协议节点 (默认开启ENC加密，IDX-Google-VPS容器支持)
```
vxpt="" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

Vless-ws-vision-enc协议节点 (默认开启ENC加密)
```
vwpt="" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

Shadowsocks-2022协议节点
```
sspt="" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

AnyTLS协议节点
```
anpt="" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

Any-Reality协议节点
```
arpt="" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

Vmess-ws协议节点
```
vmpt="" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

Socks5协议节点 (配合其他应用内置代理使用，勿做节点直接使用)
```
sopt="" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

Hysteria2协议节点
```
hypt="" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

Tuic协议节点
```
tupt="" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

* ### 模版3：开启CDN优选的节点运行

Argo临时/固定隧道运行优选节点，类似无公网的IDX-Google-VPS容器推荐使用此脚本，快速一键内网穿透获取节点

Vmess-ws-argo临时隧道CDN优选节点
```
vmpt="" argo="vmpt" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

Vless-ws-vision-enc-argo临时隧道CDN优选节点
```
vwpt="" argo="vwpt" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

Vmess-ws-argo-argo固定隧道CDN优选节点，必须填写端口(vmpt)、域名(agn)、token(agk)
```
vmpt="CF设置的URL端口" argo="vmpt" agn="解析的CF域名" agk="CF获取的token" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

Vless-ws-vision-enc-argo固定隧道CDN优选节点，必须填写端口(vmpt)、域名(agn)、token(agk)
```
vwpt="CF设置的URL端口" argo="vwpt" agn="解析的CF域名" agk="CF获取的token" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

Vmess-ws的80系端口、回源端口的CDN优选节点
```
vmpt="80系端口、指定回源端口" cdnym="CF解析IP的域名" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

Vless-Xhttp-vision-enc的80系端口、回源端口的CDN优选节点
```
vxpt="80系端口、指定回源端口" cdnym="CF解析IP的域名" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```

Vless-ws-vision-enc的80系端口、回源端口的CDN优选节点
```
vwpt="80系端口、指定回源端口" cdnym="CF解析IP的域名" bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)
```
---------------------------------------------------------

## 三、多功能SSH快捷方式命令组

#### 说明：首次安装成功后需重连SSH，```agsbx 命令```的快捷方式才可生效；如未生效，请使用```主脚本 命令```的快捷方式

1、查看Argo的固定域名、固定隧道的token、临时域名、当前已安装的节点信息命令：```agsbx list``` 或者 ```主脚本 list```

2、更换、增加、删除变量组命令：```自定义各种协议变量组 agsbx rep``` 或者 ```自定义各种协议变量组 主脚本 rep```

3、更新脚本命令：```原已安装的自定义各种协议变量组 主脚本 rep``` 

4、更新Xray或Singbox内核命令：agsbx upx或ups 【或者】 主脚本 upx或ups

5、重启脚本命令：```agsbx res``` 或者 ```主脚本 res```

6、卸载脚本命令：```agsbx del``` 或者 ```主脚本 del```

7、临时切换IPV4/IPV6节点配置 (双栈VPS专享)：

显示IPV4节点配置：```ippz=4 agsbx list```或者```ippz=4 主脚本 list```

显示IPV6节点配置：```ippz=6 agsbx list```或者```ippz=6 主脚本 list```

----------------------------------------------------------

