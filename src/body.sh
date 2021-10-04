#!/usr/bin/env bash
# Inspired by mariuszkurek/convert.sh

# echo $EUID is also possible, but that method is useless in sudo.
if [ "$(id -u)" == "0" ]; then
	printf "This script should not be run as root.\nPermissions will be elevated automatically for system-wide tasks.\n"
	exit 1
fi
# Bash pipes commands on sync but parallelly, so this exits every pipe running in the shell if running as root.
[ $? == 1 ] && exit 1;

## User-wide jobs. Precaution notice, nothing else fancy for now.
__PRESCRIPT__

## System-wide jobs. The core part, this breaks and you system gets borked.
## If you use doas instead of sudo, then simply change the sudo to doas.
sudo bash -c '
__CONVERTSCRIPT__
' 2>/dev/null # 2>/dev/null is for error redirection.

## User-wide jobs. Some important cleanup jobs, especially for sway. Makes script more seamless.
__POSTSCRIPT__

# Sometimes the script gives out a non-0 exit code even when there are no errors.
[ $? != 0 ] && exit 0;
