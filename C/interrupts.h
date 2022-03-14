#ifndef interrupts
#define interrupts

#define CS1 LATBbits.LATB7
#define CS2 LATBbits.LATB8
#define CS3 LATBbits.LATB9
#define CS4 LATBbits.LATB10
#define CS5 LATBbits.LATB11
#define CS6 LATBbits.LATB12
#define CS7 LATBbits.LATB13


void chip_write_data(int*);
void SPI_com_init();
void output_compute();
void interrupt_init();
void digital_init();

double dacbits = 256.0;
double tt = 0.0;
int sigout[14];
double amps[] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
// double camps[] = {0.67,0.998,0.68,0.88,0.80,0.64,0.74,0.65,0.61,0.77,0.65,0.62,0.78,0.93};
double camps[] = {1.0001,1.0001,1.0001,1.0001,1.0001,1.0001,1.0001,1.0001,1.0001,1.0001,1.0001,1.0001,1.0001,1.0001};
double del[] = {.79,0.0,1.57,.79,0.0,2.36,1.57,.79,0.0,2.36,1.57,.79,2.36,1.57};
double freq = 25.0;
double mul = 1.000;
#endif
