{
  stdenv
  , fetchgit
  , lib
  , cmake
}:

let
  headerSrc = builtins.readFile ./CMakeLists.txt;

  versionNumbersRegex = ".*project[[:space:]]*\\(.*[[:space:]]VERSION[[:space:]]+([[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+).*\\).*";

  versionNumbers = builtins.head (builtins.match versionNumbersRegex headerSrc);

  devHash_ = builtins.match ".*DEV_HASH: ([[:xdigit:]]+).*" headerSrc;
  devHash = if devHash_ != null then builtins.head devHash_ else null;

  repo = builtins.fetchGit {
    url = https://github.com/renatoGarcia/opencv-swig.git;
    ref = "master";
    rev = devHash;
  };

  version =
    versionNumbers +
    (
      if devHash != null
      then "+dev." + toString repo.revCount
      else "+local_repo"
    );

in stdenv.mkDerivation {
  pname = "opencv-swig";
  inherit version;

  src = ./.;

  nativeBuildInputs = [ cmake ];

  meta = with lib; {
    homepage = "https://github.com/renatoGarcia/opencv-swig";
    description = "A SWIG library for OpenCV types";
    license = licenses.bsd3;
    maintainers = with maintainers; [ renatoGarcia ];
  };
}
