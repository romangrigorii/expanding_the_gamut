#include <xc.h>          // Load the proper header for the processor
#include "constants.h"
#include "interrupts.h"
#include "control.h"
#include "NU32.h"
#include "helpers.h"
#include <math.h>
#include <stdio.h>
#include "dsp.h"

void digital_init(){

  TRISBbits.TRISB7 = 0;  // CS 1-2
  TRISBbits.TRISB8 = 0;  // CS 3-4
  TRISBbits.TRISB9 = 0;  // CS 5-6
  TRISBbits.TRISB10 = 0;  // CS 7-8
  TRISBbits.TRISB11 = 0;  // CS 9-10
  TRISBbits.TRISB12 = 0;  // CS 11-12
  TRISBbits.TRISB13 = 0;  // CS 13-14
}

void SPI_com_init(){
  // setting up communication with friction control chip_write
  CS1 = 1;
  CS2 = 1;
  CS3 = 1;
  CS4 = 1;
  CS5 = 1;
  CS6 = 1;
  CS7 = 1;

  SPI4CON = 0;
  SPI4BRG = 0x3; // communication at 10mhz
  SPI4BUF;

  SPI4STATbits.SPIROV = 0;
  SPI4CONbits.MODE32 = 0;
  SPI4CONbits.MODE16 = 1;
  SPI4CONbits.MSTEN = 1;
  SPI4CONbits.CKE = 1;
  SPI4CONbits.CKP = 0;
  SPI4CONbits.SMP = 0;
  SPI4CONbits.ON = 1;

}

void chip_write_data(int *d_sig){
  CS1 = 0;
  SPI4BUF = d_sig[0];
  while(!SPI4STATbits.SPIRBF){
  }
  SPI4BUF;
  CS1 = 1;
  CS1 = 0;
  SPI4BUF = d_sig[1];
  while(!SPI4STATbits.SPIRBF){
  }
  SPI4BUF;
  CS1 = 1;

  CS2 = 0;
  SPI4BUF = d_sig[2];
  while(!SPI4STATbits.SPIRBF){
  }
  SPI4BUF;
  CS2 = 1;
  CS2 = 0;
  SPI4BUF = d_sig[3];
  while(!SPI4STATbits.SPIRBF){
  }
  SPI4BUF;
  CS2 = 1;

  CS3 = 0;
  SPI4BUF = d_sig[4];
  while(!SPI4STATbits.SPIRBF){
  }
  SPI4BUF;
  CS3 = 1;
  CS3 = 0;
  SPI4BUF = d_sig[5];
  while(!SPI4STATbits.SPIRBF){
  }
  SPI4BUF;
  CS3 = 1;

  CS4 = 0;
  SPI4BUF = d_sig[6];
  while(!SPI4STATbits.SPIRBF){
  }
  SPI4BUF;
  CS4 = 1;
  CS4 = 0;
  SPI4BUF = d_sig[7];
  while(!SPI4STATbits.SPIRBF){
  }
  SPI4BUF;
  CS4 = 1;

  CS5 = 0;
  SPI4BUF = d_sig[8];
  while(!SPI4STATbits.SPIRBF){
  }
  SPI4BUF;
  CS5 = 1;
  CS5 = 0;
  SPI4BUF = d_sig[9];
  while(!SPI4STATbits.SPIRBF){
  }
  SPI4BUF;
  CS5 = 1;

  CS6 = 0;
  SPI4BUF = d_sig[10];
  while(!SPI4STATbits.SPIRBF){
  }
  SPI4BUF;
  CS6 = 1;
  CS6 = 0;
  SPI4BUF = d_sig[11];
  while(!SPI4STATbits.SPIRBF){
  }
  SPI4BUF;
  CS6 = 1;

  CS7 = 0;
  SPI4BUF = d_sig[12];
  while(!SPI4STATbits.SPIRBF){
  }
  SPI4BUF;
  CS7 = 1;
  CS7 = 0;
  SPI4BUF = d_sig[13];
  while(!SPI4STATbits.SPIRBF){
  }
  SPI4BUF;
  CS7 = 1;
}

void interrupt_init(){

  PR3 =  19999; // freq = 80,000,000/(1+7999) = 10kHz
  TMR3 = 0;
  T3CONbits.TCKPS = 0;
  T3CONbits.ON = 1;
  IPC3bits.T3IP = 4;
  IPC3bits.T3IS = 0;
  IFS0bits.T3IF = 0;
  IEC0bits.T3IE = 1;

}


void __ISR(_TIMER_3_VECTOR,IPL4SOFT) Timer3ISR(void){

  tt += 0.00025;
  sigout[0] =  ((((int) ((amps[0]*camps[0]*sin(2*pi*freq*tt - del[0]) +1)/2*dacbits)) & 0xFF)<<4) | 0x3000;    // 1
  sigout[1] =  ((((int) ((amps[1]*camps[1]*sin(2*pi*freq*tt - del[1]) +1)/2*dacbits)) & 0xFF)<<4) | 0xB000;    // 2
  sigout[2] =  ((((int) ((amps[2]*camps[2]*sin(2*pi*freq*tt - del[2]) +1)/2*dacbits)) & 0xFF)<<4) | 0x3000;    // 3
  sigout[3] =  ((((int) ((amps[3]*camps[3]*sin(2*pi*freq*tt - del[3]) +1)/2*dacbits)) & 0xFF)<<4) | 0xB000;    // 4
  sigout[4] =  ((((int) ((amps[4]*camps[4]*sin(2*pi*freq*tt - del[4]) +1)/2*dacbits)) & 0xFF)<<4) | 0x3000;    // 5
  sigout[5] =  ((((int) ((amps[5]*camps[5]*sin(2*pi*freq*tt - del[5]) +1)/2*dacbits)) & 0xFF)<<4) | 0xB000;    // 6
  sigout[6] =  ((((int) ((amps[6]*camps[6]*sin(2*pi*freq*tt - del[6]) +1)/2*dacbits)) & 0xFF)<<4) | 0x3000;    // 7
  sigout[7] =  ((((int) ((amps[7]*camps[7]*sin(2*pi*freq*tt - del[7]) +1)/2*dacbits)) & 0xFF)<<4) | 0xB000;    // 8
  sigout[8] =  ((((int) ((amps[8]*camps[8]*sin(2*pi*freq*tt - del[8]) +1)/2*dacbits)) & 0xFF)<<4) | 0x3000;    // 9
  sigout[9] =  ((((int) ((amps[9]*camps[9]*sin(2*pi*freq*tt - del[9]) +1)/2*dacbits)) & 0xFF)<<4) | 0xB000;    // 10
  sigout[10] = ((((int) ((amps[10]*camps[10]*sin(2*pi*freq*tt - del[10])+1)/2*dacbits)) & 0xFF)<<4) | 0x3000;  // 11
  sigout[11] = ((((int) ((amps[11]*camps[11]*sin(2*pi*freq*tt - del[11])+1)/2*dacbits)) & 0xFF)<<4) | 0xB000;  // 12
  sigout[12] = ((((int) ((amps[12]*camps[12]*sin(2*pi*freq*tt - del[12])+1)/2*dacbits)) & 0xFF)<<4) | 0x3000;  // 13
  sigout[13] = ((((int) ((amps[13]*camps[13]*sin(2*pi*freq*tt - del[13])+1)/2*dacbits)) & 0xFF)<<4) | 0xB000;  // 14

  chip_write_data(sigout);

  IFS0bits.T3IF = 0;
}
