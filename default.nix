{
  fetchFromGitHub,
  lib,
  linux-pam,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  version = "v0.3.1";

  name = "lemurs";

  src = fetchFromGitHub {
    owner = "coastalwhite";
    repo = name;
    rev = "c64f69ccf81b653d9664c412402f32388d976968";
    sha256 = "sha256-6mNSLEWafw8yDGnemOhEiK8FTrBC+6+PuhlbOXTGmN0=";
  };

  cargoSha256 = "sha256-7Hwimh9WLdmCp16P6MSIL6ArbXKVI+pHFTNj3etqTK0=";

  preConfigure = "cargo update --offline";

  buildInputs = [ linux-pam ];

  meta = with lib; {
    description = "A customizable TUI display/login manager written in Rust";
    homepage = "https://github.com/coastalwhite/lemurs";
    license = licenses.mit;
    # maintainers = with maintainers; [dit7ya];
  };
}
