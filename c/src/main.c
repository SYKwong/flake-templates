#include <stdio.h>

#include "example.h"

int main(void) {
  uint32_t reg = bit_set(0x00000000U, 3);
  printf("reg = 0x%08X\n", reg);
  return 0;
}
