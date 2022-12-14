/*
 * fft_profiling.h
 *
 *  Created on: Sep 4, 2022
 *      Author: ekarabu
 */

#ifndef SRC_FFT_PROFILING_H_
#define SRC_FFT_PROFILING_H_



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
#include "PR_executer.h"

#define FFT_CRTL XPAR_IP_WRAPPER_0_S00_AXI_BASEADDR
#define FFT_REAL_TWD XPAR_IP_WRAPPER_0_S00_AXI_BASEADDR + 0x1000
#define FFT_REAL_R   XPAR_IP_WRAPPER_0_S00_AXI_BASEADDR + 0x2000
#define FFT_REAL_IMG XPAR_IP_WRAPPER_0_S00_AXI_BASEADDR + 0x4000
#define FFT_REAL_RSLT XPAR_IP_WRAPPER_0_S00_AXI_BASEADDR + 0x6000

u32 * fftPrBuffer;

void fft_operation_profile(workload* app_load);

#endif /* SRC_FFT_PROFILING_H_ */
