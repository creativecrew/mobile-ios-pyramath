/**
@file
    GenericModel.h
@brief
    Copyright 2009 Creative Crew. All rights reserved.
@author
    William Chang
@version
    0.1
@date
    - Created: 2009-05-21
    - Modified: 2009-05-23
    .
@note
    References:
    - General:
        - Nothing.
        .
    - Template:
        - http://womble.decadentplace.org.uk/c++/template-faq.html
        - http://msdn.microsoft.com/en-us/library/swta9c6e(VS.80).aspx
        .
    - String:
        - http://www.informit.com/guides/content.aspx?g=cplusplus&seqNum=72
        .
    .
*/

#ifndef __GenericModel_H__
#define __GenericModel_H__

#include <string>
#include <sstream>

namespace Discover {

/** @class GenericModel */
class GenericModel {
public:
    /// Convert string to type.
    /// Usage: float value = convertToType<float>(str);
    template<typename T>
    static T convertToType(const std::string& str) {  
        std::stringstream ss;
        ss << str;
        T type;
        ss >> type;
        return type;
    }
    /// Convert type to string.
    /// Usage: string value = convertToString(123.45);
    template<typename T>
    static std::string convertToString(const T& t) {
        std::string str;
        std::ostringstream oss;
        oss << t;
        str = oss.str();
        return str;
    }
};

} // END namespace Discover

#endif // #ifndef __GenericModel_H__