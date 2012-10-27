/*
 * DummyClass.cpp
 *
 *  Created on: 27 oct. 2012
 *      Author: rleguay
 */

#include "DummyClass.hpp"

namespace simproj
{

  DummyClass::DummyClass(std::string message) :
      m_message(message)
  {
  }

  DummyClass::~DummyClass()
  {
  }

  const std::string&  DummyClass::message() const
  {
    return m_message;
  }

} /* namespace simproj */

std::ostream& operator <<(std::ostream& os, const simproj::DummyClass& dum)
{
  os << dum.message();
  return os;
}

