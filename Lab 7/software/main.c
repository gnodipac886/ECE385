// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng

int main()
{
	int i = 0;
	volatile unsigned int *LED_PIO = (unsigned int*)0xa0; //make a pointer to access the PIO block
	volatile unsigned int *sw = (unsigned int*)0x80;
	volatile unsigned int *acc_reset = (unsigned int*)0x60;
	volatile unsigned int *acc = (unsigned int*)0x70;

	*LED_PIO = 0; //clear all LEDs
	int pause = 0;
 	volatile unsigned int sum = 0;
	while ( (1+1) != 3) //infinite loop
	{
		if(*acc_reset == 1){
			sum = 0;
		}
		if(*acc == 1 && pause == 0){
			sum += *sw;
			pause = 1;
		}
		if(*acc == 0){
			pause = 0;
		}
		*LED_PIO = sum;
		/*
		for (i = 0; i < 100000; i++); //software delay
		*LED_PIO |= 0x1; //set LSB
		for (i = 0; i < 100000; i++); //software delay
		*LED_PIO &= ~0x1; //clear LSB
		*/
	}
	return 1; //never gets here
}
