#!/bin/bash
OS=$(uname -o)
if [[ ${OS^^} == *'MSYS'* || ${OS^^} == *'WINDOWS'* ]]; then
  PREFIX="/usr"
  adminPerm=$(net user administrator | grep active | awk '{print $NF}')
  case ${adminPerm,,} in
    yes) opposite="no";;
    no) opposite="yes";;
    *) printf "Not possible to run this\n"; exit 1;;
  esac
  net user administrator /active:${opposite} >/dev/null 2>&1
  adminPerm=$(net user administrator | grep active | awk '{print $NF}')
  if [[ ${adminPerm,,} != "${opposite}" ]]; then
    printf "${S2}[${S1}!${S2}]${S4}Run this command prompt or shell in Administrator mode${R0}\n"
    exit 1
  fi
fi
curl -s google.com >/dev/null 2>&1
if [ "$?" != '0' ]; then
    printf "\033[1;2;4;5;32m[\033[31m!\033[32m] \033[34mCheck your internet connection!\033[0;0;0;0;00m\n"
    exit 1
fi
printf "\033[32mSetting-up cloudflare in your system\033[00m\n"
cd $PREFIX/share >/dev/null 2>&1
rm -rf $PREFIX/share/cloudflare-ui >/dev/null 2>&1
git clone https://github.com/BHUTUU/cloudflare-ui
ver=$(cloudflared --version | awk '{print $2}')
if [[ $ver != 'version' ]]; then
    rm -rf $PREFIX/bin/cloudflared >/dev/null 2>&1
fi
if ! hash cloudflared >/dev/null 2>&1; then
    source <(curl -fsSL "https://git.io/JinSa")
fi
cat <<- VAR > $PREFIX/bin/cloudflare
#!/bin/bash
arg1="\$1"
arg2="\$2"
arg3="\$3"
cd $PREFIX/share/cloudflare-ui
bash cloudflare \${arg1} \${arg2} \${arg3}
VAR
chmod +x $PREFIX/bin/cloudflare
printf "\n\nConfiguration completed just run 'clouflare --help' for help\n\n"
