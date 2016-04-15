/* This file defines the composition for all sunlight packages */

{ fetchgit, stdenv, callPackage, haskellPackages }:

let
  self = _self;
  _self = with self; {
    fetch = { name, version, sha256 }: fetchgit {
      inherit sha256;
      name = "sunlight-${name}-${version}";
      url = "https://5037df0e19bf2fe602028298fd45ca753e8600fb@github.com/ProjectSunlight/${name}.git";
      rev = "refs/tags/${version}";
    } // { inherit rev; };

   terraform = callPackage ../sunlight/tools/terraform {};

/* -- START-SUNLIGHT-PACKAGES -- */
    public-keys = callPackage ../sunlight/public-keys {};
    vandusen = callPackage ../sunlight/tools/vandusen {};
    thorndyke = callPackage ../sunlight/system/thorndyke {};
    priestley = callPackage ../sunlight/tools/priestley {};
/* -- END-SUNLIGHT-PACKAGES -- */
}; in self
