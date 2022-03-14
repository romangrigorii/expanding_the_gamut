#include <xc.h>          // Load the proper header for the processor
#include "constants.h"
#include "interrupts.h"
#include "control.h"
#include "NU32.h"
#include "helpers.h"
#include <math.h>
#include <stdio.h>
#include "dsp.h"

int main(void) {
  int node = 1;

  __builtin_disable_interrupts();
  NU32_Startup();
  interrupt_init();
  SPI_com_init();
  digital_init();
  __builtin_enable_interrupts();
  NU32_ReadUART3(message,100);
  sprintf(message,"%s\n\r","CONNECTED");
  NU32_WriteUART3(message);

  while (1){
    NU32_ReadUART3(message,100);
    sscanf(message,"%c",&option);
    sprintf(message,"%c\r\n", option);
    NU32_WriteUART3(message);
    switch (option){
      case 'a':
      sprintf(message,"%d\r\n", sigout[0]);
      NU32_WriteUART3(message);
      break;
      case 'b':
      NU32_ReadUART3(message,100);
      sscanf(message,"%d", &node);
      NU32_ReadUART3(message,100);
      sscanf(message,"%lf", &amps[node]);

      if (amps[node]>1.0){
        amps[node] = 1.0;
      }
      if (amps[node]<0.0){
        amps[node] = 0.0;
      }
      sprintf(message,"node:%d\tamp:%lf\r\n", node,amps[node]);
      NU32_WriteUART3(message);
      break;
      case 'c':
      NU32_ReadUART3(message,100);
      sscanf(message,"%lf", &amps[0]);
      if (amps[0]>1.0){
        amps[0] = 1.0;
      }
      if (amps[0]<0.0){
        amps[0] = 0.0;
      }
      amps[1] = -amps[0];
      amps[2] = amps[0];
      amps[3] = -amps[0];
      amps[4] = amps[0];
      amps[5] = -amps[0];
      amps[6] = amps[0];
      amps[7] = -amps[0];
      amps[8] = amps[0];
      amps[9] = -amps[0];
      amps[10] = amps[0];
      amps[11] = -amps[0];
      amps[12] = amps[0];
      amps[13] = -amps[0];

      sprintf(message,"amp:%lf\r\n",amps[0]);
      NU32_WriteUART3(message);
      break;
      case 'f':
      NU32_ReadUART3(message,100);
      sscanf(message,"%lf", &freq);
      sprintf(message,"freq: %lf\r\n",freq);
      NU32_WriteUART3(message);
      /*
      if (freq>50.0001){
        camps[0] = 0.67;
        camps[1] = 0.998;
        camps[2] = 0.68;
        camps[3] = 0.88;
        camps[4] = 0.80;
        camps[5] = 0.64;
        camps[6] = 0.74;
        camps[7] = 0.65;
        camps[8] = 0.61;
        camps[9] = 0.77;
        camps[10] = 0.65;
        camps[11] = 0.62;
        camps[12] = 0.78;
        camps[13] = 0.93;
      } else {
        camps[0] = 1.0001;
        camps[1] = 1.0001;
        camps[2] = 1.0001;
        camps[3] = 1.0001;
        camps[4] = 1.0001;
        camps[5] = 1.0001;
        camps[6] = 1.0001;
        camps[7] = 1.0001;
        camps[8] = 1.0001;
        camps[9] = 1.0001;
        camps[10] = 1.0001;
        camps[11] = 1.0001;
        camps[12] = 1.0001;
        camps[13] = 1.0001;
      }
      */
      break;
      case 'm':
      NU32_ReadUART3(message,100);
      sscanf(message,"%lf", &mul);
      sprintf(message,"multiplier: %lf\r\n",mul);
      NU32_WriteUART3(message);
      del[0] = pi*mul;
      del[1] = pi*mul;
      del[2] = pi*mul;
      del[3] = pi*mul;
      del[4] = pi*mul;
      del[5] = pi*mul;
      del[6] = pi*mul;
      del[7] = 0.0001;
      del[8] = 0.0001;
      del[9] = 0.0001;
      del[10] = 0.0001;
      del[11] = 0.0001;
      del[12] = 0.0001;
      del[13] = 0.0001;
      break;
      case 'n':
      del[0] = 0.0;
      del[1] = 0.0;
      del[2] = pi*1/2*10.4/10.0;
      del[3] = pi*1/2*10.4/10.0;
      del[4] = pi*1/2*10.4/10.0;
      del[5] = pi*10.4/10.0;
      del[6] = pi*10.4/10.0;
      del[7] = pi*10.4/10.0;
      del[8] = pi*10.4/10.0;
      del[9] = pi*3/2*10.4/10.0;
      del[10] = pi*3/2*10.4/10.0;
      del[11] = pi*3/2*10.4/10.0;
      del[12] = pi*2*10.4/10.0;
      del[13] = pi*2*10.4/10.0;
      break;
      case 'z':
      del[0] = 0.0001;
      del[1] = 0.0001;
      del[2] = 0.0001;
      del[3] = 0.0001;
      del[4] = 0.0001;
      del[5] = 0.0001;
      del[6] = 0.0001;
      del[7] = 0.0001;
      del[8] = 0.0001;
      del[9] = 0.0001;
      del[10] = 0.0001;
      del[11] = 0.0001;
      del[12] = 0.0001;
      del[13] = 0.0001;
      break;
      case 'e':
      del[0] = pi*2.0/3.0*9.0/10.0;
      del[1] = pi*4.0/3.0*9.0/10.0;
      del[2] = pi*1.0/3.0*9.0/10.0;
      del[3] = pi*9.0/10.0;
      del[4] = pi*5.0/3.0*9.0/10.0;
      del[5] = 0.0;
      del[6] = pi*2.0/3.0*9.0/10.0;
      del[7] = pi*4.0/3.0*9.0/10.0;
      del[8] = pi*2.0*9.0/10.0;
      del[9] = pi*1.0/3.0*9.0/10.0;
      del[10] = pi*9.0/10.0;
      del[11] = pi*5.0/3.0*9.0/10.0;
      del[12] = pi*2.0/3.0*9.0/10.0;
      del[13] = pi*4.0/3.0*9.0/10.0;
      break;
      case 'r':
      del[0] = 0.0;
      del[1] = 1.35;
      del[2] = 2.7;
      del[3] = 4.05;
      del[4] = 4.95;
      del[5] = 0.0;
      del[6] = 3.6;
      del[7] = .45;
      del[8] = 1.8;
      del[9] = 5.4;
      del[10] = 3.15;
      del[11] = 4.5;
      del[12] = 2.25;
      del[13] = .9;
      break;
      case 'k':
      del[0] = pi*2/2*10.4/10;
      del[1] = pi*3/2*10.4/10;
      del[2] = pi*1/2*10.4/10;
      del[3] = pi*2/2*10.4/10;
      del[4] = pi*3/2*10.4/10;
      del[5] = 0.0;
      del[6] = pi*1/2*10.4/10;
      del[7] = pi*2/2*10.4/10;
      del[8] = pi*3/2*10.4/10;
      del[9] = 0.0;
      del[10] = pi*1/2*10.4/10;
      del[11] = pi*2/2*10.4/10;
      del[12] = 0.0;
      del[13] = pi*1/2*10.4/10;
      break;
      case 'l':
      del[0] = pi*3/2*10.4/10;
      del[1] = pi*2/2*10.4/10;
      del[2] = pi*3/2*10.4/10;
      del[3] = pi*2/2*10.4/10;
      del[4] = pi*1/2*10.4/10;
      del[5] = pi*3/2*10.4/10;
      del[6] = pi*2/2*10.4/10;
      del[7] = pi*1/2*10.4/10;
      del[8] = 0.0;
      del[9] = pi*2/2*10.4/10;
      del[10] = pi*1/2*10.4/10;
      del[11] = 0.0;
      del[12] = pi*1/2*10.4/10;
      del[13] = 0.0;
      break;
      case 't':
      NU32_ReadUART3(message,100);
      sscanf(message,"%lf", &mul);
      sprintf(message,"multiplier: %lf\r\n",mul);
      NU32_WriteUART3(message);
      del[0] = pi*mul;
      del[1] = 0.00001;
      del[2] = 0.00001;
      del[3] = 0.00001;
      del[4] = pi*mul;
      del[5] = pi*mul;
      del[6] = pi*mul;
      del[7] = pi*mul;
      del[8] = 0.00001;
      del[9] = 0.00001;
      del[10] = 0.00001;
      del[11] = pi*mul;
      del[12] = pi*mul;
      del[13] = 0.00001;
      break;
      case 'y':
      NU32_ReadUART3(message,100);
      sscanf(message,"%lf", &mul);
      sprintf(message,"multiplier: %lf\r\n",mul);
      NU32_WriteUART3(message);
      del[0] = 0.00001;
      del[1] = pi*mul;
      del[2] = pi*mul;
      del[3] = pi*mul;
      del[4] = 0.00001;
      del[5] = pi*mul;
      del[6] = 0.00001;
      del[7] = pi*mul;
      del[8] = pi*mul;
      del[9] = pi*mul;
      del[10] = 0.00001;
      del[11] = 0.00001;
      del[12] = 0.00001;
      del[13] = 0.00001;
      break;
      case 'q':
      NU32_ReadUART3(message,100);
      sscanf(message,"%lf", &mul);
      sprintf(message,"multiplier: %lf\r\n",mul);
      NU32_WriteUART3(message);
      del[0] = pi*mul;
      del[1] = 0.00001;
      del[2] = 0.00001;
      del[3] = pi*mul;
      del[4] = pi*mul;
      del[5] = 0.00001;
      del[6] = pi*mul;
      del[7] = 0.00001;
      del[8] = 0.00001;
      del[9] = pi*mul;
      del[10] = 0.00001;
      del[11] = pi*mul;
      del[12] = 0.00001;
      del[13] = pi*mul;
      break;
      case 'u':
      for (i=0;i<14;i++){
        NU32_ReadUART3(message,100);
        sscanf(message,"%lf\r\n", &del[i]);
        del[i]*=pi/2;
      }
      break;
    }
  }
}
