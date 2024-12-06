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
  };

  outputs = {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
  }: {
    # configuration for mac using nix-darwin
    # to switch, run `darwin-rebuild switch --flake /path/to/this/flake`
    darwinConfigurations."magical-computer" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        home-manager.darwinModules.home-manager
        ./hosts/macbook-pro.nix
      ];
    };

    # configuration for a linux machine using just home-manager
    # to switch, run `home-manager switch --flake /path/to/this/flake`
    # I don't have a linux machine right now, but this is where it would go
    # homeConfigurations."hostname" = home-manager.lib.homeManagerConfiguration {
    #   pkgs = import nixpkgs { system = "x86_64-linux"; };
    #   modules = [];
    # };
  };
}
