/*
 * Sum.hpp
 *
 *  Created on: 22 oct. 2012
 *      Author: rleguay
 */

#ifndef SUM_HPP_
#define SUM_HPP_

namespace myLibrary {

class Sum {
private:
	int m_valA, m_valB;
public:
	Sum(int valA = 0, int valB = 0);
	virtual ~Sum();
	int result() const;
};

} /* namespace myLibrary */
#endif /* SUM_HPP_ */
