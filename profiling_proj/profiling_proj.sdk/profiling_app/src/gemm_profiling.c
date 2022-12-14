/*
 * gemm.c
 *
 *  Created on: Sep 8, 2022
 *      Author: aamalik3
 */

#include "gemm_profiling.h"
#include "PR_executer.h"
#include "latency_counter.h"

void gemm_operation()
{
    xil_printf("\n");
	//PR_execution("gemm.bin");
	xil_printf("Back in GEMM: ");
	set_counter((gemm_m1 ), ((gemm_m1+0xfffc)));
	uint32_t	i;

    /* put a test vector in starting nodes */
    for (i = 0; i < 8191;i++){
    	Xil_Out32 (gemm_m1 + i*4,0xDEADBEEF);
    }
    Xil_Out32 (gemm_m1 + (i-1)*4,0xDEADBEEF);

    /* put a test vector in nodes */
    for (i = 0; i < 8191; i++){
    	Xil_Out32 (gemm_m1 + i*4, 0xDEADBEEF );
    }
    Xil_Out32 (gemm_m1 + (i-1)*4,0xDEADBEEF);
    //xil_printf("Start signal is sent:\n");
    Xil_Out32 (gemm_CRTL, 0x00000001 );

    int cnt =0;
    while ( !((Xil_In32 (gemm_CRTL)) & 0x2) && cnt< 10000)
    	cnt++;

    uint32_t tmp;
    for (i = 0; i < 8192; i++){
    	tmp = Xil_In32 (gemm_m1+i*4);
    }
    xil_printf("GEMM: ");
    read_counter();
    xil_printf("GEMM: %u",tmp);

}
