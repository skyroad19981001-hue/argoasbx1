#!/bin/sh
export LANG=en_US.UTF-8
[ -z "${vlpt+x}" ] || vlp=yes
[ -z "${vmpt+x}" ] || { vmp=yes; vmag=yes; }
[ -z "${vwpt+x}" ] || { vwp=yes; vmag=yes; }
[ -z "${hypt+x}" ] || hyp=yes
[ -z "${tupt+x}" ] || tup=yes
[ -z "${xhpt+x}" ] || xhp=yes
[ -z "${vxpt+x}" ] || vxp=yes
[ -z "${anpt+x}" ] || anp=yes
[ -z "${sspt+x}" ] || ssp=yes
[ -z "${arpt+x}" ] || arp=yes
[ -z "${sopt+x}" ] || sop=yes
[ -z "${warp+x}" ] || wap=yes
if [ "$1" = "del" ] || [ "$vxp" = yes ] || [ "$ssp" = yes ] || [ "$vlp" = yes ] || [ "$vmp" = yes ] || [ "$hyp" = yes ] || [ "$tup" = yes ] || [ "$xhp" = yes ] || [ "$anp" = yes ] || [ "$arp" = yes ]; then
mkdir -p $HOME/agsbx
echo "$1" > $HOME/agsbx/agpass.log
else
export cdnym=${cdnym:-'yx3.991376.xyz yx2.991376.xyz yx8.991376.xyz'}
fi
v46url="https://icanhazip.com"
agsbxurl="https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh"

