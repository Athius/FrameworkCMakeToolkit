#include <cxxtest/TestSuite.h>

#include <Sum.hpp>

class TestSum: public CxxTest::TestSuite {
public:
	void testAddition(void)
	{
		myLibrary::Sum mySum(1,2);
		TS_ASSERT_EQUALS(mySum.result(), 3);
	}
};
