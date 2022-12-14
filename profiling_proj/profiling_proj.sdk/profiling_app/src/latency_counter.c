/*
 * latency_counter.c
 *
 *  Created on: Sep 4, 2022
 *      Author: ekarabu
 */

#include "latency_counter.h"


void set_counter(u32 start_address, u32 end_address)
{
	Xil_Out32 (prof_base_addr, start_address );
	//xil_printf("start_addr: %x\n",Xil_In32 (prof_base_addr));
	Xil_Out32 (prof_base_addr+4, end_address );
	//xil_printf("end_addr: %x\n",Xil_In32 (prof_base_addr+4));
	Xil_Out32 (prof_base_addr+12, 0x1 );
	//xil_printf("restart_addr: %u\n",Xil_In32 (prof_base_addr+12));
	Xil_Out32 (prof_base_addr+12, 0x0 );
	//xil_printf("restart_addr: %u\n",Xil_In32 (prof_base_addr+12));

	initialCounter = Xil_In32 (prof_base_addr+8);
	xil_printf("Initial Counter: %u\n",initialCounter);

}

void read_counter()
{
	uint32_t counter = Xil_In32 (prof_base_addr+8);
	totalCount = counter - initialCounter;
}

void latency_return(workload* app_load)
{
	app_load->latency = totalCount;
}

