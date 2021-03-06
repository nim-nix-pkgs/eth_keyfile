{
  description = ''A deprecated library for handling Ethereum private keys and wallets (now part of the 'eth' package)'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."eth_keyfile-master".dir   = "master";
  inputs."eth_keyfile-master".owner = "nim-nix-pkgs";
  inputs."eth_keyfile-master".ref   = "master";
  inputs."eth_keyfile-master".repo  = "eth_keyfile";
  inputs."eth_keyfile-master".type  = "github";
  inputs."eth_keyfile-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."eth_keyfile-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}