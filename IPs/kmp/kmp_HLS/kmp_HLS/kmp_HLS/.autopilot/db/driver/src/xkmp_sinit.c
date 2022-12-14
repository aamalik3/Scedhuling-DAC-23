// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xkmp.h"

extern XKmp_Config XKmp_ConfigTable[];

XKmp_Config *XKmp_LookupConfig(u16 DeviceId) {
	XKmp_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XKMP_NUM_INSTANCES; Index++) {
		if (XKmp_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XKmp_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XKmp_Initialize(XKmp *InstancePtr, u16 DeviceId) {
	XKmp_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XKmp_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XKmp_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

