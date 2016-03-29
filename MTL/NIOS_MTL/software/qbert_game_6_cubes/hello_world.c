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
  int XDIAG_DEMI = 30; // xdiag_demi = 30
  int YDIAG_DEMI = 55; // ydiag_demi = 32
  int XYDIAG_DEMI = (XDIAG_DEMI << 10) | YDIAG_DEMI;
  int RANK1_X_OFFSET = 600;
  int RANK1_Y_OFFSET = 100;
  int RANK1_XY_OFFSET = (RANK1_X_OFFSET << 10) | RANK1_Y_OFFSET;
  int QBERT_POSITION_X0 = RANK1_X_OFFSET; // x0 = 600
  int QBERT_POSITION_Y0 = RANK1_Y_OFFSET; // yo = 90
  int QBERT_POSITION_XY0 = (QBERT_POSITION_X0 << 10) | QBERT_POSITION_Y0;
  int qbert_jump = 0;

  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,0, enable);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,4, XLENGTH);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,8, XYDIAG_DEMI);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,12, RANK1_XY_OFFSET);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,16, QBERT_POSITION_XY0);
//  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,20, QBERT_POSITION_XY1);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 24, qbert_jump);
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

