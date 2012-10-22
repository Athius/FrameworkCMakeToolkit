/*
 * TestSum.cpp
 *
 *  Created on: 22 oct. 2012
 *      Author: rleguay
 */

#include "TestSum.hpp"

namespace projectB {

TestSum::TestSum() : m_sum(1,2){
}

TestSum::~TestSum() {
}

int TestSum::result() const {
	return m_sum.result();
}

} /* namespace projectB */

std::ostream& operator <<(std::ostream& os, const projectB::TestSum& testSum) {
	os << testSum.result();
	return os;
}
