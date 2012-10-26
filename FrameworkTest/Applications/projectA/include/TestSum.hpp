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

#include <boost/shared_ptr.hpp>

namespace projectA {

class TestSum {
private:
	myLibrary::Sum m_sum;
	boost::shared_ptr<double> m_doublePtr;

public:
	TestSum();
	virtual ~TestSum();

	int result() const;
};

} /* namespace projectA */

std::ostream& operator<<(std::ostream& os, const projectA::TestSum& testSum);

#endif /* TESTSUM_HPP_ */
