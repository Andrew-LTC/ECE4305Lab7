/*
 * blinkingLeds_core.h
 *
 *  Created on: Mar 9, 2022
 *      Author: Andrew
 */

#ifndef SRC_BLINKINGLEDS_CORE_H_
#define SRC_BLINKINGLEDS_CORE_H_

#include "chu_init.h"

class blinkingLedsCore {
public:

	//register map
	enum{
		//registers for each of the 4 leds
		LED_REG0 = 0,
		LED_REG1 = 1,
		LED_REG2 = 2,
		LED_REG3 = 3,
	};

	//constructor
	blinkingLedsCore(uint32_t core_base_addr);
	~blinkingLedsCore();

	//methods
	void WriteMs(uint32_t interval, int led_pos);

private:
	uint32_t base_addr;
	uint32_t wr_data;
};
#endif /* SRC_BLINKINGLEDS_CORE_H_ */
