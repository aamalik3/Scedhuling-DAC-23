/*
 * latency_counter.h
 *
 *  Created on: Sep 4, 2022
 *      Author: ekarabu
 */

#ifndef SRC_LATENCY_COUNTER_H_
#define SRC_LATENCY_COUNTER_H_

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

#define prof_base_addr XPAR_PROFILER_0_S00_AXI_BASEADDR

uint32_t initialCounter;
uint32_t totalCount;

void set_counter(u32 start_address, u32 end_address);
void read_counter();
void latency_return(workload* app_load);

#endif /* SRC_LATENCY_COUNTER_H_ */
