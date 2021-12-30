#!/usr/bin/env bash
# Inspired by mariuszkurek/convert.sh

# echo $EUID is also possible, but that method is useless in sudo.
if [ "$(id -u)" == "0" ]; then
	printf "This script should not be run as root.\nPermissions will be elevated automatically for system-wide tasks.\n"
	exit 1
fi
# Bash runs commands on sync but parallelly, so this exits every subshell already running in the shell if running as root.
[ $? == 1 ] && exit 1;


prescript(){
__PRESCRIPT__
}

#no. no manjaro. manjaro bad. convert fast. right now.
CONVERTER_MANJARNO(){
## System-wide jobs. The core part, this breaks and you system gets borked.
## If you use doas instead of sudo, then simply change the sudo to doas.
sudo bash -c '
__CONVERTSCRIPT_MANJARNO__
' 2>/dev/null # 2>/dev/null is for error redirection.
## User-wide jobs. Some important cleanup jobs, especially for sway. Makes script more seamless.
__POSTSCRIPT_MANJARNO__
}

#endeavour better. still not arch. let's convert.
CONVERTER_ENDEAVOUR(){
## System-wide jobs. The core part, this breaks and you system gets borked.
## If you use doas instead of sudo, then simply change the sudo to doas.
sudo bash -c '
__CONVERTSCRIPT_ENDEAVOUR__
' 2>/dev/null # 2>/dev/null is for error redirection.
## User-wide jobs. Some important cleanup jobs, especially for sway. Makes script more seamless.
__POSTSCRIPT_ENDEAVOUR__
}

DISTRO=$(prescript)

if [ "${DISTRO}" == "MANJARNO" ]; then
    CONVERTER_MANJARNO
else
    CONVERTER_ENDEAVOUR
fi


# Sometimes the script gives out a non-0 exit code even when there are no errors.
[ $? != 0 ] && exit 0;
