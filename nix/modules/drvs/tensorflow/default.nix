{config, lib, ...}: let
  l = lib // builtins;
  python = config.deps.python;

in {

  imports = [
    ../../drv-parts/mach-nix-xs
  ];

  deps = {nixpkgs, ...}: {
    inherit (nixpkgs)
      postgresql
      fetchFromGitHub
      ;
  };

  public = {
    name = "tensorflow";
    version = "2.11.0";
  };

  mkDerivation = {
    preUnpack = ''
      export src=$(ls ${config.mach-nix.pythonSources}/names/${config.public.name}/*);
    '';
  };

  buildPythonPackage = {
    format = "wheel";
    pythonImportsCheck = [
      config.public.name
    ];
  };

  mach-nix.pythonSources = config.deps.fetchPythonRequirements {
    inherit (config.deps) python;
    name = config.public.name;
    requirementsList = ["${config.public.name}==${config.public.version}"];
    hash = "sha256-hnUe+iED9Q/6MjrDIHR8dNDUMZGPl+KBhHRs4NOnk88=";
    maxDate = "2023-01-01";
  };
}
