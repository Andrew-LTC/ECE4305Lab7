/*
 * blinkingLed_core.cpp
 *
 *  Created on: Mar 10, 2022
 *      Author: Andrew
 */


#include "blinkingLeds_core.h"

blinkingLedsCore::blinkingLedsCore(uint32_t core_base_addr){
	base_addr = core_base_addr;
	wr_data = 0;
}
blinkingLedsCore::~blinkingLedsCore(){
}

//depending on position indicated we write to different registers
void blinkingLedsCore::WriteMs(uint32_t interval, int led_pos){
	wr_data = interval;
	switch(led_pos){
		case 0://write input to led 0
			io_write(base_addr,LED_REG0,wr_data);
			break;
		case 1:
			io_write(base_addr,LED_REG1,wr_data);
			break;
		case 2:
			io_write(base_addr,LED_REG2,wr_data);
			break;
		case 3:
			io_write(base_addr,LED_REG3,wr_data);
			break;
		default: ;//do nothing
		}
}

