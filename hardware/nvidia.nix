{ config, ... }: {
	hardware.graphics.enable = true;
	
	hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
	hardware.nvidia.modesetting.enable = true;
	hardware.nvidia.open = true;
	hardware.nvidia.powerManagement.enable = true;
	hardware.nvidia.powerManagement.finegrained = false;
	
	services.xserver.videoDrivers = ["nvidia"];
}
