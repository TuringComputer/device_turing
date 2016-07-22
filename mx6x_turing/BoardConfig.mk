#
# Product-specific compile-time definitions.
#

include device/turing/imx6/soc/imx6dq.mk
include device/turing/mx6x_turing/build_id.mk
include device/turing/imx6/BoardConfigCommon.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk
# mx6x_turing default target for EXT4
BUILD_TARGET_FS ?= ext4
include device/turing/imx6/imx6_target_fs.mk

ifeq ($(BUILD_TARGET_DEVICE),sd)
	ADDITIONAL_BUILD_PROPERTIES += ro.boot.storage_type=sd
ifneq ($(BUILD_TARGET_FS),f2fs)
	TARGET_RECOVERY_FSTAB = device/turing/mx6x_turing/fstab_sd.turing
	# build for ext4
	PRODUCT_COPY_FILES += device/turing/mx6x_turing/fstab_sd.turing:root/fstab.turing
else
	TARGET_RECOVERY_FSTAB = device/turing/mx6x_turing/fstab_sd-f2fs.turing
	# build for f2fs
	PRODUCT_COPY_FILES += device/turing/mx6x_turing/fstab_sd-f2fs.turing:root/fstab.turing
endif # BUILD_TARGET_FS
else
	ADDITIONAL_BUILD_PROPERTIES += ro.boot.storage_type=emmc
ifneq ($(BUILD_TARGET_FS),f2fs)
	TARGET_RECOVERY_FSTAB = device/turing/mx6x_turing/fstab.turing
	# build for ext4
	PRODUCT_COPY_FILES += device/turing/mx6x_turing/fstab.turing:root/fstab.turing
else
	TARGET_RECOVERY_FSTAB = device/turing/mx6x_turing/fstab-f2fs.turing
	# build for f2fs
	PRODUCT_COPY_FILES += device/turing/mx6x_turing/fstab-f2fs.freescale:root/fstab.turing
endif # BUILD_TARGET_FS
endif # BUILD_TARGET_DEVICE


TARGET_BOOTLOADER_BOARD_NAME := MX6TURING
PRODUCT_MODEL := TURING-MX6x

TARGET_RELEASETOOLS_EXTENSIONS := device/turing/imx6


# Sensors HAL based on STMemsAndroidHAL
BOARD_ENABLED_SENSORS            := LSM9DS1
BOARD_ENABLED_SENSORS_MODULES    := SENSOR_FUSION

# GPS
USE_QEMU_GPS_HARDWARE            := false
BOARD_HAVE_TURING_GPS			 := true

# Audio
BOARD_USES_ALSA_AUDIO 			 := true
BUILD_WITH_ALSA_UTILS 			 := true

# Bluetooth
BOARD_HAVE_BLUETOOTH 			 := true

# Wifi
BOARD_WPA_SUPPLICANT_DRIVER  	 := NL80211
BOARD_WLAN_VENDOR				 := TURING
WPA_SUPPLICANT_VERSION       	 := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_turing
BOARD_WLAN_DEVICE                := TURING
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_turing

# 3G
BOARD_NOT_HAVE_MODEM 			 := true
BOARD_MODEM_VENDOR 				 := 
BOARD_MODEM_ID 					 := 
BOARD_MODEM_HAVE_DATA_DEVICE 	 := true
BOARD_SIERRA_RIL				 := AT

# Cameras
BOARD_HAVE_IMX_CAMERA 			 := true
BOARD_HAVE_USB_CAMERA 			 := false
BOARD_CAMERA_LIBRARIES 			 := libcamera
USE_CAMERA_STUB 				 := false

#for accelerator sensor, need to define sensor type here
BOARD_HAS_SENSOR := true

# for recovery service
TARGET_SELECT_KEY := 28

# we don't support sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
DM_VERITY_RUNTIME_CONFIG := true
# uncomment below lins if use NAND
#TARGET_USERIMAGES_USE_UBIFS = true

