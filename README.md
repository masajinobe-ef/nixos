# NixOS

# Clone

```sh
git clone https://github.com/masajinobe-ef/nixos --depth=1
```

## Check configuration

```sh
nix flake check
```

## Build from local dir after git clone

desktop build:

```sh
sudo nixos-rebuild switch --flake .#desktop
```

laptop build:

```sh
sudo nixos-rebuild switch --flake .#laptop
```

Post-install script for init secrets:

```sh
sudo chmod +x secrets.sh && ./secrets.sh
```

# Rebuild from remote / Deploy on another host machine

desktop build

```sh
sudo nixos-rebuild switch --flake github:masajinobe-ef/nixos#desktop
```

laptop build

```sh
sudo nixos-rebuild switch --flake github:masajinobe-ef/nixos#laptop
```
