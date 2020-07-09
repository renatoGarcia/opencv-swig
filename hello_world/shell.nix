let
  pkgs = import <nixpkgs> {};
  opencv-swig = pkgs.callPackage (
    fetchTarball https://github.com/renatoGarcia/opencv-swig/archive/v1.0.1.tar.gz
  ) {};

in pkgs.mkShell {
  buildInputs = [
    opencv-swig
    pkgs.boost
    pkgs.swig
    pkgs.cmake
    pkgs.pythonPackages.opencv
  ];
}
