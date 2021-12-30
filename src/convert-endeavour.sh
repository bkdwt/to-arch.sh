# Run `pacman -Qq` and grep a pattern quietly
grepPacmanQuery() { # $1 - Pattern to grep for in the output of `pacman -Qq`
	pacman -Qq | grep "$1" -q
}

# Remove a package if it matched `pacman -Qq`
removeIfMatched() { # $1 - Pattern
	grepPacmanQuery "$1" && pacman -Rsdd "$1" --noconfirm
	true
}

pacman -Syy neofetch micro vim efibootmgr --noconfirm
neofetch
printf "This is your current distro state.\n"
tmp_dir="$(mktemp -d)"

rm -f /usr/share/libalpm/hooks/eos*

# Fret not, my friend, as our trustworthy yay would AUR itself when updating
pacman -Sl endeavouros | cut -f 2 -d' '>/tmp/endeavouros_pkglist
while read line; do
    removeIfMatched $line
done < /tmp/endeavouros_pkglist

if [ "$(cat /etc/pacman.conf | grep '\[endeavouros\]')" ]; then
	sudo sed -ie '/\[endeavouros\]/,+2d' /etc/pacman.conf
fi

[ -f /etc/pacman.d/endeavouros-mirrorlist ] && rm /etc/pacman.d/endeavouros-mirrorlist

(
	cd /etc/pacman.d
	rm mirrorlist
	# Get mirrorlist
	curl -o mirrorlist -sL 'https://archlinux.org/mirrorlist/?country=all&protocol=http&protocol=https&ip_version=4&ip_version=6'
	
	
	
	[ -f /etc/pacman.d/mirrorlist.pacnew ] && rm /etc/pacman.d/mirrorlist.pacnew
	[ -f /etc/pacman.conf.pacnew ] && rm /etc/pacman.conf.pacnew
	
	sed -i '/SyncFirst/d' /etc/pacman.conf
	sed -i '/HoldPkg/d' /etc/pacman.conf
	
	# Use $VISUAL instead?
	printf "==> Uncomment mirrors from your country.\nPress 1 for Nano, 2 for vim, 3 for vi, 4 for micro, or any other key for your default \$EDITOR.\n"
	read -rn 1 whateditor
	case "$whateditor" in
		"1") nano /etc/pacman.d/mirrorlist ;;
		"2") vim /etc/pacman.d/mirrorlist ;;
		"3") vi /etc/pacman.d/mirrorlist ;;
		"4") micro /etc/pacman.d/mirrorlist ;;
		*) $EDITOR /etc/pacman.d/mirrorlist ;;
	esac
	
	# Backup just in case
	cp /etc/pacman.d/mirrorlist "${tmp_dir}/mirrorlist"
)

[ -f /etc/os-release ] && sed -i 's/EndeavourOS/Arch Linux/g' /etc/os-release
[ -f /etc/os-release ] && sed -i 's/ID=endeavouros/ID=arch/g' /etc/os-release
[ -f /etc/os-release ] && sed -i 's/https:\/\/endeavouros\.com/https:\/\/archlinux\.org/g' /etc/os-release
[ -f /etc/os-release ] && sed -i 's/https:\/\/discovery\.endeavouros\.com/https:\/\/archlinux\.org/g' /etc/os-release
[ -f /etc/os-release ] && sed -i 's/SUPPORT_URL='"'"'https:\/\/forum\.endeavouros\.com'"'"'/SUPPORT_URL='"'"'https:\/\/bbs\.archlinux\.org'"'"'/g' /etc/os-release
[ -f /etc/os-release ] && sed -i 's/BUG_REPORT_URL='"'"'https:\/\/forum\.endeavouros\.com.*'"'"'/SUPPORT_URL='"'"'https:\/\/bugs\.archlinux\.org'"'"'/g' /etc/os-release

[ -f /etc/issue ] && sed -i 's/EndeavourOS/Arch/g' /etc/issue
pacman -Syyu --overwrite \* lsb-release --noconfirm

sed -i '/GRUB_DISTRIBUTOR="EndeavourOS"/c\GRUB_DISTRIBUTOR="Arch"' /etc/default/grub
if ! [ "$(bootctl is-installed | grep -i yes)" ]; then
	curl -fLs https://github.com/AdisonCavani/distro-grub-themes/releases/latest/download/arch.tar -o /tmp/arch.tar
	[ -d /boot/grub/themes/archlinux ] && rm -rf /boot/grub/themes/archlinux
	mkdir /boot/grub/themes/archlinux
	tar -xf /tmp/arch.tar -C /boot/grub/themes/archlinux
	sed -i '/GRUB_THEME=/c GRUB_THEME="/boot/grub/themes/archlinux/theme.txt"' /etc/default/grub
	# Generate GRUB stuff
	grub-mkconfig -o /boot/grub/grub.cfg

else 
    bootctl update
    printf "Systemd-boot users have to edit the updated the entries manually.\nYou're on your own."
fi

neofetch
printf "Now it's Arch! Enjoy!\n"
