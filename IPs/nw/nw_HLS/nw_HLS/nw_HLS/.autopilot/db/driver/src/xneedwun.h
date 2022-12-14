// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XNEEDWUN_H
#define XNEEDWUN_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xneedwun_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u32 Bus_a_BaseAddress;
} XNeedwun_Config;
#endif

typedef struct {
    u64 Bus_a_BaseAddress;
    u32 IsReady;
} XNeedwun;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XNeedwun_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XNeedwun_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XNeedwun_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XNeedwun_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XNeedwun_Initialize(XNeedwun *InstancePtr, u16 DeviceId);
XNeedwun_Config* XNeedwun_LookupConfig(u16 DeviceId);
int XNeedwun_CfgInitialize(XNeedwun *InstancePtr, XNeedwun_Config *ConfigPtr);
#else
int XNeedwun_Initialize(XNeedwun *InstancePtr, const char* InstanceName);
int XNeedwun_Release(XNeedwun *InstancePtr);
#endif

void XNeedwun_Start(XNeedwun *InstancePtr);
u32 XNeedwun_IsDone(XNeedwun *InstancePtr);
u32 XNeedwun_IsIdle(XNeedwun *InstancePtr);
u32 XNeedwun_IsReady(XNeedwun *InstancePtr);
void XNeedwun_EnableAutoRestart(XNeedwun *InstancePtr);
void XNeedwun_DisableAutoRestart(XNeedwun *InstancePtr);

