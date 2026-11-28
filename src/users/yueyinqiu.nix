{ config, ... }:
let
  home = config.users.users.yueyinqiu.home;

  dirs = [
    {
      path = ".config";
      mode = "0755";
      watch = false;
    }
    {
      path = ".config/autostart";
      mode = "0755";
      watch = true;
    }
    {
      path = ".config/environment.d";
      mode = "0755";
      watch = true;
    }
    {
      path = ".config/systemd";
      mode = "0755";
      watch = false;
    }
    {
      path = ".config/systemd/user";
      mode = "0755";
      watch = true;
    }

    {
      path = ".local";
      mode = "0755";
      watch = false;
    }
    {
      path = ".local/share";
      mode = "0755";
      watch = false;
    }
    {
      path = ".local/share/dbus-1";
      mode = "0755";
      watch = false;
    }
    {
      path = ".local/share/dbus-1/services";
      mode = "0755";
      watch = true;
    }
    {
      path = ".local/share/applications";
      mode = "0755";
      watch = true;
    }
    {
      path = ".local/share/nix";
      mode = "0755";
      watch = true;
    }
    {
      path = ".local/share/systemd";
      mode = "0755";
      watch = false;
    }
    {
      path = ".local/share/systemd/user";
      mode = "0755";
      watch = true;
    }
  ];

  watched = builtins.filter (d: d.watch) dirs;
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

  systemd.tmpfiles.rules = map (d: "d ${home}/${d.path} ${d.mode} yueyinqiu users -") dirs;
}