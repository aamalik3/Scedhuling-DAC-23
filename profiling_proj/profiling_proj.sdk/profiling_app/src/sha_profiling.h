/*
 * sha_profiling.h
 *
 *  Created on: Sep 8, 2022
 *      Author: aamalik3
 */

#ifndef SRC_SHA_PROFILING_H_
#define SRC_SHA_PROFILING_H_

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xil_exception.h"
#include "sleep.h"
#include <time.h>
#include "xtime_l.h"
#include <stdlib.h>
#include "common.h"

#define SHA_CRTL			XPAR_IP_WRAPPER_0_S00_AXI_BASEADDR + 0x000C
#define SHA_RDY				XPAR_IP_WRAPPER_0_S00_AXI_BASEADDR + 0x0008
#define SHA_Slave_IN		XPAR_IP_WRAPPER_0_S00_AXI_BASEADDR + 0x0010
#define SHA_Slave_OUT		XPAR_IP_WRAPPER_0_S00_AXI_BASEADDR + 0x0020

u32 * shaPrBuffer;

void sha_operation_profile(workload* app_load);

#endif /* SRC_SHA_PROFILING_H_ */
