#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/caprip

INSTALLED_KERNEL_TARGET := $(PRODUCT_OUT)/kernel
recovery_uncompressed_ramdisk := $(PRODUCT_OUT)/ramdisk-recovery.cpio

RECOVERY_KMOD_TARGETS := \
    exfat.ko \
    mmi_sys_temp.ko \
    utags.ko \
    mmi_info.ko \
    mmi_annotate.ko \
    watchdogtest.ko \
    tzlog_dump.ko \
    watchdog_cpu_ctx.ko \
    nova_0flash_mmi.ko \
    ili9882_mmi.ko \
    fpsensor_spi_tee.ko \
    fpc1020_mmi.ko \
    moto_f_usbnet.ko \
    qpnp_adaptive_charge.ko \
    qpnp-power-on-mmi.ko \
    sensors_class.ko \
    sx933x_sar.ko

INSTALLED_RECOVERY_KMOD_TARGETS := $(RECOVERY_KMOD_TARGETS:%=$(TARGET_RECOVERY_ROOT_OUT)/vendor/lib/modules/%)
$(INSTALLED_RECOVERY_KMOD_TARGETS): $(INSTALLED_KERNEL_TARGET)
	echo -e ${CL_GRN}"Copying kernel modules to recovery"${CL_RST}
	@mkdir -p $(dir $@)
	cp $(@F:%=$(DEVICE_PATH)-kernel/modules/%) $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib/modules/

$(recovery_uncompressed_ramdisk): $(INSTALLED_RECOVERY_KMOD_TARGETS)
