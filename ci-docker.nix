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

    opencv_4_0 = (super.opencv4.override {
      enableJPEG = false;
      enablePNG = false;
      enableWebP = false;
      enableEigen = false;
      enableOpenblas = false;
      enableContrib = false;
      enableCuda = false;
    }).overrideAttrs (oldAttrs: {
      version = "4.0.1";
      src = super.fetchFromGitHub {
        owner  = "opencv";
        repo   = "opencv";
        rev    = "4.0.1";
        sha256 = "1f0n2a57sn47w55vaxlwhr3g6xgchvr3gxicxbkyzai3pvj55k48";
      };
    });

    opencv_4_2 = (super.opencv4.override {
      enableJPEG = false;
      enablePNG = false;
      enableWebP = false;
      enableEigen = false;
      enableOpenblas = false;
      enableContrib = false;
      enableCuda = false;
    }).overrideAttrs (oldAttrs: {
      version = "4.2.0";
      src = super.fetchFromGitHub {
        owner  = "opencv";
        repo   = "opencv";
        rev    = "4.2.0";
        sha256 = "1bm8nrhbd4zw11r25hhzbsk3ddy7p2w2x9hd8i9pbbn01cxksmhx";
      };

      cmakeFlags = oldAttrs.cmakeFlags ++ ["-DBUILD_opencv_imgcodecs=OFF"];
    });

    opencv_4_3 = (super.opencv4.override {
      enableJPEG = false;
      enablePNG = false;
      enableWebP = false;
      enableEigen = false;
      enableOpenblas = false;
      enableContrib = false;
      enableCuda = false;
    }).overrideAttrs (oldAttrs: {
      version = "4.3.0";
      src = super.fetchFromGitHub {
        owner  = "opencv";
        repo   = "opencv";
        rev    = "4.3.0";
        sha256 = "1r9bq9p1x99g2y8jvj9428sgqvljz75dm5vrfsma7hh5wjhz9775";
      };

      cmakeFlags = oldAttrs.cmakeFlags ++ ["-DBUILD_opencv_imgcodecs=OFF"];
    });


    python3 = super.python3.override {
      packageOverrides = py-self: py-super: {

        opencv_3_3 = py-super.toPythonModule (self.opencv_3_3.override {
          enablePython = true;
          pythonPackages = py-self;
        });

        opencv_3_4 = py-super.opencv3;

        opencv_4_0 = py-super.toPythonModule (self.opencv_4_0.override {
          enablePython = true;
          pythonPackages = py-self;
        });

        opencv_4_1 = py-super.opencv4;

        opencv_4_2 = py-super.toPythonModule (self.opencv_4_2.override {
          enablePython = true;
          pythonPackages = py-self;
        });

        opencv_4_3 = py-super.toPythonModule (self.opencv_4_3.override {
          enablePython = true;
          pythonPackages = py-self;
        });

      };
    };

    my-python-env = self.python3.withPackages
      (ps: with ps; [
        numpy
        pytest
        (if opencv-version == "3.3" then opencv_3_3
         else if opencv-version == "3.4" then opencv_3_4
         else if opencv-version == "4.0" then opencv_4_0
         else if opencv-version == "4.1" then opencv_4_1
         else if opencv-version == "4.2" then opencv_4_2
         else if opencv-version == "4.3" then opencv_4_3
         else abort "opencv-version should be one of [3.3, 3.4, 4.0, 4.1, 4.2, 4.3]")
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
