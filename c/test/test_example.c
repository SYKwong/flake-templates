#include "example.h"
#include "unity.h"

void setUp(void) {}
void tearDown(void) {}

void test_bit_set_sets_target_bit(void) {
  TEST_ASSERT_EQUAL_HEX32(0x00000008U, bit_set(0x00000000U, 3));
}
