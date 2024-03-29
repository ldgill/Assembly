/*
 * main.c
 */
#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include "inc/hw_types.h"
#include "inc/hw_memmap.h"
#include "driverlib/sysctl.h"
#include "driverlib/gpio.h"

#ifdef DEBUG
void
__error__(char *pcFilename, uint32_t ui32Line)
{
}
#endif

 #define RED_LED   GPIO_PIN_1
 #define BLUE_LED  GPIO_PIN_2
 #define GREEN_LED GPIO_PIN_3

extern int fibonacci(int n);

int convert_to_morose(int n){
    switch(n){
    case 0:
        return 0b11111;
    case 1:
        return 0b01111;
    case 2:
        return 0b00111;
    case 3:
        return 0b00011;
    case 4:
        return 0b00001;
    case 5:
        return 0b00000;
    case 6:
        return 0b10000;
    case 7:
        return 0b11000;
    case 8:
        return 0b11100;
    case 9:
        return 0b11110;
    default:
        break;
    }
    return 0;
}

    void blink(int x){

        int mout = 0b0;
        int words = 0;
        int y = 0;

        while(x>0){
           y = x%10;
           int new = convert_to_morose(y);
           mout = mout | new;
           mout = mout << 5;
           words = words+1;
           x = (x-y)/10;
        }


        int total;
        int compare;

        for(total = 5*words; total > 0; total--){
            switch(words){
                case 0:
                    compare = mout & 0x10;
                    break;
                case 1:
                    compare = mout & 0x200;
                    break;
                case 2:
                    compare = mout & 0x4000;
                    break;
                case 3:
                    compare = mout & 0x100000;
                    break;
                case 4:
                    compare = mout & 0x1000000;
                    break;
                case 5:
                    compare = mout & 0x20000000;
                    break;
                default:
                    GPIOPinWrite(GPIO_PORTF_BASE, RED_LED|BLUE_LED|GREEN_LED, BLUE_LED); //invalid, will turn led blue
                    break;
            }

            if(compare >= 1){
               GPIOPinWrite(GPIO_PORTF_BASE, RED_LED|BLUE_LED|GREEN_LED, RED_LED); //turn on red LED for a 1
               SysCtlDelay(5000000);
               GPIOPinWrite(GPIO_PORTF_BASE, RED_LED|BLUE_LED|GREEN_LED, BLUE_LED);
            }
            if(compare == 0){
               GPIOPinWrite(GPIO_PORTF_BASE, RED_LED|BLUE_LED|GREEN_LED, GREEN_LED); //turn on green LED for a 0
               SysCtlDelay(5000000);
               GPIOPinWrite(GPIO_PORTF_BASE, RED_LED|BLUE_LED|GREEN_LED, BLUE_LED);
            }
           //GPIOPinWrite(GPIO_PORTF_BASE, RED_LED|BLUE_LED|GREEN_LED, BLUE_LED); //invalid, will turn led blue
            SysCtlDelay(5000000); //delay between each digit of the morse number
            if (total % 5 == 0){
                GPIOPinWrite(GPIO_PORTF_BASE, RED_LED|BLUE_LED|GREEN_LED, BLUE_LED); //invalid, will turn led blue
                SysCtlDelay(10000000); //delay between each of the morse number
            }
            mout = mout << 1;
        }


    }


int main(void) {
       // Setup the system clock to run at 50 Mhz from PLL with crystal reference
       //
       SysCtlClockSet(SYSCTL_SYSDIV_4|SYSCTL_USE_PLL|SYSCTL_XTAL_16MHZ|SYSCTL_OSC_MAIN);

       //
       // Enable and configure the GPIO port for the LED operation.
       //
       SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOF);
       GPIOPinTypeGPIOOutput(GPIO_PORTF_BASE, RED_LED|BLUE_LED|GREEN_LED);

       int i;

    for(i = 0; i<= 20; i++){ //??????????????????????????????//
        int yo = fibonacci(i);
       // blink(yo);
       //SysCtlDelay(20000000); //delay between results
    }
    return 0;
}
