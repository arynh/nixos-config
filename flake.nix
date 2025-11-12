{
  description = "home-manager configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    sops-nix,
  }: {
    # configuration for mac using nix-darwin
    # to switch, run `sudo darwin-rebuild switch --flake /path/to/this/flake`
    darwinConfigurations."magical-computer" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        home-manager.darwinModules.home-manager
        ./hosts/macbook-pro.nix
        sops-nix.darwinModules.sops
      ];
    };

    # configuration for a linux machine using just home-manager
    # to switch, run `home-manager switch --flake /path/to/this/flake`
    homeConfigurations."aryn" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {system = "x86_64-linux";};
      modules = [
        ./hosts/wsl-desktop.nix
      ];
    };
  };
}
