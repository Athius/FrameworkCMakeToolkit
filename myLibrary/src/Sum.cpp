/*
 * Sum.cpp
 *
 *  Created on: 22 oct. 2012
 *      Author: rleguay
 */

#include "Sum.hpp"

namespace myLibrary {

Sum::Sum(int valA, int valB) : m_valA(valA), m_valB(valB)
{

}

Sum::~Sum()
{
}

int Sum::result() const
{
	return m_valA + m_valB;
}

} /* namespace myLibrary */
