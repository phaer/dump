{
  description = "Mono repo of DavHau";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgsPython.url = "github:davhau/nixpkgs/davhau-fetchPythonRequirements";
    nixpkgsStable.url = "nixpkgs/nixos-22.11";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    drv-parts.url = "github:DavHau/drv-parts/package";
    drv-parts.inputs.nixpkgs.follows = "nixpkgs";
    drv-parts.inputs.flake-parts.follows = "flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {

      systems = [
        "x86_64-linux"
      ];

      imports = [
        ./nix/modules/flake-parts/all-modules.nix
      ];
    };
}
