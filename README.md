[![built with nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Built%20with%20Nix&color=41439a)](https://builtwithnix.org)

# NixOS System Configuration

## Installation

### Partitioning and encrypting the disk

```sh
# List drives
$ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
nvme0nX     259:0    0 931.5G  0 disk

# Export $DRIVE and $HOST var to environment
$ export HOST="hostname"
$ export DRIVE="/dev/nvme0nX"

# Pull in BTRFS dependencies
$ nix-shell -p btrfs-progs ssh-to-age

# Partition disk
$ printf "label: gpt\n,1500M,U\n,,L\n" | sfdisk "$DRIVE"

# List drives
$ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
nvme0nX     259:0    0 931.5G  0 disk
├─nvme0nXp1 259:1    0   1.5G  0 part
└─nvme0nXp2 259:2    0   930G  0 part

# Create BOOT partition
$ mkfs.fat -F 32 "$DRIVE"p1
$ fatlabel "$DRIVE"p1 ESP

# Optionally encrypt BTRFS partition
$ cryptsetup -y -v luksFormat "$DRIVE"p2 --label "$HOST"_crypt
$ cryptsetup luksOpen /dev/disk/by-label/"$HOST"_crypt "$HOST"

# Create BTRFS partition (if encrypted)
$ mkfs.btrfs /dev/mapper/"$HOST" -L "$HOST"

# Create BTRFS partition (if NOT encrypted)
$ mkfs.btrfs "$DRIVE"p2 -L "$HOST"

# Create BTRFS sub-volumes and a blank snapshot
$ mkdir -p /mnt
$ mount /dev/disk/by-label/"$HOST" /mnt
$ btrfs subv cr /mnt/@
$ btrfs subv cr /mnt/@nix
$ btrfs subv cr /mnt/@persist
$ btrfs subv cr /mnt/@swap
$ btrfs subvolume snapshot -r /mnt/@ /mnt/@blank
$ umount /mnt

# Mount partitions and create swap file
$ mount -o compress=zstd,noatime,subvol=@ /dev/disk/by-label/"$HOST" /mnt
$ mkdir -p /mnt/{boot,nix,persist,swap}
$ mount -o umask=0077 /dev/disk/by-label/ESP /mnt/boot
$ mount -o compress=zstd,noatime,subvol=@nix /dev/disk/by-label/"$HOST" /mnt/nix
$ mount -o compress=zstd,subvol=@persist /dev/disk/by-label/"$HOST" /mnt/persist
$ mount -o noatime,subvol=@swap /dev/disk/by-label/"$HOST" /mnt/swap
$ btrfs filesystem mkswapfile --size 8196M --uuid clear /mnt/swap/swapfile

# Copy SSH keys to /persist (if using optin-persistence)
$ mkdir -p /mnt/persist/etc/ssh
$ cp -av /etc/ssh/ssh_host_rsa_key /mnt/persist/etc/ssh
$ cp -av /etc/ssh/ssh_host_rsa_key.pub /mnt/persist/etc/ssh
$ cp -av /etc/ssh/ssh_host_ed25519_key /mnt/persist/etc/ssh
$ cp -av /etc/ssh/ssh_host_ed25519_key.pub /mnt/persist/etc/ssh

# Update the `.sops.yaml` file with the age key for the machine.
$ cat /mnt/persist/etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age

# Add the host's public keys to the config repository and re-encrypt secrets.

# Generate hardware-configuration.nix (only for reference if necessary)
$ nixos-generate-config --root /mnt

# Install NixOS
$ nixos-install --root /mnt --flake https://github.com/averagebit/nixos#"$HOST"
```
