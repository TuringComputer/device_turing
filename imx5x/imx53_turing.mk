# This is a FSL Android Reference Design platform based on i.MX51 BBG board
# It will inherit from FSL core product which in turn inherit from Google generic

$(call inherit-product, device/turing/imx5x/imx5x.mk)

# Overrides
PRODUCT_NAME := imx53_turing
PRODUCT_DEVICE := imx53_turing

PRODUCT_COPY_FILES += \
	device/turing/imx53_turing/turing-keyboard.idc:system/usr/idc/turing-keyboard.idc                   \
    device/turing/imx53_turing/turing-keyboard.kl:system/usr/keylayout/turing-keyboard.kl     			\
	device/turing/imx53_turing/required_hardware.xml:system/etc/permissions/required_hardware.xml 		\
	device/turing/imx53_turing/init.rc:root/init.freescale.rc 											\
    device/turing/imx53_turing/vold.fstab:system/etc/vold.fstab