showmode(){
echo "主脚本：bash <(curl -Ls https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh) 或 bash <(wget -qO- https://raw.githubusercontent.com/skyroad19981001-hue/argoasbx1/main/argosbx.sh)"
echo "显示节点信息命令：agsbx list 【或者】 主脚本 list"
echo "重置变量组命令：自定义各种协议变量组 agsbx rep 【或者】 自定义各种协议变量组 主脚本 rep"
echo "更新脚本命令：原已安装的自定义各种协议变量组 主脚本 rep"
echo "更新Xray或Singbox内核命令：agsbx upx或ups 【或者】 主脚本 upx或ups"
echo "重启脚本命令：agsbx res 【或者】 主脚本 res"
echo "卸载脚本命令：agsbx del 【或者】 主脚本 del"
echo "双栈VPS显示IPv4/IPv6节点配置命令：ippz=4或6 agsbx list 【或者】 ippz=4或6 主脚本 list"
echo "---------------------------------------------------------"
echo
}
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "当前版本：V26.5.10"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
hostname=$(uname -a | awk '{print $2}')
op=$(cat /etc/redhat-release 2>/dev/null || cat /etc/os-release 2>/dev/null | grep -i pretty_name | cut -d \" -f2)
[ -z "$(systemd-detect-virt 2>/dev/null)" ] && vi=$(virt-what 2>/dev/null) || vi=$(systemd-detect-virt 2>/dev/null)
case $(uname -m) in
arm64|aarch64) cpu=arm64;;
amd64|x86_64) cpu=amd64;;
*) echo "目前脚本不支持$(uname -m)架构" && exit
esac
if [ "$1" != "del" ]; then
mkdir -p "$HOME/agsbx"
if [ ! -f sbx_update ]; then
echo "执行必要的脚本依赖中，请稍等10秒……"
if command -v apk >/dev/null 2>&1; then
apk update >/dev/null 2>&1 && apk add --no-cache bash busybox-extras gcompat libc6-compat iptables >/dev/null 2>&1
elif command -v apt >/dev/null 2>&1; then
export DEBIAN_FRONTEND=noninteractive
printf 'iptables-persistent iptables-persistent/autosave_v4 boolean true\niptables-persistent iptables-persistent/autosave_v6 boolean true\n' | debconf-set-selections
apt update >/dev/null 2>&1 && apt install -y busybox coreutils util-linux iptables iptables-persistent cron >/dev/null 2>&1
fi
touch sbx_update
fi
fi
v4v6(){
v4=$( (command -v curl >/dev/null 2>&1 && curl -s4m5 -k "$v46url" 2>/dev/null) || (command -v wget >/dev/null 2>&1 && timeout 3 wget -4 --tries=2 -qO- "$v46url" 2>/dev/null) )
v6=$( (command -v curl >/dev/null 2>&1 && curl -s6m5 -k "$v46url" 2>/dev/null) || (command -v wget >/dev/null 2>&1 && timeout 3 wget -6 --tries=2 -qO- "$v46url" 2>/dev/null) )
v4dq=$( (command -v curl >/dev/null 2>&1 && curl -s4m5 -k https://myip.ipip.net/ | awk -F'来自于：' '{print $2}' 2>/dev/null) || (command -v wget >/dev/null 2>&1 && timeout 3 wget -4 --tries=2 -qO- https://myip.ipip.net/ | awk -F'来自于：' '{print $2}' 2>/dev/null) )
v6dq=$( (command -v curl >/dev/null 2>&1 && curl -s6m5 -k https://ip.fm | sed -n 's/.*Location: //p' 2>/dev/null) || (command -v wget >/dev/null 2>&1 && timeout 3 wget -6 --tries=2 -qO- https://ip.fm | grep '<span class="has-text-grey-light">Location:' | tail -n1 | sed -E 's/.*>Location: <\/span>([^<]+)<.*/\1/' 2>/dev/null) )
}
warpsx(){
warpurl=$( (command -v curl >/dev/null 2>&1 && curl -sm5 -k https://warp.xijp.eu.org 2>/dev/null) || (command -v wget >/dev/null 2>&1 && timeout 3 wget --tries=2 -qO- https://warp.xijp.eu.org 2>/dev/null) )
if [ -z "$warpurl" ] || printf '%s' "$warpurl" | grep -q html; then
wpv6='2606:4700:110:8d8d:1845:c39f:2dd5:a03a'
pvk='52cuYFgCJXp0LAq7+nWJIbCXXgU9eGggOc+Hlfz5u6A='
res='[215, 69, 233]'
else
pvk=$(echo "$warpurl" | awk -F'：' '/Private_key/{print $2}' | xargs)
wpv6=$(echo "$warpurl" | awk -F'：' '/IPV6/{print $2}' | xargs)
res=$(echo "$warpurl" | awk -F'：' '/reserved/{print $2}' | xargs)
fi
if [ -n "$name" ]; then
sxname=$name-
echo "$sxname" > "$HOME/agsbx/name"
echo
echo "所有节点名称前缀：$name"
fi
v4v6
if echo "$v6" | grep -q '^2a09' || echo "$v4" | grep -q '^104.28'; then
s1outtag=direct; s2outtag=direct; x1outtag=direct; x2outtag=direct; xip='"::/0", "0.0.0.0/0"'; sip='"::/0", "0.0.0.0/0"'; wap=warpargo
echo; echo "请注意：你已安装了warp"
else
if [ "$wap" != yes ]; then
s1outtag=direct; s2outtag=direct; x1outtag=direct; x2outtag=direct; xip='"::/0", "0.0.0.0/0"'; sip='"::/0", "0.0.0.0/0"'; wap=warpargo
else
case "$warp" in
""|sx|xs) s1outtag=warp-out; s2outtag=warp-out; x1outtag=warp-out; x2outtag=warp-out; xip='"::/0", "0.0.0.0/0"'; sip='"::/0", "0.0.0.0/0"'; wap=warp ;;
s ) s1outtag=warp-out; s2outtag=warp-out; x1outtag=direct; x2outtag=direct; xip='"::/0", "0.0.0.0/0"'; sip='"::/0", "0.0.0.0/0"'; wap=warp ;;
s4) s1outtag=warp-out; s2outtag=direct; x1outtag=direct; x2outtag=direct; xip='"::/0", "0.0.0.0/0"'; sip='"0.0.0.0/0"'; wap=warp ;;
s6) s1outtag=warp-out; s2outtag=direct; x1outtag=direct; x2outtag=direct; xip='"::/0", "0.0.0.0/0"'; sip='"::/0"'; wap=warp ;;
x ) s1outtag=direct; s2outtag=direct; x1outtag=warp-out; x2outtag=warp-out; xip='"::/0", "0.0.0.0/0"'; sip='"::/0", "0.0.0.0/0"'; wap=warp ;;
x4) s1outtag=direct; s2outtag=direct; x1outtag=warp-out; x2outtag=direct; xip='"0.0.0.0/0"'; sip='"::/0", "0.0.0.0/0"'; wap=warp ;;
x6) s1outtag=direct; s2outtag=direct; x1outtag=warp-out; x2outtag=direct; xip='"::/0"'; sip='"::/0", "0.0.0.0/0"'; wap=warp ;;
s4x4|x4s4) s1outtag=warp-out; s2outtag=direct; x1outtag=warp-out; x2outtag=direct; xip='"0.0.0.0/0"'; sip='"0.0.0.0/0"'; wap=warp ;;
s4x6|x6s4) s1outtag=warp-out; s2outtag=direct; x1outtag=warp-out; x2outtag=direct; xip='"::/0"'; sip='"0.0.0.0/0"'; wap=warp ;;
s6x4|x4s6) s1outtag=warp-out; s2outtag=direct; x1outtag=warp-out; x2outtag=direct; xip='"0.0.0.0/0"'; sip='"::/0"'; wap=warp ;;
s6x6|x6s6) s1outtag=warp-out; s2outtag=direct; x1outtag=warp-out; x2outtag=direct; xip='"::/0"'; sip='"::/0"'; wap=warp ;;
sx4|x4s) s1outtag=warp-out; s2outtag=warp-out; x1outtag=warp-out; x2outtag=direct; xip='"0.0.0.0/0"'; sip='"::/0", "0.0.0.0/0"'; wap=warp ;;
sx6|x6s) s1outtag=warp-out; s2outtag=warp-out; x1outtag=warp-out; x2outtag=direct; xip='"::/0"'; sip='"::/0", "0.0.0.0/0"'; wap=warp ;;
xs4|s4x) s1outtag=warp-out; s2outtag=direct; x1outtag=warp-out; x2outtag=warp-out; xip='"::/0", "0.0.0.0/0"'; sip='"0.0.0.0/0"'; wap=warp ;;
xs6|s6x) s1outtag=warp-out; s2outtag=direct; x1outtag=warp-out; x2outtag=warp-out; xip='"::/0", "0.0.0.0/0"'; sip='"::/0"'; wap=warp ;;
* ) s1outtag=direct; s2outtag=direct; x1outtag=direct; x2outtag=direct; xip='"::/0", "0.0.0.0/0"'; sip='"::/0", "0.0.0.0/0"'; wap=warpargo ;;
esac
fi
fi
case "$warp" in *x4*) wxryx='ForceIPv4' ;; *x6*) wxryx='ForceIPv6' ;; *) wxryx='ForceIPv6v4' ;; esac
if command -v curl >/dev/null 2>&1; then
curl -s4m5 -k "$v46url" >/dev/null 2>&1 && v4_ok=true
elif command -v wget >/dev/null 2>&1; then
timeout 3 wget -4 --tries=2 -qO- "$v46url" >/dev/null 2>&1 && v4_ok=true
fi
if command -v curl >/dev/null 2>&1; then
curl -s6m5 -k "$v46url" >/dev/null 2>&1 && v6_ok=true
elif command -v wget >/dev/null 2>&1; then
timeout 3 wget -6 --tries=2 -qO- "$v46url" >/dev/null 2>&1 && v6_ok=true
fi
if [ "$v4_ok" = true ] && [ "$v6_ok" = true ]; then
case "$warp" in *s4*) sbyx='prefer_ipv4' ;; *) sbyx='prefer_ipv6' ;; esac
case "$warp" in *x4*) xryx='ForceIPv4v6' ;; *x*) xryx='ForceIPv6v4' ;; *) xryx='ForceIPv4v6' ;; esac
elif [ "$v4_ok" = true ] && [ "$v6_ok" != true ]; then
case "$warp" in *s4*|x) sbyx='ipv4_only' ;; *) sbyx='prefer_ipv6' ;; esac
case "$warp" in *x4*) xryx='ForceIPv4' ;; *x*) xryx='ForceIPv6v4' ;; *) xryx='ForceIPv4v6' ;; esac
elif [ "$v4_ok" != true ] && [ "$v6_ok" = true ]; then
case "$warp" in *s6*|x) sbyx='ipv6_only' ;; *) sbyx='prefer_ipv4' ;; esac
case "$warp" in *x6*) xryx='ForceIPv6' ;; *x*) xryx='ForceIPv4v6' ;; *) xryx='ForceIPv6v4' ;; esac
fi
}
upxray(){
url="https://github.com/yonggekkk/argosbx/releases/download/argosbx/xray-$cpu"; out="$HOME/agsbx/xray"; (command -v curl >/dev/null 2>&1 && curl -Lo "$out" -# --retry 2 "$url") || (command -v wget>/dev/null 2>&1 && timeout 3 wget -O "$out" --tries=2 "$url")
chmod +x "$HOME/agsbx/xray"
sbcore=$("$HOME/agsbx/xray" version 2>/dev/null | awk '/^Xray/{print $2}')
echo "已安装Xray正式版内核：$sbcore"
}
upsingbox(){
url="https://github.com/yonggekkk/argosbx/releases/download/argosbx/sing-box-$cpu"; out="$HOME/agsbx/sing-box"; (command -v curl>/dev/null 2>&1 && curl -Lo "$out" -# --retry 2 "$url") || (command -v wget>/dev/null 2>&1 && timeout 3 wget -O "$out" --tries=2 "$url")
chmod +x "$HOME/agsbx/sing-box"
sbcore=$("$HOME/agsbx/sing-box" version 2>/dev/null | awk '/version/{print $NF}')
echo "已安装Sing-box正式版内核：$sbcore"
}
insuuid(){
if [ -z "$uuid" ] && [ ! -e "$HOME/agsbx/uuid" ]; then
if [ -e "$HOME/agsbx/sing-box" ]; then
uuid=$("$HOME/agsbx/sing-box" generate uuid)
else
uuid=$("$HOME/agsbx/xray" uuid)
fi
echo "$uuid" > "$HOME/agsbx/uuid"
elif [ -n "$uuid" ]; then
echo "$uuid" > "$HOME/agsbx/uuid"
fi
uuid=$(cat "$HOME/agsbx/uuid")
echo "UUID密码：$uuid"
}
installxray(){
echo
echo "=========启用xray内核========="
mkdir -p "$HOME/agsbx/xrk"
if [ ! -e "$HOME/agsbx/xray" ]; then
upxray
fi
cat > "$HOME/agsbx/xr.json" <<EOF
{
  "log": {
  "loglevel": "none"
  },
  "inbounds": [
EOF
insuuid
if [ -n "$xhp" ] || [ -n "$vlp" ]; then
if [ -z "$ym_vl_re" ]; then
ym_vl_re=apple.com
fi
echo "$ym_vl_re" > "$HOME/agsbx/ym_vl_re"
echo "Reality域名：$ym_vl_re"
if [ ! -e "$HOME/agsbx/xrk/private_key" ]; then
key_pair=$("$HOME/agsbx/xray" x25519)
private_key=$(echo "$key_pair" | awk -F':' '/PrivateKey/ {print $2}' | xargs)
public_key=$(echo "$key_pair" | awk -F':' '/Password/ {print $2}' | xargs)
short_id=$(date +%s%N | sha256sum | cut -c 1-8)
echo "$private_key" > "$HOME/agsbx/xrk/private_key"
echo "$public_key" > "$HOME/agsbx/xrk/public_key"
echo "$short_id" > "$HOME/agsbx/xrk/short_id"
fi
private_key_x=$(cat "$HOME/agsbx/xrk/private_key")
public_key_x=$(cat "$HOME/agsbx/xrk/public_key")
short_id_x=$(cat "$HOME/agsbx/xrk/short_id")
fi
if [ -n "$xhp" ] || [ -n "$vxp" ] || [ -n "$vwp" ]; then
if [ ! -e "$HOME/agsbx/xrk/dekey" ]; then
vlkey=$("$HOME/agsbx/xray" vlessenc)
dekey=$(echo "$vlkey" | grep '"decryption":' | sed -n '2p' | cut -d' ' -f2- | tr -d '"')
enkey=$(echo "$vlkey" | grep '"encryption":' | sed -n '2p' | cut -d' ' -f2- | tr -d '"')
echo "$dekey" > "$HOME/agsbx/xrk/dekey"
echo "$enkey" > "$HOME/agsbx/xrk/enkey"
fi
dekey=$(cat "$HOME/agsbx/xrk/dekey")
enkey=$(cat "$HOME/agsbx/xrk/enkey")
fi

if [ -n "$xhp" ]; then
xhp=xhpt
if [ -z "$port_xh" ] && [ ! -e "$HOME/agsbx/port_xh" ]; then
port_xh=$(shuf -i 10000-65535 -n 1)
echo "$port_xh" > "$HOME/agsbx/port_xh"
elif [ -n "$port_xh" ]; then
echo "$port_xh" > "$HOME/agsbx/port_xh"
fi
port_xh=$(cat "$HOME/agsbx/port_xh")
echo "Vless-xhttp-reality-enc端口：$port_xh"
cat >> "$HOME/agsbx/xr.json" <<EOF
    {
      "tag":"xhttp-reality",
      "listen": "::",
      "port": ${port_xh},
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "flow": "xtls-rprx-vision"
          }
        ],
        "decryption": "${dekey}"
      },
      "streamSettings": {
        "network": "xhttp",
        "security": "reality",
        "realitySettings": {
          "fingerprint": "chrome",
          "target": "${ym_vl_re}:443",
          "serverNames": [
            "${ym_vl_re}"
          ],
          "privateKey": "$private_key_x",
          "shortIds": ["$short_id_x"]
        },
        "xhttpSettings": {
          "host": "",
          "path": "${uuid}-xh",
          "mode": "auto"
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls", "quic"],
        "metadataOnly": false
      }
    },
EOF
else
xhp=xhptargo
fi
if [ -n "$vxp" ]; then
vxp=vxpt
if [ -z "$port_vx" ] && [ ! -e "$HOME/agsbx/port_vx" ]; then
port_vx=$(shuf -i 10000-65535 -n 1)
echo "$port_vx" > "$HOME/agsbx/port_vx"
elif [ -n "$port_vx" ]; then
echo "$port_vx" > "$HOME/agsbx/port_vx"
fi
port_vx=$(cat "$HOME/agsbx/port_vx")
echo "Vless-xhttp-enc端口：$port_vx"
if [ -n "$cdnym" ]; then
echo "$cdnym" > "$HOME/agsbx/cdnym"
echo "80系CDN或者回源CDN的host域名 (确保IP已解析在CF域名)：$cdnym"
fi
cat >> "$HOME/agsbx/xr.json" <<EOF
    {
      "tag":"vless-xhttp",
      "listen": "::",
      "port": ${port_vx},
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "flow": "xtls-rprx-vision"
          }
        ],
        "decryption": "${dekey}"
      },
      "streamSettings": {
        "network": "xhttp",
        "xhttpSettings": {
          "host": "",
          "path": "${uuid}-vx",
          "mode": "auto"
        }
      },
        "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls", "quic"],
        "metadataOnly": false
      }
    },
