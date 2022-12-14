/*
 * bfs_my_module.c
 *
 *  Created on: Sep 7, 2022
 *      Author: ekarabu
 */

#include "bfs_my_module.h"
#include "PR_executer.h"
#include "latency_counter.h"


void bfs_operation()
{
	xil_printf("\n");
	//PR_execution("bfs.bin");
//	PCAP_init (PL_BITSTREAM_A);
	xil_printf("Back in BFS: ");
	set_counter((BFS_starting_node ), ((BFS_level+0x01fC)));
	uint32_t	i;

    /* put a test vector in starting nodes */
    for (i = 0; i < 2;i++){
    	Xil_Out32 (BFS_starting_node + i*4,0xDEADBEEF);
    }

    /* put a test vector in nodes */
    for (i = 0; i < 2048; i++){
    	Xil_Out32 (BFS_nodes + i*4, 0xDEADBEEF );
    }

    /* put a test vector in edges */
    for (i = 0; i < 16384; i++){
    	Xil_Out32 (BFS_edges + i*4, 0xDEADBEEF);
    }

    /* put a test vector in level_counts */
    for (i = 0; i < 64; i++){
    	Xil_Out32 (BFS_level_counts + i*4, 0xDEADBEEF);
    }
    //xil_printf("Start signal is sent:\n");
    Xil_Out32 (BFS_CRTL, 0x00000001 );

    int cnt =0;
    while ( !((Xil_In32 (BFS_CRTL)) & 0x2) && cnt< 10000)
    	cnt++;

    uint32_t tmp[128];
    for (i = 0; i < 128; i++){
    	tmp[i] = Xil_In32 (BFS_level+i*4);
    	//xil_printf("0x%x\n",tmp[i]);
    }
    xil_printf("BFS: ");
    read_counter();
    xil_printf("BFS: %u",tmp[63]);
}


