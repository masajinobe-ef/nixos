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

Desktop build:

```sh
sudo nixos-rebuild switch --flake .#desktop --impure
```

Laptop build:

```sh
sudo nixos-rebuild switch --flake .#laptop --impure
```

Post-install script for init secrets:

```sh
sudo chmod +x secrets.sh && ./secrets.sh
```

# Rebuild from remote / Deploy on another host machine

Desktop build

```sh
sudo nixos-rebuild switch --flake github:masajinobe-ef/nixos#desktop --impure
```

Laptop build

```sh
sudo nixos-rebuild switch --flake github:masajinobe-ef/nixos#laptop --impure
```
