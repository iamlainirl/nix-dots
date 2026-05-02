{
    description = "reiru NixOS config";

    inputs = {
        nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?ref=nixos-unstable";

        home-manager = {
            url = "git+https://github.com/nix-community/home-manager?ref=master";
            inputs.nixpkgs.follows = "nixpkgs";
          };
      };

      outputs = { self, nixpkgs, home-manager, ... }:
        let
          system = "x86_64-linux";
          username = "reiru";
          hostname = "nixos";
        in {
            nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
                inherit system;

                modules = [
                  ./hosts/${hostname}/configuration.nix 
                  home-manager.nixosModules.home-manager
                  {
                      home-manager.useGlobalPkgs = true;
                      home-manager.useUserPackages = true;
                      home-manager.users.${username} = import ./home/${username}/home.nix;
                    }
                ];
              };
          };
  }
