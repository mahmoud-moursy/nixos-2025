{ ... }: {
	disko.devices = {
		disk = {
			nvme0n1 = {
				type = "disk";
				device = "/dev/nvme0n1";
				content = {
					type = "gpt";
					partitions = {
						ESP = {
							size="1024M";
							type="EF00";
							name="BOOT";
							content = {
								type="filesystem";
								format="vfat";
								mountpoint="/boot";
								mountOptions = [ "umask=0077" ];
							};
						};
						zfs = {
							size="100%";
							type="BF00";
							name="ROOT";
							content = {
								type = "zfs";
								pool = "zroot";
							};
						};
					};
				};
			};
		};
		zpool = {
				zroot = {
					type="zpool";
					rootFsOptions = {
						acltype="posixacl";
						atime="off";
						# May paradoxically improve read speeds because I/O is usually the bottleneck
						compression="zstd";
						mountpoint="none";
						xattr="sa";
					};
					options.ashift = "12";
					options = {
						"feature@zstd_compress" = "enabled";
						"feature@fast_dedup" = "enabled";
						"feature@blake3" = "enabled";
					};
					
					datasets = {
						"local" = {
							type = "zfs_fs";
							options.mountpoint = "none";
						};
						"local/root" = {
							type = "zfs_fs";
							mountpoint = "/";
							options."com.sun:auto-snapshot" = "false";
							postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot/local/root@blank$' || zfs snapshot zroot/local/root@blank";
							options.checksum = "blake3";
						};
						"local/persist" = {
							type = "zfs_fs";
							mountpoint = "/persist";
							options."com.sun:auto-snapshot" = "false";
							options.checksum = "blake3";
						};
						"local/nix" = {
							type = "zfs_fs";
							mountpoint = "/nix";
							options."com.sun:auto-snapshot" = "false";
							options.dedup = "on";
							options.compression = "zstd-9";
							options.recordsize = "1M";
							options.checksum = "blake3";
							options.atime = "off";
							options.logbias = "throughput";
						};
						"local/home" = {
							type = "zfs_fs";
							mountpoint = "/home";
							options."com.sun:auto-snapshot" = "true";
							options.checksum = "blake3";
						};
					};
				};
			};
	};
}
