#
# Product-specific compile-time definitions.
#

include device/fsl/imx5x/BoardConfigCommon.mk

TARGET_BOOTLOADER_BOARD_NAME := TURING

BOARD_SOC_CLASS := IMX5X
BOARD_SOC_TYPE := IMX53

TARGET_BUILD_KERNEL := false

WIFI_DRIVER_MODULE_NAME     := "ar6000"
WPA_SUPPLICANT_VERSION      := VER_0_6_ATHEROS
BOARD_WLAN_ATHEROS_SDK      := system/wlan/atheros/AR6kSDK
BOARD_WPA_SUPPLICANT_DRIVER := AR6000
BOARD_WLAN_CHIP_AR6102	    := true
BOARD_WLAN_CHIP_AR6003	    := true
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
# Select Wake on wireless mode for AR6003 suspend/resume policy
BOARD_WLAN_PM_SUSPEND       := 2

BOARD_HAVE_VPU := true
HAVE_FSL_IMX_GPU := true
HAVE_FSL_IMX_IPU := true

# Support both PMICs without building a different image
# Dialog 9053 pmic
TARGET_TS_DEVICE := "da9052_tsi"
# Ripley (MC34708) pmic
TARGET_TS_DEVICE_ALT := "mxc_ts"


#for accelerator sensor, need to define sensor type here
BOARD_HAS_SENSOR := true
SENSOR_MMA8450 := true

# for recovery service
TARGET_SELECT_KEY := 28
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 167772160
# Used to create the system partition (even if we are not using flash)
BOARD_FLASH_BLOCK_SIZE := 262144
