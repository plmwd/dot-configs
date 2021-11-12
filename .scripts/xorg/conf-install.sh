#!/bin/zsh
force=""
[[ "$1" = "-f" ]] && force="-f"

[[ ! -d /etc/xorg.conf.d ]] && sudo mkdir /etc/xorg.conf.d/

config_src_dir=$HOME/.config/xorg.conf.d/
[[ ! -z "$XDG_CONFIG_HOME" ]] && config_src_dir=$XDG_CONFIG_HOME/xorg.conf.d/

if [[ ! -d $config_src_dir ]]; then
	echo No xorg config found!
	exit 1
fi

for file in $config_src_dir/*; do
	sudo cp $force $file /etc/xorg.conf.d/ 
	if [[ $? -eq 0 ]]; then
		echo Installed $file to /etc/xorg.conf.d/$(basename $file)
	else
		echo $(basename $file) already exists in /etc/xorg.conf.d/
		echo You can force reinstallation with conf-install.sh -f
	fi
done
