#include "example.h"

uint32_t bit_set(uint32_t reg, uint8_t bit) { return reg | (1U << bit); }
