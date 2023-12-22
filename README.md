# My dotfiles for setting up NixOs with Wayland (dwl + waybar)

## Disk layout with encryption
This is mostly taken & adapted from [gist by martijnvermaat](https://gist.github.com/martijnvermaat/76f2e24d0239470dd71050358b4d5134)
### Main partitioning (via fdisk or similar)
Create two partitions:
 1. Boot (1G), fat32, label `boot` (`mkfs.fat -n boot /dev/partition-1`)
 2. Main encrypted partition (rest of the dist), setup below

### Cryptsetup
Encrypt main partition:
```shell
$ cryptsetup luksFormat /dev/partition-2
$ cryptsetup config /dev/partition-2 --label nix-encrypted-root
$ cryptsetup luksOpen /dev/partition-2 nixos
```

Create partitions on encrypted LVM:
```shell
$ vcreate /dev/mapper/nixos
$ vgcreate nixos-vg /dev/mapper/nixos
$ lvcreate -L 16G -n swap nixos-vg
$ lvcreate -L 120G -n root nixos-vg
$ lvcreate -L 200G -n data nixos-vg
$ lvcreate -l '100%FREE' -n home nixos-vg
```

Create filesystems
```shell
$ mkfs.ext4 -L nixos /dev/nixos-vg/root
$ mkfs.ext4 -L data /dev/nixos-vg/data
$ mkfs.ext4 -L home /dev/nixos-vg/home
$ mkswap -L swap /dev/nixos-vg/swap
```

Mount and install
```shell
$ mount /dev/nixos-vg/root /mnt
$ mkdir /mnt/home
$ mount /dev/nixos-vg/home /mnt/home
$ mkdir /mnt/data
$ mount /dev/nixos-vg/data /mnt/data
$ mkdir /mnt/boot
$ mount /dev/partition-1 /mnt/boot
$ swapon /dev/nixos-vg/swap
$ nixos-generate-config --root /mnt
```

Copy this config (requires `armeeh` user to exist and dotfiles to be installed via `install.sh` as said user)
```shell
$ cp configuration.nix hardware-configuration.nix /etc/nixos/
$ nixos-install
$ reboot
```
