/*
 * kmp_profiling.c
 *
 *  Created on: Sep 8, 2022
 *      Author: aamalik3
 */


#include "kmp_profiling.h"
#include "PR_executer.h"
#include "latency_counter.h"


void kmp_operation()
{
    xil_printf("\n");
	//PR_execution("kmp.bin");
	xil_printf("Back in KMP: ");
	set_counter((KMP_pattern ), ((KMP_matches+0x30)));
	uint32_t	i;

    /* put a test vector in starting nodes */
    for (i = 0; i < 1;i++){
    	Xil_Out32 (KMP_pattern + i*4,0xDEADBEEF);
    }

    /* put a test vector in nodes */
    for (i = 0; i < 4; i++){
    	Xil_Out32 (KMP_Next + i*4, 0xDEADBEEF );
    }

    /* put a test vector in nodes */
    for (i = 0; i < 1012; i++){
    	Xil_Out32 (KMP_input_r + i*4, 0xDEADBEEF );
    }
    //xil_printf("Start signal is sent:\n");
    Xil_Out32 (KMP_CRTL, 0x00000001 );

    int cnt =0;
    while ( !((Xil_In32 (KMP_CRTL)) & 0x2) && cnt< 10000)
    	cnt++;

    uint32_t tmp;
    for (i = 0; i < 1; i++){
    	tmp = Xil_In32 (KMP_matches+i*4);
    	//xil_printf("0x%x\n",tmp[i]);
    }
    for (i = 0; i < 1; i++){
    	tmp = Xil_In32 (KMP_CTRL_match+i*4);
    	//xil_printf("0x%x\n",tmp[i]);
    }
    xil_printf("KMP: ");
    read_counter();
    xil_printf("KMP: %u",tmp);

}
