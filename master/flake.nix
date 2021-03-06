{
  description = ''Tools for handling the encrypted keyfile format used to store Ethereum private keys'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-eth_keyfile-master.flake = false;
  inputs.src-eth_keyfile-master.ref   = "refs/heads/master";
  inputs.src-eth_keyfile-master.owner = "status-im";
  inputs.src-eth_keyfile-master.repo  = "nim-eth-keyfile";
  inputs.src-eth_keyfile-master.type  = "github";
  
  inputs."nimcrypto".owner = "nim-nix-pkgs";
  inputs."nimcrypto".ref   = "master";
  inputs."nimcrypto".repo  = "nimcrypto";
  inputs."nimcrypto".dir   = "master";
  inputs."nimcrypto".type  = "github";
  inputs."nimcrypto".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimcrypto".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."eth_keys".owner = "nim-nix-pkgs";
  inputs."eth_keys".ref   = "master";
  inputs."eth_keys".repo  = "eth_keys";
  inputs."eth_keys".dir   = "master";
  inputs."eth_keys".type  = "github";
  inputs."eth_keys".inputs.nixpkgs.follows = "nixpkgs";
  inputs."eth_keys".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-eth_keyfile-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-eth_keyfile-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}