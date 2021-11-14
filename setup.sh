#!/bin/bash
printf "\033[32mSetting-up cloudflare in your system\033[00m\n"
cd $PREFIX/share
git clone https://github.com/BHUTUU/cloudflare-ui
cat <<- VAR > $PREFIX/bin/cloudflare
#!/bin/bash
arg1="\$1"
arg2="\$2"
cd $PREFIX/share/cloudflare-ui
bash cloudflare \${arg1} \${arg2}
VAR
chmod +x $PREFIX/bin/cloudflare
printf "\n\nConfiguration completed just run 'clouflare --help' for help\n\n"
