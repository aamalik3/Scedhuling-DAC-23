/*
 * common.h
 *
 *  Created on: Sep 9, 2022
 *      Author: ekarabu
 */

#ifndef SRC_COMMON_H_
#define SRC_COMMON_H_

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include <stdlib.h>
#include "xtime_l.h"
#include <stdbool.h>

#define TIME_FRAME 6
#define NUM_Of_IPs 8
#define NUM_Of_SLOTs 3
#define QUANTUM 3
#define RANDOMNESS 0


typedef struct WorkLoad {
	char name [20];
	uint8_t demandedResource; // 1 to 3
	uint32_t latency;
	uint32_t executed;
	int priority;
	float successRate;
} workload;

typedef struct FPGA_Slots {
	char name [20];
	uint8_t Resource; // 1 to 4
	int priority;
	int priority_reduction;
	bool empty;
	uint32_t latency;
	bool PR_needed;
	uint32_t interval;
	int IP_order;
} slot;


uint8_t totalSlot;
uint32_t interval;
uint8_t remainingSlot;




#endif /* SRC_COMMON_H_ */