EOF
else
vxp=vxptargo
fi
if [ -n "$vwp" ]; then
vwp=vwpt
if [ -z "$port_vw" ] && [ ! -e "$HOME/agsbx/port_vw" ]; then
port_vw=$(shuf -i 10000-65535 -n 1)
echo "$port_vw" > "$HOME/agsbx/port_vw"
elif [ -n "$port_vw" ]; then
echo "$port_vw" > "$HOME/agsbx/port_vw"
fi
port_vw=$(cat "$HOME/agsbx/port_vw")
echo "Vless-ws-enc端口：$port_vw"
if [ -n "$cdnym" ]; then
echo "$cdnym" > "$HOME/agsbx/cdnym"
echo "80系CDN或者回源CDN的host域名 (确保IP已解析在CF域名)：$cdnym"
fi
cat >> "$HOME/agsbx/xr.json" <<EOF
    {
      "tag":"vless-ws",
      "listen": "::",
      "port": ${port_vw},
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}",
            "flow": "xtls-rprx-vision"
          }
        ],
        "decryption": "${dekey}"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "${uuid}-vw"
        }
      },
        "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls", "quic"],
        "metadataOnly": false
      }
    },
EOF
else
vwp=vwptargo
fi
if [ -n "$vlp" ]; then
vlp=vlpt
if [ -z "$port_vl_re" ] && [ ! -e "$HOME/agsbx/port_vl_re" ]; then
port_vl_re=$(shuf -i 10000-65535 -n 1)
echo "$port_vl_re" > "$HOME/agsbx/port_vl_re"
elif [ -n "$port_vl_re" ]; then
echo "$port_vl_re" > "$HOME/agsbx/port_vl_re"
fi
port_vl_re=$(cat "$HOME/agsbx/port_vl_re")
echo "Vless-tcp-reality-v端口：$port_vl_re"
cat >> "$HOME/agsbx/xr.json" <<EOF
        {
            "tag":"reality-vision",
            "listen": "::",
            "port": $port_vl_re,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "flow": "xtls-rprx-vision"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "tcp",
                "security": "reality",
                "realitySettings": {
                    "fingerprint": "chrome",
                    "dest": "${ym_vl_re}:443",
                    "serverNames": [
                      "${ym_vl_re}"
                    ],
                    "privateKey": "$private_key_x",
                    "shortIds": ["$short_id_x"]
                }
            },
          "sniffing": {
          "enabled": true,
          "destOverride": ["http", "tls", "quic"],
          "metadataOnly": false
      }
    },  
EOF
else
vlp=vlptargo
fi
}

installsb(){
echo
echo "=========启用Sing-box内核========="
if [ ! -e "$HOME/agsbx/sing-box" ]; then
upsingbox
fi
cat > "$HOME/agsbx/sb.json" <<EOF
{
"log": {
    "disabled": false,
    "level": "info",
    "timestamp": true
  },
  "inbounds": [
EOF
insuuid
command -v openssl >/dev/null 2>&1 && openssl ecparam -genkey -name prime256v1 -out "$HOME/agsbx/private.key" >/dev/null 2>&1
command -v openssl >/dev/null 2>&1 && openssl req -new -x509 -days 36500 -key "$HOME/agsbx/private.key" -out "$HOME/agsbx/cert.pem" -subj "/CN=www.bing.com" >/dev/null 2>&1
if [ ! -f "$HOME/agsbx/private.key" ]; then
url="https://github.com/yonggekkk/argosbx/releases/download/argosbx/private.key"; out="$HOME/agsbx/private.key"; (command -v curl>/dev/null 2>&1 && curl -Ls -o "$out" --retry 2 "$url") || (command -v wget>/dev/null 2>&1 && timeout 3 wget -q -O "$out" --tries=2 "$url")
url="https://github.com/yonggekkk/argosbx/releases/download/argosbx/cert.pem"; out="$HOME/agsbx/cert.pem"; (command -v curl>/dev/null 2>&1 && curl -Ls -o "$out" --retry 2 "$url") || (command -v wget>/dev/null 2>&1 && timeout 3 wget -q -O "$out" --tries=2 "$url")
fi
if [ -n "$hyp" ]; then
hyp=hypt
if [ -z "$port_hy2" ] && [ ! -e "$HOME/agsbx/port_hy2" ]; then
port_hy2=$(shuf -i 10000-65535 -n 1)
echo "$port_hy2" > "$HOME/agsbx/port_hy2"
elif [ -n "$port_hy2" ]; then
echo "$port_hy2" > "$HOME/agsbx/port_hy2"
fi
port_hy2=$(cat "$HOME/agsbx/port_hy2")
echo "Hysteria2端口：$port_hy2"
cat >> "$HOME/agsbx/sb.json" <<EOF
    {
        "type": "hysteria2",
        "tag": "hy2-sb",
        "listen": "::",
        "listen_port": ${port_hy2},
        "users": [
            {
                "password": "${uuid}"
            }
        ],
        "ignore_client_bandwidth":false,
        "tls": {
            "enabled": true,
            "alpn": [
                "h3"
            ],
            "certificate_path": "$HOME/agsbx/cert.pem",
            "key_path": "$HOME/agsbx/private.key"
        }
    },
EOF
else
hyp=hyptargo
fi
if [ -n "$tup" ]; then
tup=tupt
if [ -z "$port_tu" ] && [ ! -e "$HOME/agsbx/port_tu" ]; then
port_tu=$(shuf -i 10000-65535 -n 1)
echo "$port_tu" > "$HOME/agsbx/port_tu"
elif [ -n "$port_tu" ]; then
echo "$port_tu" > "$HOME/agsbx/port_tu"
fi
port_tu=$(cat "$HOME/agsbx/port_tu")
echo "Tuic端口：$port_tu"
cat >> "$HOME/agsbx/sb.json" <<EOF
        {
            "type":"tuic",
            "tag": "tuic5-sb",
            "listen": "::",
            "listen_port": ${port_tu},
            "users": [
                {
                    "uuid": "${uuid}",
                    "password": "${uuid}"
                }
            ],
            "congestion_control": "bbr",
            "tls":{
                "enabled": true,
                "alpn": [
                    "h3"
                ],
                "certificate_path": "$HOME/agsbx/cert.pem",
                "key_path": "$HOME/agsbx/private.key"
            }
        },
EOF
else
tup=tuptargo
fi
if [ -n "$anp" ]; then
anp=anpt
if [ -z "$port_an" ] && [ ! -e "$HOME/agsbx/port_an" ]; then
port_an=$(shuf -i 10000-65535 -n 1)
echo "$port_an" > "$HOME/agsbx/port_an"
elif [ -n "$port_an" ]; then
echo "$port_an" > "$HOME/agsbx/port_an"
fi
port_an=$(cat "$HOME/agsbx/port_an")
echo "Anytls端口：$port_an"
cat >> "$HOME/agsbx/sb.json" <<EOF
        {
            "type":"anytls",
            "tag":"anytls-sb",
            "listen":"::",
            "listen_port":${port_an},
            "users":[
                {
                  "password":"${uuid}"
                }
            ],
            "padding_scheme":[],
            "tls":{
                "enabled": true,
                "certificate_path": "$HOME/agsbx/cert.pem",
                "key_path": "$HOME/agsbx/private.key"
            }
        },
EOF
else
anp=anptargo
fi
if [ -n "$arp" ]; then
arp=arpt
if [ -z "$ym_vl_re" ]; then
ym_vl_re=apple.com
fi
echo "$ym_vl_re" > "$HOME/agsbx/ym_vl_re"
echo "Reality域名：$ym_vl_re"
mkdir -p "$HOME/agsbx/sbk"
if [ ! -e "$HOME/agsbx/sbk/private_key" ]; then
key_pair=$("$HOME/agsbx/sing-box" generate reality-keypair)
private_key=$(echo "$key_pair" | awk '/PrivateKey/ {print $2}' | tr -d '"')
public_key=$(echo "$key_pair" | awk '/PublicKey/ {print $2}' | tr -d '"')
short_id=$("$HOME/agsbx/sing-box" generate rand --hex 4)
echo "$private_key" > "$HOME/agsbx/sbk/private_key"
echo "$public_key" > "$HOME/agsbx/sbk/public_key"
echo "$short_id" > "$HOME/agsbx/sbk/short_id"
fi
private_key_s=$(cat "$HOME/agsbx/sbk/private_key")
public_key_s=$(cat "$HOME/agsbx/sbk/public_key")
short_id_s=$(cat "$HOME/agsbx/sbk/short_id")
if [ -z "$port_ar" ] && [ ! -e "$HOME/agsbx/port_ar" ]; then
port_ar=$(shuf -i 10000-65535 -n 1)
echo "$port_ar" > "$HOME/agsbx/port_ar"
elif [ -n "$port_ar" ]; then
echo "$port_ar" > "$HOME/agsbx/port_ar"
fi
port_ar=$(cat "$HOME/agsbx/port_ar")
echo "Any-Reality端口：$port_ar"
cat >> "$HOME/agsbx/sb.json" <<EOF
        {
            "type":"anytls",
            "tag":"anyreality-sb",
            "listen":"::",
            "listen_port":${port_ar},
            "users":[
                {
                  "password":"${uuid}"
                }
            ],
            "padding_scheme":[],
            "tls": {
            "enabled": true,
            "server_name": "${ym_vl_re}",
             "reality": {
              "enabled": true,
              "handshake": {
              "server": "${ym_vl_re}",
              "server_port": 443
             },
             "private_key": "$private_key_s",
             "short_id": ["$short_id_s"]
            }
          }
        },
EOF
else
arp=arptargo
fi
if [ -n "$ssp" ]; then
ssp=sspt
if [ ! -e "$HOME/agsbx/sskey" ]; then
sskey=$("$HOME/agsbx/sing-box" generate rand 16 --base64)
echo "$sskey" > "$HOME/agsbx/sskey"
fi
if [ -z "$port_ss" ] && [ ! -e "$HOME/agsbx/port_ss" ]; then
port_ss=$(shuf -i 10000-65535 -n 1)
echo "$port_ss" > "$HOME/agsbx/port_ss"
elif [ -n "$port_ss" ]; then
echo "$port_ss" > "$HOME/agsbx/port_ss"
fi
sskey=$(cat "$HOME/agsbx/sskey")
port_ss=$(cat "$HOME/agsbx/port_ss")
echo "Shadowsocks-2022端口：$port_ss"
cat >> "$HOME/agsbx/sb.json" <<EOF
        {
            "type": "shadowsocks",
            "tag":"ss-2022",
            "listen": "::",
            "listen_port": $port_ss,
            "method": "2022-blake3-aes-128-gcm",
            "password": "$sskey"
    },  
EOF
else
ssp=ssptargo
fi
}

xrsbvm(){
if [ -n "$vmp" ]; then
vmp=vmpt
if [ -z "$port_vm_ws" ] && [ ! -e "$HOME/agsbx/port_vm_ws" ]; then
port_vm_ws=$(shuf -i 10000-65535 -n 1)
echo "$port_vm_ws" > "$HOME/agsbx/port_vm_ws"
elif [ -n "$port_vm_ws" ]; then
echo "$port_vm_ws" > "$HOME/agsbx/port_vm_ws"
fi
port_vm_ws=$(cat "$HOME/agsbx/port_vm_ws")
echo "Vmess-ws端口：$port_vm_ws"
if [ -n "$cdnym" ]; then
echo "$cdnym" > "$HOME/agsbx/cdnym"
echo "80系CDN或者回源CDN的host域名 (确保IP已解析在CF域名)：$cdnym"
fi
if [ -e "$HOME/agsbx/xr.json" ]; then
cat >> "$HOME/agsbx/xr.json" <<EOF
        {
            "tag": "vmess-xr",
            "listen": "::",
            "port": ${port_vm_ws},
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}"
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                  "path": "${uuid}-vm"
            }
        },
            "sniffing": {
            "enabled": true,
            "destOverride": ["http", "tls", "quic"],
            "metadataOnly": false
            }
         }, 
