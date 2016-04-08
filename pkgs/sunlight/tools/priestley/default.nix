{ pkgs, sunlight, haskellPackages, stdenv, moreutils, gitMinimal,
  makeWrapper, bash, gnumake, gnupg, nix }:

with haskellPackages; mkDerivation {
  pname = "priestley";
  version = "0.0.3";
  src = sunlight.fetch {name = "priestley";version = "0.0.3"; sha256 = "0zr57g6dlwqd0raj9zca80gxcjfk9l99xrzf04ppkaqmnlajz91x";};
  isLibrary = false;
  isExecutable = true;
  dontStrip = true;

  buildDepends = [ moreutils hlint
                   sunlight.vandusen makeWrapper ];
  testHaskellDepends = [ tasty doctest ];
  executableHaskellDepends = [ base cmdargs shelly aeson github
                               split wreq hslogger time lens bytestring
                               sunlight.public-keys pkgs.git MissingH
                               sunlight.vandusen gitMinimal
                               slack-notify-haskell ];

   postInstall = ''
     wrapProgram $out/bin/priestley \
         --suffix PATH : ${gitMinimal}/bin \
         --suffix PATH : ${bash}/bin:${gnumake}/bin \
         --suffix PATH : ${sunlight.public-keys}/bin \
         --suffix PATH : ${gnupg}/bin:${nix}/bin
   '';

  description = "CI System for sunlight";
  license = stdenv.lib.licenses.unfree;
}
