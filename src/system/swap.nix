{
  ...
}:
{
  boot.zswap.enable = true;

  # swapfile 放在 NVMe（root）上，ML 内存打爆时作为硬兜底；size 单位 MiB，可按需调大
  swapDevices = [
    {
      device = "/swapfile";
      size = 16384;
      options = [ "discard" ];
    }
  ];
}