EOF
else
cat >> "$HOME/agsbx/sb.json" <<EOF
{
        "type": "vmess",
        "tag": "vmess-sb",
        "listen": "::",
        "listen_port": ${port_vm_ws},
        "users": [
            {
                "uuid": "${uuid}",
                "alterId": 0
            }
        ],
        "transport": {
            "type": "ws",
            "path": "${uuid}-vm",
            "max_early_data":2048,
            "early_data_header_name": "Sec-WebSocket-Protocol"
        }
    },
EOF
fi
else
vmp=vmptargo
fi
}

xrsbso(){
if [ -n "$sop" ]; then
sop=sopt
if [ -z "$port_so" ] && [ ! -e "$HOME/agsbx/port_so" ]; then
port_so=$(shuf -i 10000-65535 -n 1)
echo "$port_so" > "$HOME/agsbx/port_so"
elif [ -n "$port_so" ]; then
echo "$port_so" > "$HOME/agsbx/port_so"
fi
port_so=$(cat "$HOME/agsbx/port_so")
echo "Socks5端口：$port_so"
if [ -e "$HOME/agsbx/xr.json" ]; then
cat >> "$HOME/agsbx/xr.json" <<EOF
        {
         "tag": "socks5-xr",
         "port": ${port_so},
         "listen": "::",
         "protocol": "socks",
         "settings": {
            "auth": "password",
             "accounts": [
               {
               "user": "${uuid}",
               "pass": "${uuid}"
               }
            ],
            "udp": true
          },
            "sniffing": {
            "enabled": true,
            "destOverride": ["http", "tls", "quic"],
            "metadataOnly": false
            }
         }, 
EOF
else
cat >> "$HOME/agsbx/sb.json" <<EOF
    {
      "tag": "socks5-sb",
      "type": "socks",
      "listen": "::",
      "listen_port": ${port_so},
      "users": [
      {
      "username": "${uuid}",
      "password": "${uuid}"
      }
     ]
    },
EOF
fi
else
sop=soptargo
fi
}

xrsbout(){
if [ -e "$HOME/agsbx/xr.json" ]; then
sed -i '${s/,\s*$//}' "$HOME/agsbx/xr.json"
cat >> "$HOME/agsbx/xr.json" <<EOF
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "tag": "direct",
      "settings": {
        "domainStrategy":"${xryx}"
      }
    },
    {
      "tag": "x-warp-out",
      "protocol": "wireguard",
      "settings": {
        "secretKey": "${pvk}",
        "address": [
          "172.16.0.2/32",
          "${wpv6}/128"
        ],
        "peers": [
          {
            "publicKey": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
            "allowedIPs": [
              "0.0.0.0/0",
              "::/0"
            ],
            "endpoint": "${xendip}:2408"
          }
        ],
        "reserved": ${res}
      }
    },
    {
      "tag":"warp-out",
      "protocol":"freedom",
      "settings":{
        "domainStrategy":"${wxryx}"
      },
      "proxySettings":{
        "tag":"x-warp-out"
      }
    }
  ],
  "routing": {
    "domainStrategy": "IPOnDemand",
    "rules": [
      {
        "type": "field",
        "ip": [ ${xip} ],
        "network": "tcp,udp",
        "outboundTag": "${x1outtag}"
      },
      {
        "type": "field",
        "network": "tcp,udp",
        "outboundTag": "${x2outtag}"
      }
    ]
  }
}
EOF
if pidof systemd >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
cat > /etc/systemd/system/xr.service <<EOF
[Unit]
Description=xr service
After=network.target

[Service]
Type=simple
NoNewPrivileges=yes
TimeoutStartSec=0
ExecStart=/root/agsbx/xray run -c /root/agsbx/xr.json
Restart=on-failure
RestartSec=5s
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload >/dev/null 2>&1
systemctl enable xr >/dev/null 2>&1
systemctl start xr >/dev/null 2>&1
elif command -v rc-service >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
cat > /etc/init.d/xray <<EOF
#!/sbin/openrc-run
description="xr service"
command="/root/agsbx/xray"
command_args="run -c /root/agsbx/xr.json"
command_background=yes
pidfile="/run/xray.pid"
command_background="yes"
depend() {
    need net
}
EOF
chmod +x /etc/init.d/xray >/dev/null 2>&1
rc-update add xray default >/dev/null 2>&1
rc-service xray start >/dev/null 2>&1
else
nohup "$HOME/agsbx/xray" run -c "$HOME/agsbx/xr.json" >/dev/null 2>&1 &
fi
fi

if [ -e "$HOME/agsbx/sb.json" ]; then
sed -i '${s/,\s*$//}' "$HOME/agsbx/sb.json"
cat >> "$HOME/agsbx/sb.json" <<EOF
  ],
  "outbounds": [
    {
      "type": "direct",
      "tag": "direct"
    }
  ],
  "endpoints": [
    {
      "type": "wireguard",
      "tag": "warp-out",
      "address": [
        "172.16.0.2/32",
        "${wpv6}/128"
      ],
      "private_key": "${pvk}",
      "peers": [
        {
          "address": "${sendip}",
          "port": 2408,
          "public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
          "allowed_ips": [
            "0.0.0.0/0",
            "::/0"
          ],
          "reserved": $res
        }
      ]
    }
  ],
  "route": {
    "rules": [
      {
        "action": "sniff"
      },
      {
        "action": "resolve",
        "strategy": "${sbyx}"
      },
      {
        "ip_cidr": [ ${sip} ],
        "outbound": "${s1outtag}"
      }
    ],
    "final": "${s2outtag}"
  }
}
EOF
if pidof systemd >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
cat > /etc/systemd/system/sb.service <<EOF
[Unit]
Description=sb service
After=network.target

[Service]
Type=simple
NoNewPrivileges=yes
TimeoutStartSec=0
ExecStart=/root/agsbx/sing-box run -c /root/agsbx/sb.json
Restart=on-failure
RestartSec=5s
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload >/dev/null 2>&1
systemctl enable sb >/dev/null 2>&1
systemctl start sb >/dev/null 2>&1
elif command -v rc-service >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
cat > /etc/init.d/sing-box <<EOF
#!/sbin/openrc-run
description="sb service"
command="/root/agsbx/sing-box"
command_args="run -c /root/agsbx/sb.json"
command_background=yes
pidfile="/run/sing-box.pid"
command_background="yes"
depend() {
    need net
}
EOF
chmod +x /etc/init.d/sing-box >/dev/null 2>&1
rc-update add sing-box default >/dev/null 2>&1
rc-service sing-box start >/dev/null 2>&1
else
nohup "$HOME/agsbx/sing-box" run -c "$HOME/agsbx/sb.json" >/dev/null 2>&1 &
fi
fi
}

