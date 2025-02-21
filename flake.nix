{
description = "Basic config";

inputs = {
nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
home-manager = {
url = "github:nix-community/home-manager/release-24.11";
inputs.nixpkgs.follows = "nixpkgs";
};
stylix = {
url = "github:danth/stylix/release-24.11";
inputs.nixpkgs.follows = "nixpkgs";
};
};

outputs = {self , nixpkgs , home-manager , stylix , ... } @ inputs: 
let
lib = nixpkgs.lib;
system = "x86_64-linux";
pkgs = nixpkgs.legacyPackages.${system};
in
{
nixosConfigurations.nixos = lib.nixosSystem {
inherit system;
modules = [
./nixos/configuration.nix
home-manager.nixosModules.home-manager
{
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jiten = import ./home/jiten.nix;
}
stylix.nixosModules.stylix
];
};

#homeConfigurations."jiten" = home-manager.lib.homeManagerConfiguration {
#inherit pkgs;
#modules = [ ./home/jiten.nix ];
#};

};
}