u32 XNeedwun_Get_SEQA_BaseAddress(XNeedwun *InstancePtr);
u32 XNeedwun_Get_SEQA_HighAddress(XNeedwun *InstancePtr);
u32 XNeedwun_Get_SEQA_TotalBytes(XNeedwun *InstancePtr);
u32 XNeedwun_Get_SEQA_BitWidth(XNeedwun *InstancePtr);
u32 XNeedwun_Get_SEQA_Depth(XNeedwun *InstancePtr);
u32 XNeedwun_Write_SEQA_Words(XNeedwun *InstancePtr, int offset, word_type *data, int length);
u32 XNeedwun_Read_SEQA_Words(XNeedwun *InstancePtr, int offset, word_type *data, int length);
u32 XNeedwun_Write_SEQA_Bytes(XNeedwun *InstancePtr, int offset, char *data, int length);
u32 XNeedwun_Read_SEQA_Bytes(XNeedwun *InstancePtr, int offset, char *data, int length);
u32 XNeedwun_Get_SEQB_BaseAddress(XNeedwun *InstancePtr);
u32 XNeedwun_Get_SEQB_HighAddress(XNeedwun *InstancePtr);
u32 XNeedwun_Get_SEQB_TotalBytes(XNeedwun *InstancePtr);
u32 XNeedwun_Get_SEQB_BitWidth(XNeedwun *InstancePtr);
u32 XNeedwun_Get_SEQB_Depth(XNeedwun *InstancePtr);
u32 XNeedwun_Write_SEQB_Words(XNeedwun *InstancePtr, int offset, word_type *data, int length);
u32 XNeedwun_Read_SEQB_Words(XNeedwun *InstancePtr, int offset, word_type *data, int length);
u32 XNeedwun_Write_SEQB_Bytes(XNeedwun *InstancePtr, int offset, char *data, int length);
u32 XNeedwun_Read_SEQB_Bytes(XNeedwun *InstancePtr, int offset, char *data, int length);
u32 XNeedwun_Get_alignedA_BaseAddress(XNeedwun *InstancePtr);
u32 XNeedwun_Get_alignedA_HighAddress(XNeedwun *InstancePtr);
u32 XNeedwun_Get_alignedA_TotalBytes(XNeedwun *InstancePtr);
u32 XNeedwun_Get_alignedA_BitWidth(XNeedwun *InstancePtr);
u32 XNeedwun_Get_alignedA_Depth(XNeedwun *InstancePtr);
u32 XNeedwun_Write_alignedA_Words(XNeedwun *InstancePtr, int offset, word_type *data, int length);
u32 XNeedwun_Read_alignedA_Words(XNeedwun *InstancePtr, int offset, word_type *data, int length);
u32 XNeedwun_Write_alignedA_Bytes(XNeedwun *InstancePtr, int offset, char *data, int length);
u32 XNeedwun_Read_alignedA_Bytes(XNeedwun *InstancePtr, int offset, char *data, int length);
u32 XNeedwun_Get_alignedB_BaseAddress(XNeedwun *InstancePtr);
u32 XNeedwun_Get_alignedB_HighAddress(XNeedwun *InstancePtr);
u32 XNeedwun_Get_alignedB_TotalBytes(XNeedwun *InstancePtr);
u32 XNeedwun_Get_alignedB_BitWidth(XNeedwun *InstancePtr);
u32 XNeedwun_Get_alignedB_Depth(XNeedwun *InstancePtr);
u32 XNeedwun_Write_alignedB_Words(XNeedwun *InstancePtr, int offset, word_type *data, int length);
u32 XNeedwun_Read_alignedB_Words(XNeedwun *InstancePtr, int offset, word_type *data, int length);
u32 XNeedwun_Write_alignedB_Bytes(XNeedwun *InstancePtr, int offset, char *data, int length);
u32 XNeedwun_Read_alignedB_Bytes(XNeedwun *InstancePtr, int offset, char *data, int length);
u32 XNeedwun_Get_ptr_BaseAddress(XNeedwun *InstancePtr);
u32 XNeedwun_Get_ptr_HighAddress(XNeedwun *InstancePtr);
u32 XNeedwun_Get_ptr_TotalBytes(XNeedwun *InstancePtr);
u32 XNeedwun_Get_ptr_BitWidth(XNeedwun *InstancePtr);
u32 XNeedwun_Get_ptr_Depth(XNeedwun *InstancePtr);
u32 XNeedwun_Write_ptr_Words(XNeedwun *InstancePtr, int offset, word_type *data, int length);
u32 XNeedwun_Read_ptr_Words(XNeedwun *InstancePtr, int offset, word_type *data, int length);
u32 XNeedwun_Write_ptr_Bytes(XNeedwun *InstancePtr, int offset, char *data, int length);
u32 XNeedwun_Read_ptr_Bytes(XNeedwun *InstancePtr, int offset, char *data, int length);
u32 XNeedwun_Get_M_BaseAddress(XNeedwun *InstancePtr);
u32 XNeedwun_Get_M_HighAddress(XNeedwun *InstancePtr);
u32 XNeedwun_Get_M_TotalBytes(XNeedwun *InstancePtr);
u32 XNeedwun_Get_M_BitWidth(XNeedwun *InstancePtr);
u32 XNeedwun_Get_M_Depth(XNeedwun *InstancePtr);
u32 XNeedwun_Write_M_Words(XNeedwun *InstancePtr, int offset, word_type *data, int length);
u32 XNeedwun_Read_M_Words(XNeedwun *InstancePtr, int offset, word_type *data, int length);
u32 XNeedwun_Write_M_Bytes(XNeedwun *InstancePtr, int offset, char *data, int length);
u32 XNeedwun_Read_M_Bytes(XNeedwun *InstancePtr, int offset, char *data, int length);

void XNeedwun_InterruptGlobalEnable(XNeedwun *InstancePtr);
void XNeedwun_InterruptGlobalDisable(XNeedwun *InstancePtr);
void XNeedwun_InterruptEnable(XNeedwun *InstancePtr, u32 Mask);
void XNeedwun_InterruptDisable(XNeedwun *InstancePtr, u32 Mask);
void XNeedwun_InterruptClear(XNeedwun *InstancePtr, u32 Mask);
u32 XNeedwun_InterruptGetEnabled(XNeedwun *InstancePtr);
u32 XNeedwun_InterruptGetStatus(XNeedwun *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
