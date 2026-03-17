{
  config,
  pkgs,
  lib,
  ...
}:
{
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.powerManagement.finegrained = false;
  hardware.nvidia-container-toolkit.enable = true;

  boot.kernelParams = [
    "mem_sleep_default=deep"
    "nvidia.NVreg_UsePageAttributeTable=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];
  boot.kernelModules = [
    "nvidia"
    "nvidia_uvm"
    "nvidia_modeset"
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  nix.settings = rec {
    trusted-substituters = [
      "https://cache.nixos-cuda.org"
      "https://cuda-maintainers.cachix.org"
      "https://cache.flox.dev"
    ];
    extra-substituters = trusted-substituters;
    substituters = trusted-substituters;
    extra-trusted-substituters = trusted-substituters;
    trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
    ];
    extra-trusted-public-keys = trusted-public-keys;
  };

  nixpkgs.config.cudaSupport = true;
  nixpkgs.config.cudaForwardCompat = true;

  environment.systemPackages = 
  (with pkgs.cudaPackages_13; [
    cuda_cudart # → provides nvidia-cuda-runtime-cu12 + core cudart libs
    cuda_nvrtc # → nvidia-cuda-nvrtc-cu12
    cuda_cupti # → nvidia-cuda-cupti-cu12
    cudnn # → nvidia-cudnn-cu12
    nccl # → nvidia-nccl-cu12
    libcublas # → nvidia-cublas-cu12 (this is the main one; libcublas is often just an alias or not separate)
    libcufft # → nvidia-cufft-cu12
    libcurand # → nvidia-curand-cu12
    libcusolver # → nvidia-cusolver-cu12
    libcusparse # → nvidia-cusparse-cu12
    cuda_nvtx # → nvidia-nvtx-cu12
    libnvjitlink # → nvidia-nvjitlink-cu12 (important for recent wheels)
    libnvshmem
    libcufile # → nvidia-cufile-cu12 (GPUDirect, optional)
    libcutensor # → often useful for tensor cores / performance
    libcusparse_lt # → nvidia-cusparselt-cu12
  ])
  ++ (with pkgs.cudaPackages_12; [
    cuda_cudart # → provides nvidia-cuda-runtime-cu12 + core cudart libs
    cuda_nvrtc # → nvidia-cuda-nvrtc-cu12
    cuda_cupti # → nvidia-cuda-cupti-cu12
    cudnn # → nvidia-cudnn-cu12
    nccl # → nvidia-nccl-cu12
    libcublas # → nvidia-cublas-cu12 (this is the main one; libcublas is often just an alias or not separate)
    libcufft # → nvidia-cufft-cu12
    libcurand # → nvidia-curand-cu12
    libcusolver # → nvidia-cusolver-cu12
    libcusparse # → nvidia-cusparse-cu12
    cuda_nvtx # → nvidia-nvtx-cu12
    libnvjitlink # → nvidia-nvjitlink-cu12 (important for recent wheels)
    libnvshmem
    libcufile # → nvidia-cufile-cu12 (GPUDirect, optional)
    libcutensor # → often useful for tensor cores / performance
    libcusparse_lt # → nvidia-cusparselt-cu12
  ]);
  environment.variables.CUDA_PATH = "${pkgs.cudaPackages_13.cudatoolkit}";
}
