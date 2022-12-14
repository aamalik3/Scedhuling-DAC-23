
#include "aes_profiling.h"
#include "PR_executer.h"
#include "latency_counter.h"

void aes_256_operation_profile(workload* app_load)
{
	PR_execution_first("aes.bin", aesPrBuffer);
	set_counter((AES256_KEY ), ((AES256_Plain_Chipher+12)));
	uint8_t key[32];
    uint8_t buf[16], i;

    /* put a test vector */
    for (i = 0; i < sizeof(buf);i++){
    	buf[i] = i * 16 + i;
    }

    /* put a test vector */
    for (i = 0; i < sizeof(key); i++){
    	key[i] = i;
    }

    //Write the key
    uint32_t tmp,tmp1;
    for (i = 0; i < 8; i++){
    	tmp = tmp1 = 0;
    	tmp1 = (uint32_t)key[i*4];
    	tmp = tmp1;

    	tmp1 = (uint32_t)key[i*4+1];
    	tmp = tmp | (tmp1<<8);

    	tmp1 = (uint32_t)key[i*4+2];
    	tmp = tmp | (tmp1<<16);

    	tmp1 = (uint32_t)key[i*4+3];
    	tmp = tmp | (tmp1<<24);
    	//xil_printf("tmp: %x\n",tmp);
    	Xil_Out32 (AES256_KEY + i*4, tmp );
    }
    //xil_printf("Key is sent:\n");

    for (i = 0; i < 4; i++){
    	tmp = tmp1 = 0;
    	tmp1 = (uint32_t)buf[i*4];
    	tmp = tmp1;

    	tmp1 = (uint32_t)buf[i*4+1];
    	tmp = tmp | (tmp1<<8);

    	tmp1 = (uint32_t)buf[i*4+2];
    	tmp = tmp | (tmp1<<16);

    	tmp1 = (uint32_t)buf[i*4+3];
    	tmp = tmp | (tmp1<<24);
    	//xil_printf("tmp: %x\n",tmp);

    	Xil_Out32 (AES256_Plain_Chipher + i*4, tmp );
    }
    //xil_printf("Plaintext is sent:\n");
    //read_counter();
    Xil_Out32 (AES256_CRTL, 0x00000001 );

    //xil_printf("Start signal is sent:\n");

    int cnt =0;
    while ( !((Xil_In32 (AES256_CRTL)) & 0x2) && cnt< 10000)
    	cnt++;

    //xil_printf("cnt: %d\n",cnt);

    //xil_printf("Ciphertext:\n");
    for (i = 0; i < 4; i++){
    	tmp = Xil_In32 (AES256_Plain_Chipher+i*4);
    	//xil_printf("0x%x\n",tmp);
    }
    xil_printf("AES: ");
    read_counter();
    latency_return(app_load);

}