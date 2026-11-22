{ config, ... }:
let
  home = config.users.users.yueyinqiu.home;

  watched = [
    {
      path = ".config/systemd/user";
      mode = "0755";
    }
    {
      path = ".local/share/systemd/user";
      mode = "0755";
    }
    {
      path = ".config/autostart";
      mode = "0755";
    }
    {
      path = ".config/environment.d";
      mode = "0755";
    }
    {
      path = ".local/share/applications";
      mode = "0755";
    }
    {
      path = ".local/share/nix";
      mode = "0755";
    }
    {
      path = ".ssh";
      mode = "0700";
    }
  ];
in
{
  users.users.yueyinqiu = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      # yueyinqiu@erthane
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEp4LM2tDJo8PN+BQcExl+YiaWM/1j4e1vlP+k3iHUDf"
    ];
  };

  security.audit.rules = map (w: "-w ${home}/${w.path} -p wa -k yueyinqiu") watched;

  systemd.tmpfiles.rules = map (w: "d ${home}/${w.path} ${w.mode} yueyinqiu users -") watched;
}