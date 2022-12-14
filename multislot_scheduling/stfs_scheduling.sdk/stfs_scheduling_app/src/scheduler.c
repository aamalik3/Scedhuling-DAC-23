/*
 * scheduler.c
 *
 *  Created on: Sep 9, 2022
 *      Author: ekarabu
 */

#include "scheduler.h"



void scheduling(uint8_t *Resource, uint8_t *PR_Resource, uint32_t *latency)
{

    workload IPs[NUM_Of_IPs];
    slot Slots[NUM_Of_SLOTs];
    //uint8_t Resource[] = {1,3,1,4};
    //uint8_t PR_Resource[] = {4,3,1};
	//uint32_t latency[] = {2,2,4,3};
	//uint32_t order[] = {0,1,2,3};
    uint32_t order[NUM_Of_IPs];
    uint32_t report[NUM_Of_IPs];
	uint32_t seed = 5;

    init_IPs(IPs,Resource,latency);
    init_PRs(Slots,PR_Resource);
    init_IPs(IPs,Resource,latency);
    int interval=0;
    uint32_t i,j,k;
    for (k=0;k<NUM_Of_IPs;k++){
    	order[k]=(uint32_t)k;
    	report[k] = 0;
    }
    while(interval<TIME_FRAME){
   // 	if (RANDOMNESS){
   // 		for (k=0;k<NUM_Of_IPs;k++){
   // 			seed = (seed << 13)^seed;
  //  			seed ^= (seed >> 17);
  //  			seed ^= seed << 5;
  //  			uint32_t r = seed % NUM_Of_IPs;      // Returns a pseudo-random integer between 0 and RAND_MAX.
 //   			order[k]=r;
 //   		}
 //   	}

    	if (QUANTUM==1){
			for (i=0;i<NUM_Of_SLOTs;i++){
				reset_PRs(&Slots[i],IPs);
			}
			for (k=0;k<NUM_Of_IPs;k++){
				i=order[k];
				report[order[k]]++;
				if (avail_slot(Slots)){
					if (find_smallest_PR(Slots,&IPs[i],i))
						continue;
				}
				for (j=0;j<NUM_Of_SLOTs;j++){
					if (swaping(&Slots[j], &IPs[i], i, IPs))
						continue;
				}

			}

	    	for (j=0;j<NUM_Of_SLOTs;j++){
//	    		xil_printf("scheduling:Slot[%d] has IP %s, latency-interval =%d\n",j, Slots[j].name, (Slots[j].latency-Slots[j].interval));
	    		Update_PRs(&Slots[j]);
	    	}
	    	xil_printf("\n");
    	}
    	else{
    		if (interval%QUANTUM == 0){
    			for (i=0;i<NUM_Of_SLOTs;i++){
    				reset_PRs(&Slots[i],IPs);
    			}
    			for (k=0;k<NUM_Of_IPs;k++){
    				i=order[k];
    				report[order[k]]++;
    				if (avail_slot(Slots)){
    					if (find_smallest_PR(Slots,&IPs[i],i))
    						continue;
    				}
    				for (j=0;j<NUM_Of_SLOTs;j++){
    					if (swaping(&Slots[j], &IPs[i], i, IPs))
    						continue;
    				}
    			}
    	    	for (j=0;j<NUM_Of_SLOTs;j++){

//    	    		xil_printf("scheduling:Slot[%d] has IP %s, latency-interval =%d\n",j, Slots[j].name, (Slots[j].latency-Slots[j].interval));
    	    		Update_PRs(&Slots[j]);
    	    	}
    		}
    		else{
    			Update_IPs_and_PRs(Slots,IPs);
    		}
    	}


    	interval++;

        for (i=0;i<NUM_Of_IPs;i++){
        	IPs[i].successRate = (IPs[i].demandedResource*IPs[i].latency*IPs[i].executed)/((float)interval);
        	printf("scheduling:IP %s, success rate =%.3f and executed=%ld, requested =%ld\n",IPs[i].name, IPs[i].successRate,IPs[i].executed,report[i]);
        	printf("interval: %f",(float)interval);
        }

    	xil_printf("========================\n");

    }
//    for (i=0;i<NUM_Of_IPs;i++){
//    	IPs[i].successRate = (IPs[i].demandedResource*IPs[i].latency*IPs[i].executed)/((float)interval);
//    	printf("scheduling:IP %s, success rate =%.3f and executed=%ld, requested =%ld\n",IPs[i].name, IPs[i].successRate,IPs[i].executed,report[i]);
//    	printf("interval: %f",(float)interval);
//    }

}



