/*
 * TestSum.hpp
 *
 *  Created on: 22 oct. 2012
 *      Author: rleguay
 */

#ifndef TESTSUM_HPP_
#define TESTSUM_HPP_

#include <iostream>
#include <Sum.hpp>

namespace projectB {

class TestSum {
private:
	myLibrary::Sum m_sum;
public:
	TestSum();
	virtual ~TestSum();

	int result() const;
};

} /* namespace projectB */

std::ostream& operator<<(std::ostream& os, const projectB::TestSum& testSum);

#endif /* TESTSUM_HPP_ */
