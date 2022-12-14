// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xspmv.h"

extern XSpmv_Config XSpmv_ConfigTable[];

XSpmv_Config *XSpmv_LookupConfig(u16 DeviceId) {
	XSpmv_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XSPMV_NUM_INSTANCES; Index++) {
		if (XSpmv_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XSpmv_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XSpmv_Initialize(XSpmv *InstancePtr, u16 DeviceId) {
	XSpmv_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XSpmv_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XSpmv_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