void init_IPs(workload IPs[], uint8_t* Resource, uint32_t* latency){
	int i;
	for (i=0;i<NUM_Of_IPs;i++){
		IPs[i].demandedResource = Resource[i];
		IPs[i].latency = latency[i];
		IPs[i].executed = 0;
		IPs[i].priority = 0;
		IPs[i].successRate = 0;
	}
	IPs[0].name[0]='A';
	IPs[0].name[1]='E';
	IPs[0].name[2]='S';
	IPs[0].name[3]='\0';
	strcpy( IPs[1].name, "FFT\0" );
	strcpy( IPs[2].name, "SHA\0" );
	strcpy( IPs[3].name, "BFS\0" );
	strcpy( IPs[4].name, "KMP\0" );
	strcpy( IPs[5].name, "GEMM\0" );
	strcpy( IPs[6].name, "SORT\0" );
	strcpy( IPs[7].name, "SPMV\0" );
}

void init_PRs(slot Slots[], uint8_t* Resource){
	int i;

	for (i=0;i<NUM_Of_SLOTs;i++){
		Slots[i].Resource = Resource[i];
		Slots[i].empty = true;
		Slots[i].latency = 0;
		Slots[i].PR_needed = true;
		Slots[i].priority=0;
		Slots[i].interval = 0;
		Slots[i].priority_reduction = 0;
		Slots[i].IP_order = -1;
	}
	strcpy( Slots[0].name, " " );
	strcpy( Slots[1].name, " " );
	strcpy( Slots[2].name, " " );
	strcpy( Slots[3].name, " " );
	strcpy( Slots[4].name, " " );
	strcpy( Slots[5].name, " " );
	strcpy( Slots[6].name, " " );
	strcpy( Slots[7].name, " " );
}

void reset_PRs(slot* Slots, workload IPs[]){

	if ( Slots->interval != 0 && Slots->empty == false)
	{
		if( (Slots->interval % Slots->latency) == 0){
//			printf("reset_PRs:IP %sis freed\n",Slots->name);
			Slots->empty = true;
			Slots->latency = 0;
			Slots->PR_needed = true;
			Slots->interval = 0;
			Slots->priority=0;
			Slots->priority_reduction = 0;
			IPs[Slots->IP_order].executed++;
			Slots->IP_order = -1;
			strcpy( Slots->name, "\0" );
		}
	}

}

void Update_PRs(slot* Slots){

	//Perform PR
	if (Slots->PR_needed == true)
	{
		Slots->PR_needed = false;

	}
	//Perform PR and then following steps
	if (Slots->empty == false)
	{
		Slots->interval++;
	}
}

bool find_smallest_PR(slot Slots[], workload *IP, int IP_order){
	uint8_t ipResource = IP->demandedResource;
	int i;
	int order=-1;
	for (i=0;i<NUM_Of_SLOTs;i++){
		if (Slots[i].Resource >= ipResource){
			if (Slots[i].empty == true){
				if (order == -1)
					order=i;
				else{
					if (Slots[order].Resource > Slots[i].Resource)
						order=i;
				}
			}
		}
	}
	if (order != -1){
		Slots[order].empty = false;
		Slots[order].latency = IP->latency;
		Slots[order].PR_needed = true;
		Slots[order].interval = 0;
		strcpy( Slots[order].name, IP->name );
		IP->priority+= (IP->demandedResource);
		Slots[order].priority=IP->priority;
		Slots[order].priority_reduction = (IP->demandedResource);
		Slots[order].IP_order = IP_order;
		//xil_printf("find_smallest_PR: Slot[%d] is occupied with %s priority=%d\n",order,IP->name,IP->priority);
		return true;
	}
	else
		return false;
}

