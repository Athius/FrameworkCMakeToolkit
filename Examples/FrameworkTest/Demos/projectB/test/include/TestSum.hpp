#include <cxxtest/TestSuite.h>

#include <TestSum.hpp>

class TestSum: public CxxTest::TestSuite {
public:
	void testAddition(void)
	{
		projectB::TestSum mySum;
		TS_ASSERT_EQUALS(mySum.result(), 3);
	}
};

