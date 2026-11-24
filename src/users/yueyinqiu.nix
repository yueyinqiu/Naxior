{ config, ... }:
let
  home = config.users.users.yueyinqiu.home;

  watched = [
    {
      path = ".config";
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
      path = ".config/systemd";
      mode = "0755";
    }
    {
      path = ".config/systemd/user";
      mode = "0755";
    }

    {
      path = ".local";
      mode = "0755";
    }
    {
      path = ".local/share";
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
      path = ".local/share/systemd";
      mode = "0755";
    }
    {
      path = ".local/share/systemd/user";
      mode = "0755";
    }
  ];
in
{
  users.users.yueyinqiu = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "nix-daemon-proxy-switchboard"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEp4LM2tDJo8PN+BQcExl+YiaWM/1j4e1vlP+k3iHUDf"
    ];
  };

  security.audit.rules = map (w: "-w ${home}/${w.path} -p wa -k yueyinqiu") watched;

  systemd.tmpfiles.rules = map (w: "d ${home}/${w.path} ${w.mode} yueyinqiu users -") watched;
}