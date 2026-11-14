#include "example.h"
#include "unity.h"

void setUp(void) {}
void tearDown(void) {}

void test_add_adds_two_integers(void) { TEST_ASSERT_EQUAL_INT(5, add(2, 3)); }
