#{ callPackage, substituteAll, fetchFromGitHub, buildGradle, jdk, gradle }:
#
# TODO: Issues with gradle + protoc
#buildGradle rec {
#  name = "bundletool-${version}";
#  version = "0.13.3";
#
#  envSpec = ./gradle-env.json;
#
#  src = fetchFromGitHub {
#    owner = "google";
#    repo = "bundletool";
#    rev = version;
#    sha256 = "0kzanfq4w49x9ahwf3bc6b1yd59yz0in54cjbjr5v9g66q698qsb";
#  };
#
#  #gradleFlags = [ "assembleRelease" ];
#
#  nativeBuildInputs = [ jdk gradle ];
#
#  installPhase = ''
#    cp app/build/outputs/apk/full/release/app-full-release-unsigned.apk $out
#  '';
#}

# TODO: Make a wrapper script for this?
{ stdenv, makeWrapper, fetchurl, jre8_headless, androidPkgs }:

stdenv.mkDerivation rec {
  pname = "bundletool";
  version = "0.13.3";

  src = fetchurl {
    url = "https://github.com/google/bundletool/releases/download/${version}/bundletool-all-${version}.jar";
    sha256 = "186hi4vxjh3gds0f4xsaawlryzpb2782pd3xlf50a8fcxrjankr5";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;

  installPhase = ''
    makeWrapper ${jre8_headless}/bin/java $out/bin/bundletool \
      --add-flags "-jar ${src}"
  '';
}
