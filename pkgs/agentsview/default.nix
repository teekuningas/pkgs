{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nodejs,
  npmHooks,
  fetchNpmDeps,
  stdenv,
}:

let
  version = "0.32.1";

  src = fetchFromGitHub {
    owner = "kenn-io";
    repo = "agentsview";
    rev = "v${version}";
    hash = "sha256-oAHD+tleolY11RF9Mu5Fxk6iQhxhg2Cf0itaS5SOaNA=";
  };

  frontend = stdenv.mkDerivation {
    pname = "agentsview-frontend";
    inherit version src;

    sourceRoot = "${src.name}/frontend";

    nativeBuildInputs = [
      nodejs
      npmHooks.npmConfigHook
    ];

    npmDeps = fetchNpmDeps {
      src = "${src}/frontend";
      hash = "sha256-UOrVp2DXhqaS/4FdnIiIKTznHEQCt5MBppkg0bLxoao=";
    };

    buildPhase = ''
      runHook preBuild
      npm run build
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      cp -r dist $out
      runHook postInstall
    '';
  };

in
buildGoModule {
  pname = "agentsview";
  inherit version src;

  vendorHash = "sha256-7TxFM/OAso0GT1WlfF7loC8/q2CwhpKTshlTzIGbz+g=";

  tags = [ "fts5" ];

  env.CGO_ENABLED = "1";

  preBuild = ''
    rm -rf internal/web/dist
    cp -r ${frontend} internal/web/dist
  '';

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
    "-X main.commit=nixpkg"
    "-X main.buildDate=1970-01-01T00:00:00Z"
  ];

  subPackages = [ "cmd/agentsview" ];

  meta = {
    description = "Browse, search, and track costs across all your AI coding agents";
    homepage = "https://agentsview.io";
    license = lib.licenses.mit;
    mainProgram = "agentsview";
  };
}
