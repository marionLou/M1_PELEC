/*
 * test.c
 *
 *  Created on: 29 mars 2016
 *      Author: Stephane
 */

/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include "io.h"
#include "system.h"

int main(void)
{

  int enable = 1;
  int XLENGTH = 55; // xlength = 55
  int XDIAG_DEMI = 150; // xdiag_demi = 30
  int YDIAG_DEMI = 200; // ydiag_demi = 32
  int X0 = 450; // x0 = 600
  int Y0 = 100; // yo = 90
  int qbertj = 1;

  IOWR_32DIRECT(QBERT_MOVE_0_BASE,0, enable);
  IOWR_32DIRECT(QBERT_MOVE_0_BASE,4, XLENGTH);
  IOWR_32DIRECT(QBERT_MOVE_0_BASE,8, XDIAG_DEMI);
  IOWR_32DIRECT(QBERT_MOVE_0_BASE,12, YDIAG_DEMI);
  IOWR_32DIRECT(QBERT_MOVE_0_BASE,16, X0);
  IOWR_32DIRECT(QBERT_MOVE_0_BASE,20, Y0);
  IOWR_32DIRECT(QBERT_MOVE_0_BASE,24, qbertj);
  printf("Move my Qbert!\n");

  /*
  while(1){
 IOWR_32DIRECT(QBERT_MOVE_0_BASE,0, XLENGTH);
  IOWR_32DIRECT(QBERT_MOVE_0_BASE,4, XDIAG_DEMI | (YDIAG_DEMI << 11));
 IOWR_32DIRECT(QBERT_MOVE_0_BASE,8, X0 | (Y0 << 11));

 length_m = IORD_32DIRECT(QBERT_MOVE_0_BASE,0);
 XYDIAG_m = IORD_32DIRECT(QBERT_MOVE_0_BASE,4);
 XY_m = IORD_32DIRECT(QBERT_MOVE_0_BASE,8);
 printf("length :'%d' and diag : '%d' and xy : '%d'\n",length_m, XYDIAG_m,XY_m);
 // IOWR_32DIRECT(QBERT_MOVE_0_BASE,12, enable);
 // IOWR_32DIRECT(QBERT_MOVE_0_BASE,16, enable);
  }*/
  return 0;
}

