# Manjaro to Arch conversion script
![](https://img.shields.io/github/downloads/igrshi-kske/manjaro-to-arch.sh/total)<br>
This is a script to convert a Manjaro installation to an Arch installation with a single command for users who want a fuss-free conversion from Manjaro to Arch. <br>This script is inspired by [this gist](https://gist.github.com/mariuszkurek/bff8a821076f5406b15fe9be528957b6/).<br>

## Showcase(7x speedup)

https://user-images.githubusercontent.com/90227297/132807588-8757a8c6-eea3-47bb-8231-53fbac0a0105.mp4

https://user-images.githubusercontent.com/90227297/138561089-12f7fa8e-270d-484b-8b1d-24897a22872d.mp4

## Why did I write this?

### Why not?

## How this script works

The main difference of pure Arch and Manjaro is that they use different mirrors. Manjaro uses slightly old versions of a package for testing, so changing it to Arch mirrors is the first step.<br>Then the script deletes Manjaro-specific packages and Pacman configurations, and enables the multilib repository if it's commented out.<br>After that, the script performs a `pacman -Syyuu` so that the packages are updated and installs an Arch kernel.<br>Finally GRUB is updated to have Arch's theme and the distributor name is changed to `Arch` by installing `lsb-release` from the Arch Linux website.<br>Finally DE-specific operations are performed to give a better polished result.
