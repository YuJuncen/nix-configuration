.PRONE fmt structure

fmt:
nix fmt

structure:
sudo --preserve-env=HTTP_PROXY,HTTPS_PROXY nixos-rebuild switch --flake ".#structure"