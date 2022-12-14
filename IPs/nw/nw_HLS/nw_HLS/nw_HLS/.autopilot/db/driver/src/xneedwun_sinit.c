// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xneedwun.h"

extern XNeedwun_Config XNeedwun_ConfigTable[];

XNeedwun_Config *XNeedwun_LookupConfig(u16 DeviceId) {
	XNeedwun_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XNEEDWUN_NUM_INSTANCES; Index++) {
		if (XNeedwun_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XNeedwun_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XNeedwun_Initialize(XNeedwun *InstancePtr, u16 DeviceId) {
	XNeedwun_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XNeedwun_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XNeedwun_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