TARGET_KERNEL_MODULES :=																				\
	kernel_imx/crypto/tcrypt.ko:system/lib/modules/tcrypt.ko											\
	kernel_imx/drivers/net/wireless/atmel/wilc3000/at_pwr_dev.ko:system/lib/modules/at_pwr_dev.ko		\
	kernel_imx/drivers/net/wireless/atmel/wilc3000/wilc3000.ko:system/lib/modules/wilc3000.ko			\
	kernel_imx/drivers/net/wireless/iwlwifi/iwlwifi.ko:system/lib/modules/iwlwifi.ko 					\
	kernel_imx/drivers/net/wireless/iwlwifi/mvm/iwlmvm.ko:system/lib/modules/iwlmvm.ko 					\
	kernel_imx/drivers/net/wireless/iwlwifi/dvm/iwldvm.ko:system/lib/modules/iwldvm.ko 					\
	kernel_imx/net/mac80211/mac80211.ko:system/lib/modules/mac80211.ko 									\
	kernel_imx/net/wireless/cfg80211.ko:system/lib/modules/cfg80211.ko 									\

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
UBI_ROOT_INI := device/turing/mx6x_turing/ubi/ubinize.ini
TARGET_MKUBIFS_ARGS := -m 4096 -e 516096 -c 4096 -x none
TARGET_UBIRAW_ARGS := -m 4096 -p 512KiB $(UBI_ROOT_INI)
endif

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
ifeq ($(TARGET_USERIMAGES_USE_EXT4),true)
$(error "TARGET_USERIMAGES_USE_UBIFS and TARGET_USERIMAGES_USE_EXT4 config open in same time, please only choose one target file system image")
endif
endif

BOARD_KERNEL_CMDLINE := console=ttymxc4,115200 init=/init video=mxcfb0:dev=ldb,bpp=32 video=mxcfb1:dev=lcd,bpp=32 video=mxcfb2:off video=mxcfb3:off vmalloc=256M androidboot.console=ttymxc4 consoleblank=0 androidboot.hardware=turing cma=384M androidboot.selinux=disabled androidboot.dm_verity=disabled no_console_suspend

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
#UBI boot command line.
# Note: this NAND partition table must align with MFGTool's config.
BOARD_KERNEL_CMDLINE +=  mtdparts=gpmi-nand:16m(bootloader),16m(bootimg),128m(recovery),-(root) gpmi_debug_init ubi.mtd=3
endif

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# camera hal v2
IMX_CAMERA_HAL_V2 := true

#define consumer IR HAL support
IMX6_CONSUMER_IR_HAL := true

TARGET_BOOTLOADER_USE_SPL := true
ifeq ($(TURING_SMART_VARIANT),true)
TARGET_BOOTLOADER_CONFIG  := imx6q:mx6turing_smart_android_defconfig
TARGET_BOARD_DTS_CONFIG   := imx6q:imx6q-turing-eval.dtb
else
TARGET_BOOTLOADER_CONFIG  := imx6q:mx6turing_android_defconfig imx6dl:mx6turing_android_defconfig
TARGET_BOARD_DTS_CONFIG   := imx6q:imx6q-turing-eval.dtb imx6dl:imx6dl-turing-eval.dtb
endif

BOARD_SEPOLICY_DIRS := 						\
       device/turing/imx6/sepolicy 			\
       device/turing/mx6x_turing/sepolicy

BOARD_SEPOLICY_UNION := 	\
       domain.te 			\
       system_app.te 		\
       system_server.te 	\
       untrusted_app.te 	\
       sensors.te 			\
       init_shell.te 		\
       bluetooth.te 		\
       kernel.te 			\
       mediaserver.te 		\
       file_contexts 		\
       genfs_contexts 		\
       fs_use  				\
       rild.te 				\
       init.te 				\
       netd.te 				\
       bootanim.te 			\
       dnsmasq.te 			\
       recovery.te 			\
       device.te 			\
       zygote.te


