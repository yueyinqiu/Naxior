{
  name,
  pkgs,
  ...
}:
pkgs.writeShellApplication {
  name = name;
  text = ''
    # keep a GC root on the build machine
    ${pkgs.nixos-rebuild}/bin/nixos-rebuild build --flake .#naxior
    ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake . --target-host root@naxior
  '';
}