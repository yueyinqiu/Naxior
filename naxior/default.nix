{
  flake-inputs,
  ...
}:
{
  imports = [
    flake-inputs.disko.nixosModules.disko
    ./disko
    ./hardware
    ./tools
    ./users
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # 桌面工作站不需要 zram 以外的持久化 swap（ML 工作负载如需要可在 disko 里补 swap 分区）
  zramSwap.enable = true;

  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "naxior";
  networking.networkmanager.enable = true;

  # 用于远程部署与日常 SSH 登录
  services.openssh.enable = true;

  # 与笔记本一致的基础安全加固
  security.protectKernelImage = true;
  security.audit.enable = true;
  security.auditd.enable = true;
  security.audit.backlogLimit = 8192;
  security.audit.rules = map (path: "-w ${path} -p wa -k system") [
    "/etc/passwd"
    "/etc/shadow"
    "/etc/group"
    "/etc/sudoers"
    "/etc/pam.d"
    "/etc/ssh"
    "/etc/modprobe.d"
    "/etc/modules-load.d"
    "/etc/udev"
    "/etc/sysctl.d"
    "/etc/tmpfiles.d"
    "/etc/polkit-1"
    "/etc/binfmt.d"
    "/root"
  ];

  system.stateVersion = "26.05";
}