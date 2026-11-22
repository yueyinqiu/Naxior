{
  ...
}:
{
  # NVIDIA 驱动是 unfree 的
  nixpkgs.config.allowUnfree = true;

  # NVIDIA RTX 3080（Ampere）
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    # Ampere 起推荐 open kernel modules；如遇 CUDA 兼容问题可改回 false
    open = true;
    nvidiaSettings = true;
  };
}