{opencv-version}:
let
  overlay = self: super: {
    opencv_3_3 = (super.opencv3.override {
      enableContrib = false;
      enableCuda = false;
      enableJPEG = false;
      enablePNG = false;
      enableWebP = false;
      enableEigen = false;
      enableOpenblas = false;
    }).overrideAttrs (oldAttrs: {
      version = "3.3.1";
      src = super.fetchFromGitHub {
        owner  = "opencv";
        repo   = "opencv";
        rev    = "3.3.1";
        sha256 = "1jq8nny78gp54yjgsnb2rdp5rwhp78b3r2i36b2vyx6xk6h6wwji";
      };
      enableParallelBuilding = false;
      preConfigure = oldAttrs.preConfigure + "export CXXFLAGS=-fpermissive";
    });

    python3 = super.python3.override {
      packageOverrides = py-self: py-super: {

        opencv_3_3 = py-super.toPythonModule (self.opencv_3_3.override {
          enablePython = true;
          pythonPackages = py-self;
        });

        opencv_3_4 = py-super.opencv3;

        opencv_4_1 = py-super.opencv4;
      };
    };

    my-python-env = self.python3.withPackages
      (ps: with ps; [
        numpy
        pytest
        (if opencv-version == "3.3" then opencv_3_3
         else if opencv-version == "3.4" then opencv_3_4
         else if opencv-version == "4.1" then opencv_4_1
         else abort "opencv-version should be one of [3.3, 3.4, 4.1]")
      ]);
  };

  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-20.03.tar.gz";
    sha256 = "0mydmhr1fm5l0p668wx5wlk3six7k3n56sz41fv0h9zms0lqszf9";
  }) { overlays = [overlay]; };

in pkgs.dockerTools.buildLayeredImage {
  name = "renatogarcia/opencv-swig-ci";
  tag = "opencv-${opencv-version}";

  contents = with pkgs; [ bash coreutils gcc gnumake cmake swig4 boost.dev my-python-env ];

  config = {
    WorkingDir = "/data";
    Env = ["BOOST_INCLUDEDIR=/nix/store/18xq3kfvzf860jmswhgva3gjjjgmnchl-boost-1.69.0-dev/include"];
  };

  maxLayers = 120;
  created = "now";
}
