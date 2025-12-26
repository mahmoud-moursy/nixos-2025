# NixOS Config (Starting Late 2025)

I wanted to start fresh with my Linux distro.

Setup featuring:
- Impermanence (nukes and restores system on every reboot)
- ZFS (with dedup!)
- NVIDIA Drivers (with working suspend!!!)
- Pop! COSMIC Desktop Environment
- Syncthing for my local files

The config excludes a few files, including `users/passwords` which stores hashed password files.
They would be theoretically safe to share if encrypted beforehand, but that's just too much headache.

I couldn't be bothered with any of that sops-nix or agenix stuff for secret storage,
so in order to properly recompile my system flake I just pass it as `--flake path:/etc/nixos`,
which means instead of using the files in the Git tree, `nixos-rebuild` uses the filesystem files...
so `users/passwords`, which is in .gitignore (and not synced), will show up.
