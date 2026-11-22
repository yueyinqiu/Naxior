# NixosNaxior

`naxior`（实验室工作站 `lab-g3080`）的 NixOS 配置。

定位接近 `erthane`（日常使用的笔记本），而非 `orivel`（常驻服务的服务器）：
不部署任何 gateway 类服务；但保留 `disko`、`sshd` 以便远程部署和维护。

## 磁盘布局（整机重建，两盘都会被清空）

- **`nvme0n1`（Samsung 970 EVO 1TB NVMe）**：系统盘，disko 重写为 `ESP(512M) + root(余下)`。
- **`sda`（HGST 4TB 机械盘）**：整盘作为数据盘，挂载到 `/data`。

> 两块盘的 by-id 已写死在 `naxior/disko/default.nix`，装机前请再确认一次 `ls -la /dev/disk/by-id`。

## 装机（disko）

用任意 NixOS 安装介质启动后：

```sh
# 1. 进入 flake（用 direnv 或直接）
nix develop

# 2. 分区并格式化（会清空目标盘，务必确认 device 指对了）
nix --extra-experimental-features 'nix-command flakes' run \
  github:nix-community/disko -- --mode disko ./naxior/disko/default.nix

# 3. 把分区挂载起来（disko 会生成挂载，也可用 disko --mode mount）

# 4. 装机
nixos-install --flake .#naxior
```

## 日常部署（远程）

本机 `~/.ssh/config` 加一个 `naxior` host 指向该工作站后，在 devShell 里：

```sh
dev-switch-remote
```

它实际执行：

```sh
nixos-rebuild build --flake .#naxior
nixos-rebuild switch --flake . --target-host naxior
```

## 需要手工确认的点

- **CPU 微码**：`naxior/hardware/hardware-configuration.nix` 目前按 Intel 写（`kvm-intel` + `intel.updateMicrocode`）。如是 AMD 机器，改成 `kvm-amd` + `hardware.cpu.amd.updateMicrocode`。
- **NVIDIA open modules**：`naxior/hardware/gpu.nix` 里 `hardware.nvidia.open = true`，Ampere（RTX 3080）推荐；如遇 CUDA 兼容问题改回 `false`。