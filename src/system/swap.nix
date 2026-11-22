{
  ...
}:
{
  boot.zswap.enable = true;

  swapDevices = [
    {
      device = "/swapfile";
      size = 16384;
      options = [ "discard" ];
    }
  ];
}