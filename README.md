# NixOS

# Deploy local after git clone

```sh
sudo nixos-rebuild switch --flake .#desktop
```

```sh
sudo nixos-rebuild switch --flake .#laptop
```

# Deploy from remote repo

```sh
sudo nixos-rebuild switch --flake github:masajinobe-ef/nixos#desktop
```

```sh
sudo nixos-rebuild switch --flake github:masajinobe-ef/nixos#laptop
```

# Check configuration

```sh
nix flake check --impure
```
