{
  name,
  pkgs,
  ...
}:
pkgs.writeShellApplication {
  name = name;
  text = ''
    run0 nixos-rebuild switch --flake .
  '';
}