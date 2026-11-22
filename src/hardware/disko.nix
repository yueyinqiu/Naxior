{
  ...
}:
{
  disko.devices = {
    # 系统盘：Samsung 970 EVO 1TB（NVMe）
    disk.nvme = {
      device = "/dev/disk/by-id/nvme-eui.00253858014303d9";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "fmask=0077"
                "dmask=0077"
              ];
            };
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };

    # 数据盘：HGST 4TB（机械盘），整盘用作 /data
    disk.sda = {
      device = "/dev/disk/by-id/wwn-0x5000cca0bcd0e4fb";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          data = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/data";
            };
          };
        };
      };
    };
  };
}