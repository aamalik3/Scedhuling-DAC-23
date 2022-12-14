/*
 * PR_executer.h
 *
 *  Created on: Sep 4, 2022
 *      Author: ekarabu
 */

#ifndef SRC_PR_EXECUTER_H_
#define SRC_PR_EXECUTER_H_

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "xparameters.h"
#include "xil_printf.h"
#include "xil_cache.h"
#include "ff.h"
#include "xdevcfg.h"
#include "xhwicap.h"
#include "xil_io.h"
#include "xil_types.h"

// Turn on/off Debug messages
#ifdef DEBUG_PRINT
#define  debug_printf  xil_printf
#else
#define  debug_printf(msg, args...) do {  } while (0)
#endif

// Read function for STDIN
extern char inbyte(void);



// Driver Instantiations

XDcfg DcfgInstance;
XDcfg *DcfgInstPtr;

XHwIcap *HwIcapInstPtr;
u32 * partial_bitstream_buffers;
unsigned int partial_bitstream_FileSizes[24];
int PR_Status;

int SD_Init();

int SD_TransferPartial(char *FileName, u32 DestinationAddress, u32 ByteLength);
int PR_Init();
int PR_execution(char* file_name, u32 * partial_bitstream_buffers);
int PR_execution_first(char* file_name, u32 * partial_bitstream_buffers);

#endif /* SRC_PR_EXECUTER_H_ */
