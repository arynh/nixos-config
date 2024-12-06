# nixos/home-manager configs

Use nix-darwin and home-manager to configure my development environments. These
directions assume this repo is checked out into `~/.config/home-manager`.

## References

- Home Manager Manual: <https://nix-community.github.io/home-manager/>
- Useful Home Manager Docs: <https://mynixos.com/home-manager/options/programs>
- Inspiration: <https://davi.sh/blog/2024/02/nix-home-manager/>
- Slightly better inspiration: <https://xyno.space/post/nix-darwin-introduction>

## MacOS/nix-darwin Steps

1. Get the nix toolchain: <https://nixos.org/download/>
2. Get Homebrew: <https://brew.sh/>
3. Run this flake for the first time: `nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/home-manager`. This will build _everything_ and install the requisite packages from Homebrew.
4. For subsequent iterations, the nix-darwin commands will be installed, so reconstructing can be done with `darwin-rebuild switch --flake ~/.config/home-manager`.

## Linux/home-manager Standalone Steps

1. Get the nix toolchain: <https://nixos.org/download/>
2. Run this flake for the first time: `nix run home-manager --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/home-manager`. This will build _everything_ and install the requisite packages from Homebrew.
3. For subsequent iterations, the home-manager commands will be installed, so reconstructing can be done with `home-manager switch --flake ~/.config/home-manager`.

## Todo

- ~~Modularize the configurations so they can be reused.~~
- ~~Account for mac vs linux configs.~~
- ~~tmux config~~
- ~~zsh configuration~~
- ~~nvim config (should this be pure nix? might be impractical but it would be portable)~~