insargo(){
echo
echo "=========启用Argo隧道服务========="
if [ ! -e "$HOME/agsbx/cloudflared" ]; then
url="https://github.com/yonggekkk/argosbx/releases/download/argosbx/cloudflared-$cpu"; out="$HOME/agsbx/cloudflared"; (command -v curl>/dev/null 2>&1 && curl -Lo "$out" -# --retry 2 "$url") || (command -v wget>/dev/null 2>&1 && timeout 3 wget -O "$out" --tries=2 "$url")
chmod +x "$HOME/agsbx/cloudflared"
fi
if [ "$vmag" = yes ] || [ -n "$argo" ]; then
if [ -n "$ARGO_AUTH" ] && [ -n "$ARGO_DOMAIN" ]; then
echo "$ARGO_AUTH" > "$HOME/agsbx/argo.token"
echo "$ARGO_DOMAIN" > "$HOME/agsbx/argo.domain"
echo "Argo隧道固定域名：$ARGO_DOMAIN"
fi
if [ -f "$HOME/agsbx/argo.token" ] && [ -f "$HOME/agsbx/argo.domain" ]; then
argodomain=$(cat "$HOME/agsbx/argo.domain")
argotoken=$(cat "$HOME/agsbx/argo.token")
if [ -n "$port_vm_ws" ]; then
export port_argo=$port_vm_ws
elif [ -n "$port_vw" ]; then
export port_argo=$port_vw
else
export port_argo=$(cat "$HOME/agsbx/port_vm_ws" 2>/dev/null || cat "$HOME/agsbx/port_vw" 2>/dev/null)
fi
if pidof systemd >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
cat > /etc/systemd/system/argo.service <<EOF
[Unit]
Description=argo tunnel
After=network.target

[Service]
Type=simple
NoNewPrivileges=yes
TimeoutStartSec=0
ExecStart=/root/agsbx/cloudflared tunnel --edge-ip-version all --origin-start-procedure min-connections --protocol http2 --edge-bind-address :: run --token $argotoken
Restart=on-failure
RestartSec=5s
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload >/dev/null 2>&1
systemctl enable argo >/dev/null 2>&1
systemctl start argo >/dev/null 2>&1
elif command -v rc-service >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
cat > /etc/init.d/argo <<EOF
#!/sbin/openrc-run
description="argo service"
command="/root/agsbx/cloudflared"
command_args="tunnel --edge-ip-version all --origin-start-procedure min-connections --protocol http2 --edge-bind-address :: run --token $argotoken"
command_background=yes
pidfile="/run/argo.pid"
command_background="yes"
depend() {
    need net
}
EOF
chmod +x /etc/init.d/argo >/dev/null 2>&1
rc-update add argo default >/dev/null 2>&1
rc-service argo start >/dev/null 2>&1
else
nohup /root/agsbx/cloudflared tunnel --edge-ip-version all --origin-start-procedure min-connections --protocol http2 --edge-bind-address :: run --token "$argotoken" > /dev/null 2>&1 &
fi
else
if [ ! -f "$HOME/agsbx/cfgo" ]; then
url="https://raw.githubusercontent.com/yonggekkk/argosbx/main/cfgo"; out="$HOME/agsbx/cfgo"; (command -v curl>/dev/null 2>&1 && curl -Ls -o "$out" --retry 2 "$url") || (command -v wget>/dev/null 2>&1 && timeout 3 wget -q -O "$out" --tries=2 "$url")
fi
if [ ! -f "$HOME/agsbx/cfgo" ]; then
echo "yx3.991376.xyz" > "$HOME/agsbx/cfgo"
echo "yx2.991376.xyz" >> "$HOME/agsbx/cfgo"
echo "yx8.991376.xyz" >> "$HOME/agsbx/cfgo"
fi
argoym=$(sed -n '1p' "$HOME/agsbx/cfgo" 2>/dev/null)
argoym2=$(sed -n '2p' "$HOME/agsbx/cfgo" 2>/dev/null)
argoym3=$(sed -n '3p' "$HOME/agsbx/cfgo" 2>/dev/null)
if [ -z "$argoym" ]; then
argoym=yx3.991376.xyz
argoym2=yx2.991376.xyz
argoym3=yx8.991376.xyz
fi
if [ -n "$port_vm_ws" ]; then
export port_argo=$port_vm_ws
elif [ -n "$port_vw" ]; then
export port_argo=$port_vw
else
export port_argo=$(cat "$HOME/agsbx/port_vm_ws" 2>/dev/null || cat "$HOME/agsbx/port_vw" 2>/dev/null)
fi
if pidof systemd >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
cat > /etc/systemd/system/argo.service <<EOF
[Unit]
Description=argo tunnel
After=network.target

[Service]
Type=simple
NoNewPrivileges=yes
TimeoutStartSec=0
ExecStart=/root/agsbx/cloudflared tunnel --edge-ip-version all --origin-start-procedure min-connections --protocol http2 --edge-bind-address :: --url http://localhost:$port_argo
Restart=on-failure
RestartSec=5s
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload >/dev/null 2>&1
systemctl enable argo >/dev/null 2>&1
systemctl start argo >/dev/null 2>&1
elif command -v rc-service >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
cat > /etc/init.d/argo <<EOF
#!/sbin/openrc-run
description="argo service"
command="/root/agsbx/cloudflared"
command_args="tunnel --edge-ip-version all --origin-start-procedure min-connections --protocol http2 --edge-bind-address :: --url http://localhost:$port_argo"
command_background=yes
pidfile="/run/argo.pid"
command_background="yes"
depend() {
    need net
}
EOF
chmod +x /etc/init.d/argo >/dev/null 2>&1
rc-update add argo default >/dev/null 2>&1
rc-service argo start >/dev/null 2>&1
else
nohup /root/agsbx/cloudflared tunnel --edge-ip-version all --origin-start-procedure min-connections --protocol http2 --edge-bind-address :: --url http://localhost:"$port_argo" > "$HOME/agsbx/argo.log" 2>&1 &
fi
fi
fi
if [ -z "$argotoken" ]; then
sleep 3
if [ -n "$ARGO_DOMAIN" ]; then
export agn=$ARGO_DOMAIN
fi
if [ -n "$agn" ]; then
echo "$agn" > "$HOME/agsbx/argo.domain"
else
if [ pidof systemd >/dev/null 2>&1 ] && [ "$EUID" -eq 0 ]; then
export agn=$(journalctl -u argo -n 50 2>/dev/null | grep -oE '[a-zA-Z0-9.-]+\.trycloudflare\.com' | head -n 1)
else
export agn=$(grep -oE '[a-zA-Z0-9.-]+\.trycloudflare\.com' "$HOME/agsbx/argo.log" 2>/dev/null | head -n 1)
fi
if [ -n "$agn" ]; then
echo "$agn" > "$HOME/agsbx/argo.domain"
else
if [ pidof systemd >/dev/null 2>&1 ] && [ "$EUID" -eq 0 ]; then
export agn=$(journalctl -u argo -n 50 2>/dev/null | grep -oE '[a-zA-Z0-9.-]+\.trycloudflare\.com' | head -n 1)
else
export agn=$(grep -oE '[a-zA-Z0-9.-]+\.trycloudflare\.com' "$HOME/agsbx/argo.log" 2>/dev/null | head -n 1)
fi
if [ -n "$agn" ]; then
echo "$agn" > "$HOME/agsbx/argo.domain"
fi
fi
fi
export argodomain=$(cat "$HOME/agsbx/argo.domain" 2>/dev/null)
echo "Argo隧道固定域名：$argodomain"
fi
sendip=$argoym
xendip=$argoym
}

argosbxstatus(){
if [ -e "$HOME/agsbx/xr.json" ]; then
if pidof systemd >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
systemctl is-active xr >/dev/null 2>&1 && echo "Xray-core内核服务：正在运行中" || echo "Xray-core内核服务：未运行"
elif command -v rc-service >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
rc-service xray status >/dev/null 2>&1 && echo "Xray-core内核服务：正在运行中" || echo "Xray-core内核服务：未运行"
else
pgrep -x xray >/dev/null 2>&1 && echo "Xray-core内核服务：正在运行中" || echo "Xray-core内核服务：未运行"
fi
fi
if [ -e "$HOME/agsbx/sb.json" ]; then
if pidof systemd >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
systemctl is-active sb >/dev/null 2>&1 && echo "Sing-box内核服务：正在运行中" || echo "Sing-box内核服务：未运行"
elif command -v rc-service >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
rc-service sing-box status >/dev/null 2>&1 && echo "Sing-box内核服务：正在运行中" || echo "Sing-box内核服务：未运行"
else
pgrep -x sing-box >/dev/null 2>&1 && echo "Sing-box内核服务：正在运行中" || echo "Sing-box内核服务：未运行"
fi
fi
if pidof systemd >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
systemctl is-active argo >/dev/null 2>&1 && echo "Argo隧道服务：正在运行中" || echo "Argo隧道服务：未运行"
elif command -v rc-service >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
rc-service argo status >/dev/null 2>&1 && echo "Argo隧道服务：正在运行中" || echo "Argo隧道服务：未运行"
else
pgrep -f cloudflared >/dev/null 2>&1 && echo "Argo隧道服务：正在运行中" || echo "Argo隧道服务：未运行"
fi
}

get_link(){
local_ip=$(echo "$v4" | grep -oE '^[0-9.]+')
[ -z "$local_ip" ] && local_ip=$(echo "$v6" | grep -oE '^[0-9a-fA-F:]+')
if [ -z "$sxname" ]; then
if [ -n "$v4dq" ]; then
sxname="$v4dq-"
elif [ -n "$v6dq" ]; then
sxname="$v6dq-"
else
sxname=""
fi
fi
uuid=$(cat "$HOME/agsbx/uuid" 2>/dev/null)
if [ -e "$HOME/agsbx/xr.json" ]; then
public_key_x=$(cat "$HOME/agsbx/xrk/public_key" 2>/dev/null)
short_id_x=$(cat "$HOME/agsbx/xrk/short_id" 2>/dev/null)
ym_vl_re=$(cat "$HOME/agsbx/ym_vl_re" 2>/dev/null)
fi
if [ -e "$HOME/agsbx/sb.json" ]; then
public_key_s=$(cat "$HOME/agsbx/sbk/public_key" 2>/dev/null)
short_id_s=$(cat "$HOME/agsbx/sbk/short_id" 2>/dev/null)
ym_vl_re=$(cat "$HOME/agsbx/ym_vl_re" 2>/dev/null)
fi
argoym=$(sed -n '1p' "$HOME/agsbx/cfgo" 2>/dev/null)
argoym2=$(sed -n '2p' "$HOME/agsbx/cfgo" 2>/dev/null)
argoym3=$(sed -n '3p' "$HOME/agsbx/cfgo" 2>/dev/null)
if [ -z "$argoym" ]; then
argoym=yx3.991376.xyz
argoym2=yx2.991376.xyz
argoym3=yx8.991376.xyz
fi
argodomain=$(cat "$HOME/agsbx/argo.domain" 2>/dev/null)
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "节点配置信息如下："
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
if [ -n "$uuid" ]; then
if [ "$vmp" = vmpt ] || [ "$vmp" = vmptargo ]; then
if [ "$ippz" = 6 ] && [ -n "$v6" ]; then
echo "Vmess-ws-IPv6节点 (仅限支持IPv6的网络连接)："
echo "vmess://$(printf '%s' "{\"v\":\"2\",\"ps\":\"${sxname}Vmess-ws-v6\",\"add\":\"$v6\",\"port\":\"$port_vm_ws\",\"id\":\"$uuid\",\"aid\":\"0\",\"scy\":\"none\",\"net\":\"ws\",\"type\":\"none\",\"host\":\"$cdnym\",\"path\":\"/$uuid-vm\",\"tls\":\"none\",\"sni\":\"\",\"alpn\":\"\",\"fp\":\"\"}" | base64 | tr -d '\n')"
else
echo "Vmess-ws-IPv4节点："
echo "vmess://$(printf '%s' "{\"v\":\"2\",\"ps\":\"${sxname}Vmess-ws-v4\",\"add\":\"$v4\",\"port\":\"$port_vm_ws\",\"id\":\"$uuid\",\"aid\":\"0\",\"scy\":\"none\",\"net\":\"ws\",\"type\":\"none\",\"host\":\"$cdnym\",\"path\":\"/$uuid-vm\",\"tls\":\"none\",\"sni\":\"\",\"alpn\":\"\",\"fp\":\"\"}" | base64 | tr -d '\n')"
fi
echo "----------------------------------------------------------------------------"
echo "Argo隧道-Vmess-ws临时/固定优选域名节点一："
echo "vmess://$(printf '%s' "{\"v\":\"2\",\"ps\":\"${sxname}Argo-Vmess-ws1\",\"add\":\"$argoym\",\"port\":\"443\",\"id\":\"$uuid\",\"aid\":\"0\",\"scy\":\"none\",\"net\":\"ws\",\"type\":\"none\",\"host\":\"$argodomain\",\"path\":\"/$uuid-vm\",\"tls\":\"tls\",\"sni\":\"$argodomain\",\"alpn\":\"\",\"fp\":\"\"}" | base64 | tr -d '\n')"
echo "----------------------------------------------------------------------------"
echo "Argo隧道-Vmess-ws临时/固定优选域名节点二："
echo "vmess://$(printf '%s' "{\"v\":\"2\",\"ps\":\"${sxname}Argo-Vmess-ws2\",\"add\":\"$argoym2\",\"port\":\"443\",\"id\":\"$uuid\",\"aid\":\"0\",\"scy\":\"none\",\"net\":\"ws\",\"type\":\"none\",\"host\":\"$argodomain\",\"path\":\"/$uuid-vm\",\"tls\":\"tls\",\"sni\":\"$argodomain\",\"alpn\":\"\",\"fp\":\"\"}" | base64 | tr -d '\n')"
echo "----------------------------------------------------------------------------"
echo "Argo隧道-Vmess-ws临时/固定优选域名节点三："
echo "vmess://$(printf '%s' "{\"v\":\"2\",\"ps\":\"${sxname}Argo-Vmess-ws3\",\"add\":\"$argoym3\",\"port\":\"443\",\"id\":\"$uuid\",\"aid\":\"0\",\"scy\":\"none\",\"net\":\"ws\",\"type\":\"none\",\"host\":\"$argodomain\",\"path\":\"/$uuid-vm\",\"tls\":\"tls\",\"sni\":\"$argodomain\",\"alpn\":\"\",\"fp\":\"\"}" | base64 | tr -d '\n')"
echo "----------------------------------------------------------------------------"
fi

if [ "$vwp" = vwpt ] || [ "$vwp" = vwptargo ]; then
if [ "$ippz" = 6 ] && [ -n "$v6" ]; then
echo "Vless-ws-enc-IPv6节点 (仅限支持IPv6的网络连接)："
echo "vless://$uuid@$v6:$port_vw?encryption=none&security=none&type=ws&host=$cdnym&path=%2f$uuid-vw#${sxname}Vless-ws-v6"
else
echo "Vless-ws-enc-IPv4节点："
echo "vless://$uuid@$v4:$port_vw?encryption=none&security=none&type=ws&host=$cdnym&path=%2f$uuid-vw#${sxname}Vless-ws-v4"
fi
echo "----------------------------------------------------------------------------"
echo "Argo隧道-Vless-ws-enc临时/固定优选域名节点一："
echo "vless://$uuid@$argoym:443?encryption=none&security=tls&sni=$argodomain&type=ws&host=$argodomain&path=%2f$uuid-vw#${sxname}Argo-Vless-ws1"
echo "----------------------------------------------------------------------------"
echo "Argo隧道-Vless-ws-enc临时/固定优选域名节点二："
echo "vless://$uuid@$argoym2:443?encryption=none&security=tls&sni=$argodomain&type=ws&host=$argodomain&path=%2f$uuid-vw#${sxname}Argo-Vless-ws2"
echo "----------------------------------------------------------------------------"
echo "Argo隧道-Vless-ws-enc临时/固定优选域名节点三："
echo "vless://$uuid@$argoym3:443?encryption=none&security=tls&sni=$argodomain&type=ws&host=$argodomain&path=%2f$uuid-vw#${sxname}Argo-Vless-ws3"
echo "----------------------------------------------------------------------------"
fi

if [ "$vxp" = vxpt ] || [ "$vxp" = vxptargo ]; then
if [ "$ippz" = 6 ] && [ -n "$v6" ]; then
echo "Vless-xhttp-enc-IPv6节点 (仅限支持IPv6的网络连接)："
echo "vless://$uuid@$v6:$port_vx?encryption=none&security=none&type=xhttp&path=%2f$uuid-vx#${sxname}Vless-xhttp-v6"
else
echo "Vless-xhttp-enc-IPv4节点："
echo "vless://$uuid@$v4:$port_vx?encryption=none&security=none&type=xhttp&path=%2f$uuid-vx#${sxname}Vless-xhttp-v4"
fi
echo "----------------------------------------------------------------------------"
echo "Argo隧道-Vless-xhttp-enc临时/固定优选域名节点一："
echo "vless://$uuid@$argoym:443?encryption=none&security=tls&sni=$argodomain&type=xhttp&host=$argodomain&path=%2f$uuid-vx#${sxname}Argo-Vless-xhttp1"
echo "----------------------------------------------------------------------------"
echo "Argo隧道-Vless-xhttp-enc临时/固定优选域名节点二："
echo "vless://$uuid@$argoym2:443?encryption=none&security=tls&sni=$argodomain&type=xhttp&host=$argodomain&path=%2f$uuid-vx#${sxname}Argo-Vless-xhttp2"
echo "----------------------------------------------------------------------------"
echo "Argo隧道-Vless-xhttp-enc临时/固定优选域名节点三："
echo "vless://$uuid@$argoym3:443?encryption=none&security=tls&sni=$argodomain&type=xhttp&host=$argodomain&path=%2f$uuid-vx#${sxname}Argo-Vless-xhttp3"
echo "----------------------------------------------------------------------------"
fi

if [ "$xhp" = xhpt ] || [ "$xhp" = xhptargo ]; then
if [ "$ippz" = 6 ] && [ -n "$v6" ]; then
echo "Vless-xhttp-reality-enc-IPv6节点 (仅限支持IPv6的网络连接)："
echo "vless://$uuid@$v6:$port_xh?encryption=none&security=reality&sni=$ym_vl_re&fp=chrome&pbk=$public_key_x&sid=$short_id_x&type=xhttp&path=%2f$uuid-xh#${sxname}Xhttp-Reality-v6"
else
echo "Vless-xhttp-reality-enc-IPv4节点："
echo "vless://$uuid@$v4:$port_xh?encryption=none&security=reality&sni=$ym_vl_re&fp=chrome&pbk=$public_key_x&sid=$short_id_x&type=xhttp&path=%2f$uuid-xh#${sxname}Xhttp-Reality-v4"
fi
echo "----------------------------------------------------------------------------"
fi

if [ "$vlp" = vlpt ] || [ "$vlp" = vlptargo ]; then
if [ "$ippz" = 6 ] && [ -n "$v6" ]; then
echo "Vless-tcp-reality-vision-IPv6节点 (仅限支持IPv6的网络连接)："
echo "vless://$uuid@$v6:$port_vl_re?encryption=none&security=reality&sni=$ym_vl_re&fp=chrome&pbk=$public_key_x&sid=$short_id_x&type=tcp&flow=xtls-rprx-vision#${sxname}Reality-Vision-v6"
else
echo "Vless-tcp-reality-vision-IPv4节点："
echo "vless://$uuid@$v4:$port_vl_re?encryption=none&security=reality&sni=$ym_vl_re&fp=chrome&pbk=$public_key_x&sid=$short_id_x&type=tcp&flow=xtls-rprx-vision#${sxname}Reality-Vision-v4"
fi
echo "----------------------------------------------------------------------------"
fi

if [ "$hyp" = hypt ] || [ "$hyp" = hyptargo ]; then
if [ "$ippz" = 6 ] && [ -n "$v6" ]; then
echo "Hysteria2-IPv6节点 (仅限支持IPv6的网络连接)："
echo "hysteria2://$uuid@$v6:$port_hy2?insecure=1&alpn=h3#${sxname}Hy2-v6"
else
echo "Hysteria2-IPv4节点："
echo "hysteria2://$uuid@$v4:$port_hy2?insecure=1&alpn=h3#${sxname}Hy2-v4"
fi
echo "----------------------------------------------------------------------------"
fi

if [ "$tup" = tupt ] || [ "$tup" = tuptargo ]; then
if [ "$ippz" = 6 ] && [ -n "$v6" ]; then
echo "Tuic5-IPv6节点 (仅限支持IPv6的网络连接)："
echo "tuic://$uuid:$uuid@$v6:$port_tu?congestion_control=bbr&alpn=h3&allow_insecure=1#${sxname}Tuic5-v6"
else
echo "Tuic5-IPv4节点："
echo "tuic://$uuid:$uuid@$v4:$port_tu?congestion_control=bbr&alpn=h3&allow_insecure=1#${sxname}Tuic5-v4"
fi
echo "----------------------------------------------------------------------------"
fi

if [ "$anp" = anpt ] || [ "$anp" = anptargo ]; then
if [ "$ippz" = 6 ] && [ -n "$v6" ]; then
echo "Anytls-IPv6节点 (仅限支持IPv6的网络连接)："
echo "anytls://$uuid@$v6:$port_an?allow_insecure=1#${sxname}Anytls-v6"
else
echo "Anytls-IPv4节点："
echo "anytls://$uuid@$v4:$port_an?allow_insecure=1#${sxname}Anytls-v4"
fi
echo "----------------------------------------------------------------------------"
fi

if [ "$arp" = arpt ] || [ "$arp" = arptargo ]; then
if [ "$ippz" = 6 ] && [ -n "$v6" ]; then
echo "Any-Reality-IPv6节点 (仅限支持IPv6的网络连接)："
echo "anytls://$uuid@$v6:$port_ar?server_name=$ym_vl_re&reality=1&pbk=$public_key_s&sid=$short_id_s#${sxname}Anyreality-v6"
else
echo "Any-Reality-IPv4节点："
echo "anytls://$uuid@$v4:$port_ar?server_name=$ym_vl_re&reality=1&pbk=$public_key_s&sid=$short_id_s#${sxname}Anyreality-v4"
fi
echo "----------------------------------------------------------------------------"
fi

if [ "$ssp" = sspt ] || [ "$ssp" = ssptargo ]; then
sskey=$(cat $HOME/agsbx/sskey 2>/dev/null)
if [ "$ippz" = 6 ] && [ -n "$v6" ]; then
echo "Shadowsocks-2022-IPv6节点 (仅限支持IPv6的网络连接)："
echo "ss://$(printf '%s' "2022-blake3-aes-128-gcm:$sskey" | base64 | tr -d '\n')@[$v6]:$port_ss#${sxname}SS-v6"
else
echo "Shadowsocks-2022-IPv4节点："
echo "ss://$(printf '%s' "2022-blake3-aes-128-gcm:$sskey" | base64 | tr -d '\n')@$v4:$port_ss#${sxname}SS-v4"
fi
echo "----------------------------------------------------------------------------"
fi

if [ "$sop" = sopt ] || [ "$sop" = soptargo ]; then
if [ "$ippz" = 6 ] && [ -n "$v6" ]; then
echo "Socks5-IPv6节点 (仅限支持IPv6的网络连接)："
echo "socks://$uuid:$uuid@[$v6]:$port_so#${sxname}Socks5-v6"
else
echo "Socks5-IPv4节点："
echo "socks://$uuid:$uuid@$v4:$port_so#${sxname}Socks5-v4"
fi
echo "----------------------------------------------------------------------------"
fi
fi
if [ -f "$HOME/agsbx/subport.log" ]; then
echo "本地V2ray/Clash/Sing-box订阅链接如下："
if [ "$ippz" = 6 ] && [ -n "$v6" ]; then
echo "本地IP-v6订阅: http://[$v6]:$(cat $HOME/agsbx/subport.log 2>/dev/null)/$subid"
else
echo "本地IP-v4订阅: http://$v4:$(cat $HOME/agsbx/subport.log 2>/dev/null)/$subid"
fi
echo "----------------------------------------------------------------------------"
echo "Argo隧道临时/固定优选域名订阅一: http://$argoym/\$$(cat $HOME/agsbx/uuid 2>/dev/null)"
echo "----------------------------------------------------------------------------"
echo "Argo隧道临时/固定优选域名订阅一: http://$argoym2/\$$(cat $HOME/agsbx/uuid 2>/dev/null)"
echo "----------------------------------------------------------------------------"
echo "Argo隧道临时/固定优选域名订阅一: http://$argoym3/\$$(cat $HOME/agsbx/uuid 2>/dev/null)"
echo "----------------------------------------------------------------------------"
fi
}

uninstallsb(){
if pidof systemd >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
systemctl disable xr sb argo >/dev/null 2>&1
systemctl stop xr sb argo >/dev/null 2>&1
rm -f /etc/systemd/system/xr.service /etc/systemd/system/sb.service /etc/systemd/system/argo.service
systemctl daemon-reload >/dev/null 2>&1
elif command -v rc-service >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
rc-service xray stop >/dev/null 2>&1
rc-service sing-box stop >/dev/null 2>&1
rc-service argo stop >/dev/null 2>&1
rc-update del xray default >/dev/null 2>&1
rc-update del sing-box default >/dev/null 2>&1
rc-update del argo default >/dev/null 2>&1
rm -f /etc/init.d/xray /etc/init.d/sing-box /etc/init.d/argo
else
pkill -f xray
pkill -f sing-box
pkill -f cloudflared
fi
crontab -l 2>/dev/null | sed '/websbx/d' | crontab - >/dev/null 2>&1
rm -rf /etc/local.d/alpinesubsbx.start >/dev/null 2>&1
iptables -t nat -F PREROUTING >/dev/null 2>&1
ip6tables -t nat -F PREROUTING >/dev/null 2>&1
if [ -f /etc/iptables/rules.v4 ]; then
iptables-save > /etc/iptables/rules.v4
fi
if [ -f /etc/iptables/rules.v6 ]; then
ip6tables-save > /etc/iptables/rules.v6
fi
}

startsb(){
if [ -e "$HOME/agsbx/xr.json" ]; then
if pidof systemd >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
systemctl restart xr >/dev/null 2>&1
elif command -v rc-service >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
rc-service xray restart >/dev/null 2>&1
else
pkill -f xray
nohup "$HOME/agsbx/xray" run -c "$HOME/agsbx/xr.json" >/dev/null 2>&1 &
fi
fi
if [ -e "$HOME/agsbx/sb.json" ]; then
if pidof systemd >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
systemctl restart sb >/dev/null 2>&1
elif command -v rc-service >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
rc-service sing-box restart >/dev/null 2>&1
else
pkill -f sing-box
nohup "$HOME/agsbx/sing-box" run -c "$HOME/agsbx/sb.json" >/dev/null 2>&1 &
fi
fi
if [ -f "$HOME/agsbx/port_vm_ws" ] || [ -f "$HOME/agsbx/port_vw" ]; then
if pidof systemd >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
systemctl restart argo >/dev/null 2>&1
elif command -v rc-service >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
rc-service argo restart >/dev/null 2>&1
else
pkill -f cloudflared
argodomain=$(cat "$HOME/agsbx/argo.domain" 2>/dev/null)
argotoken=$(cat "$HOME/agsbx/argo.token" 2>/dev/null)
port_argo=$(cat "$HOME/agsbx/port_vm_ws" 2>/dev/null || cat "$HOME/agsbx/port_vw" 2>/dev/null)
if [ -n "$argotoken" ]; then
nohup /root/agsbx/cloudflared tunnel --edge-ip-version all --origin-start-procedure min-connections --protocol http2 --edge-bind-address :: run --token "$argotoken" > /dev/null 2>&1 &
else
nohup /root/agsbx/cloudflared tunnel --edge-ip-version all --origin-start-procedure min-connections --protocol http2 --edge-bind-address :: --url http://localhost:"$port_argo" > "$HOME/agsbx/argo.log" 2>&1 &
fi
fi
fi
}

reinssbx(){
if [ -f "$HOME/agsbx/port_vl_re" ]; then export port_vl_re=$(cat "$HOME/agsbx/port_vl_re"); vlp=yes; fi
if [ -f "$HOME/agsbx/port_vm_ws" ]; then export port_vm_ws=$(cat "$HOME/agsbx/port_vm_ws"); vmp=yes; vmag=yes; fi
if [ -f "$HOME/agsbx/port_vw" ]; then export port_vw=$(cat "$HOME/agsbx/port_vw"); vwp=yes; vmag=yes; fi
if [ -f "$HOME/agsbx/port_hy2" ]; then export port_hy2=$(cat "$HOME/agsbx/port_hy2"); hyp=yes; fi
if [ -f "$HOME/agsbx/port_tu" ]; then export port_tu=$(cat "$HOME/agsbx/port_tu"); tup=yes; fi
if [ -f "$HOME/agsbx/port_xh" ]; then export port_xh=$(cat "$HOME/agsbx/port_xh"); xhp=yes; fi
if [ -f "$HOME/agsbx/port_vx" ]; then export port_vx=$(cat "$HOME/agsbx/port_vx"); vxp=yes; fi
if [ -f "$HOME/agsbx/port_an" ]; then export port_an=$(cat "$HOME/agsbx/port_an"); anp=yes; fi
if [ -f "$HOME/agsbx/port_ss" ]; then export port_ss=$(cat "$HOME/agsbx/port_ss"); ssp=yes; fi
if [ -f "$HOME/agsbx/port_ar" ]; then export port_ar=$(cat "$HOME/agsbx/port_ar"); arp=yes; fi
if [ -f "$HOME/agsbx/port_so" ]; then export port_so=$(cat "$HOME/agsbx/port_so"); sop=yes; fi
if [ -f "$HOME/agsbx/ym_vl_re" ]; then export ym_vl_re=$(cat "$HOME/agsbx/ym_vl_re"); fi
if [ -f "$HOME/agsbx/cdnym" ]; then export cdnym=$(cat "$HOME/agsbx/cdnym"); fi
if [ -f "$HOME/agsbx/name" ]; then export name=$(cat "$HOME/agsbx/name" | sed 's/-//'); fi
if [ -f "$HOME/agsbx/argo.token" ] && [ -f "$HOME/agsbx/argo.domain" ]; then
export ARGO_DOMAIN=$(cat "$HOME/agsbx/argo.domain")
export ARGO_AUTH=$(cat "$HOME/agsbx/argo.token")
fi
rm -rf "$HOME/agsbx/xr.json" "$HOME/agsbx/sb.json"
uninstallsb
warpsx
[ "$vlp" = yes ] || [ "$vxp" = yes ] || [ "$vwp" = yes ] || [ "$xhp" = yes ] && installxray
[ "$hyp" = yes ] || [ "$tup" = yes ] || [ "$anp" = yes ] || [ "$arp" = yes ] || [ "$ssp" = yes ] && installsb
xrsbvm
xrsbso
xrsbout
insargo
}

pass_log=$(cat $HOME/agsbx/agpass.log 2>/dev/null)
rm -f $HOME/agsbx/agpass.log
if [ "$pass_log" = "list" ]; then
v4v6
get_link
exit
elif [ "$pass_log" = "upx" ]; then
upxray
startsb
exit
elif [ "$pass_log" = "ups" ]; then
upsingbox
startsb
exit
elif [ "$pass_log" = "res" ]; then
startsb
echo "Sing-box/Xray内核与Argo服务已重启"
exit
elif [ "$pass_log" = "del" ]; then
uninstallsb
rm -rf $HOME/agsbx
if [ -f /usr/local/bin/agsbx ]; then
rm -f /usr/local/bin/agsbx
fi
echo "原agsbx服务及相关缓存配置文件夹均已彻底卸载清空！再见"
exit
elif [ "$pass_log" = "rep" ]; then
reinssbx
echo "原配置参数变量组重置完成"
v4v6
get_link
argosbxstatus
exit
fi

if [ -f "$HOME/agsbx/port_vl_re" ] || [ -f "$HOME/agsbx/port_vm_ws" ] || [ -f "$HOME/agsbx/port_vw" ] || [ -f "$HOME/agsbx/port_hy2" ] || [ -f "$HOME/agsbx/port_tu" ] || [ -f "$HOME/agsbx/port_xh" ] || [ -f "$HOME/agsbx/port_vx" ] || [ -f "$HOME/agsbx/port_an" ] || [ -f "$HOME/agsbx/port_ss" ] || [ -f "$HOME/agsbx/port_ar" ] || [ -f "$HOME/agsbx/port_so" ]; then
reinssbx
echo "原已挂载的配置参数更新完成"
v4v6
get_link
argosbxstatus
exit
fi

warpsx
[ "$vlp" = yes ] || [ "$vxp" = yes ] || [ "$vwp" = yes ] || [ "$xhp" = yes ] && installxray
[ "$hyp" = yes ] || [ "$tup" = yes ] || [ "$anp" = yes ] || [ "$arp" = yes ] || [ "$ssp" = yes ] && installsb
xrsbvm
xrsbso
xrsbout
insargo

if [ ! -f /usr/local/bin/agsbx ] && [ "$EUID" -eq 0 ]; then
cat > /usr/local/bin/agsbx <<EOF
#!/bin/bash
if [ "\$1" = "list" ] || [ "\$1" = "upx" ] || [ "\$1" = "ups" ] || [ "\$1" = "res" ] || [ "\$1" = "del" ] || [ "\$1" = "rep" ]; then
mkdir -p \$HOME/agsbx
echo "\$1" > \$HOME/agsbx/agpass.log
bash <(curl -Ls $agsbxurl)
else
echo "快捷键指令错误，请遵循以下快捷键规范："
echo "---------------------------------------------------------"
bash <(curl -Ls $agsbxurl) res
fi
EOF
chmod +x /usr/local/bin/agsbx
fi

if [ "$sub" = "y" ] && [ -n "$subid" ] && [ -n "$subpt" ]; then
echo "$subid" > $HOME/agsbx/subid.log
echo "$subpt" > $HOME/agsbx/subport.log
mkdir -p $HOME/websbx
cat > $HOME/websbx/$subid <<EOF
$(get_link)
EOF
sed -i 's/节点配置信息如下：//g' $HOME/websbx/$subid
sed -i 's/本地V2ray\/Clash\/Sing-box订阅链接如下：//g' $HOME/websbx/$subid
sed -i 's/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//g' $HOME/websbx/$subid
sed -i '/本地IP-/d' $HOME/websbx/$subid
sed -i '/Argo隧道临时\/固定优选域名订阅/d' $HOME/websbx/$subid
sed -i '/^$/d' $HOME/websbx/$subid
if pidof systemd >/dev/null 2>&1 && [ "$EUID" -eq 0 ]; then
cat > /etc/systemd/system/websbx.service <<EOF
[Unit]
Description=websbx service
After=network.target

[Service]
Type=simple
NoNewPrivileges=yes
TimeoutStartSec=0
ExecStart=/usr/bin/busybox httpd -f -p $subpt -h /root/websbx
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload >/dev/null 2>&1
systemctl enable websbx >/dev/null 2>&1
systemctl start websbx >/dev/null 2>&1
elif command -v rc-service >/dev/null 2>&1; then
cat > /etc/local.d/alpinesubsbx.start <<EOF
#!/bin/bash
sleep 10
busybox-extras httpd -f -p $(cat $HOME/agsbx/subport.log 2>/dev/null) -h $HOME/websbx > /dev/null 2>&1 &
EOF
chmod +x /etc/local.d/alpinesubsbx.start
rc-update add local default >/dev/null 2>&1
else
crontab -l 2>/dev/null > /tmp/crontab.tmp
sed -i '/websbx/d' /tmp/crontab.tmp
echo "@reboot sleep 10 && /bin/bash -c \"busybox httpd -f -p $(cat $HOME/agsbx/subport.log 2>/dev/null) -h $HOME/websbx > /dev/null 2>&1 &\"" >> /tmp/crontab.tmp
crontab /tmp/crontab.tmp >/dev/null 2>&1
rm /tmp/crontab.tmp
fi
echo "本地IP订阅链接已更新完成"
fi
if [ -n "$hyjpt" ] && [ -n "$hyp" ]; then
echo
echo "设置Hysteria2协议的跳跃端口：$hyjpt"
iptables -t nat -F PREROUTING >/dev/null 2>&1
ip6tables -t nat -F PREROUTING >/dev/null 2>&1
hyport=$(cat "$HOME/agsbx/port_hy2" 2>/dev/null)
if [ -n "$hyport" ]; then
iptables -t nat -A PREROUTING -p udp --dport $hyjpt -j REDIRECT --to-ports $hyport >/dev/null 2>&1
ip6tables -t nat -A PREROUTING -p udp --dport $hyjpt -j REDIRECT --to-ports $hyport >/dev/null 2>&1
if [ -d /etc/iptables ]; then
iptables-save > /etc/iptables/rules.v4 >/dev/null 2>&1
ip6tables-save > /etc/iptables/rules.v6 >/dev/null 2>&1
fi
fi
fi
echo
get_link
argosbxstatus
exit
