/*
 * DummyClass.hpp
 *
 *  Created on: 27 oct. 2012
 *      Author: rleguay
 */

#ifndef DUMMYCLASS_HPP_
#define DUMMYCLASS_HPP_

#include <iostream>

namespace simproj
{

  class DummyClass
  {
  private:
    std::string m_message;

  public:
    DummyClass(std::string message = "Hello World!!");
    virtual ~DummyClass();

    const std::string& message() const;
  };

} /* namespace simproj */

std::ostream& operator<<(std::ostream& os, const simproj::DummyClass& dum);

#endif /* DUMMYCLASS_HPP_ */
