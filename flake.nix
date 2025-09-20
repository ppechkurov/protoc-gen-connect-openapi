{
  description = "protoc-gen-connect-openapi development environment";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  # Flake outputs
  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in with pkgs; {
        # Development environment output
        devShells = {
          default = mkShell {
            # The Nix packages provided in the environment
            packages = [
              go_1_24
              golangci-lint
              golangci-lint-langserver
              gopls
              gotools
              direnv
              watchexec
              gnumake
              gotestdox
              just
            ];
          };
        };

        packages.default = buildGo124Module {
          pname = "protoc-gen-connect-openapi";
          version = self.rev;
          src = ./.;
          vendorHash = "sha256-ubcJP5q70F4mTqx+f8V+lCfjiGHxOvdPVaUwhVLmhb8=";
          ldflags = [ "-s" "-w" ];
        };
      });
}