bool swaping(slot *Slots, workload *IP, int IP_order, workload IPs[]){
	int new_priority = Slots->priority - Slots->priority_reduction;
	uint8_t ipResource = IP->demandedResource;
	//xil_printf("swapping: %s IP priorty=%d and new_one=%d with candidate IP %s and its priority=%d\n",IPs[Slots->IP_order].name, Slots->priority, new_priority, IP->name, IP->priority );
	if (new_priority > IP->priority){
		if (Slots->Resource >= ipResource){
			//update the old PR's IP priority
			//IPs[Slots->IP_order].executed = 0;
			IPs[Slots->IP_order].priority-=Slots->priority_reduction;
			//xil_printf("swapping: %s IP is swapped with IP %s\n",IPs[Slots->IP_order].name, IP->name);
			//update the old PR's parameters
			Slots->empty = false;
			Slots->latency = IP->latency;
			Slots->PR_needed = true;
			Slots->interval = 0;
			strcpy( Slots->name, IP->name );
			Slots->priority=IP->priority;
			Slots->priority_reduction = (IP->demandedResource);
			Slots->IP_order = IP_order;
			//update the new PR's IP
			IP->priority+= (IP->demandedResource);
			return true;
		}
	}
	return false;
}

void Update_IPs_and_PRs(slot Slots[], workload IPs[]){
	int j;
	for (j=0;j<NUM_Of_SLOTs;j++){
		if ( Slots[j].empty == false)
			Slots[j].interval++;
		if ( Slots[j].interval != 0 && Slots[j].empty == false){
			if( (Slots[j].interval % Slots[j].latency) == 0){
				Slots[j].priority+=Slots[j].priority_reduction;
				IPs[Slots[j].IP_order].executed++;
				IPs[Slots[j].IP_order].priority+=Slots[j].priority_reduction;
				//xil_printf("Update_IPs_and_PRs: %s IP is priority=%d\n",IPs[Slots[j].IP_order].name, IPs[Slots[j].IP_order].priority);
			}
		}
	}

}

bool avail_slot(slot Slots[])
{
	int j;
    for(j=0;j<NUM_Of_SLOTs;j++)
    {
    	if (Slots[j].empty == true){
    		//xil_printf("avail_slot: Slot[%d] is available\n",j);
    		return true;
    	}
    }

    return false;

}

void executer(int IP_number, bool PR_needed, uint8_t pblock,uint8_t messages)

{
	switch (IP_number)
	{
		case 1:
		{
			aes_256_operation	(PR_needed ,pblock,messages);
			break;
		}
		case 2:
		{
			fft_operation	(PR_needed ,pblock,messages);
			break;
		}
		case 3:
		{
			sort_operation	(PR_needed ,pblock,messages);
			break;
		}
		case 4:
		{
			sha_operation	(PR_needed ,pblock,messages);
			break;
		}
		case 5:
		{
			gemm_operation	(PR_needed ,pblock,messages);
			break;
		}
		case 6:
		{
			bfs_operation	(PR_needed ,pblock,messages);
			break;
		}
		case 7:
		{
			spmv_operation	(PR_needed ,pblock,messages);
			break;
		}
		case 8:
		{
			kmp_operation	(PR_needed ,pblock,messages);
			break;
		}
		case 9:
		{
			stencil_operation	(PR_needed ,pblock,messages);
			break;
		}
		default:
		{
			aes_256_operation	(PR_needed ,pblock,messages);
			break;
		}
	}
}

void xorshift3232(uint32_t *seed)
{
  *seed ^= *seed << 13;
  *seed ^= *seed >> 17;
  *seed ^= *seed << 5;
}



