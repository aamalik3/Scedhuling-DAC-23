/*
 * scheduler.h
 *
 *  Created on: Sep 9, 2022
 *      Author: ekarabu
 */

#ifndef SRC_SCHEDULER_H_
#define SRC_SCHEDULER_H_

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "PR_executer.h"
#include "aes_profiling.h"
#include "fft_profiling.h"
#include "bfs_my_module.h"
#include "gemm_profiling.h"
#include "kmp_profiling.h"
#include "sha_profiling.h"
#include "sort_profiling.h"
#include "spmv_profiling.h"
#include "common.h"


void scheduling();
int find_highest_priority (workload row[], int length, int *IP_order);
int find_least_priority (workload row[], int length, int *IP_order);
int find_next_priority (workload  row[], int length, int least_IP, int least_priority, int current_order, int current_priorty, int *IP_order, int *IP_priority);


#endif /* SRC_SCHEDULER_H_ */
