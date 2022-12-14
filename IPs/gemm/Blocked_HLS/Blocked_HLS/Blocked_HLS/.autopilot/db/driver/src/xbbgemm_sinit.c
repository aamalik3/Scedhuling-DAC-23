// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xbbgemm.h"

extern XBbgemm_Config XBbgemm_ConfigTable[];

XBbgemm_Config *XBbgemm_LookupConfig(u16 DeviceId) {
	XBbgemm_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XBBGEMM_NUM_INSTANCES; Index++) {
		if (XBbgemm_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XBbgemm_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XBbgemm_Initialize(XBbgemm *InstancePtr, u16 DeviceId) {
	XBbgemm_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XBbgemm_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XBbgemm_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

