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
    - Modified: 2009-05-26
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
    - String to Char Pointer:
        - http://stackoverflow.com/questions/347949/convert-stdstring-to-const-char-or-char
        .
    .
*/

#ifndef __GenericModel_H__
#define __GenericModel_H__

#include <string>
#include <sstream>
#include <vector>

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
    /// Convert string to char * (char pointer).
    static char * convertToCharPointer(const std::string& str) {
        std::vector<char> writable(str.size() + 1);
        std::copy(str.begin(), str.end(), writable.begin());
        return &writable[0]; // Or: &*writable.begin()
    }
    /// Flip x coordinate for graphics (iPhone 480px: touch, accelerometer).
    static float flipCoordinateX(float value) {
        return 480 - value;
    }
    /// Flip y coordinate for graphics (iPhone 320px: touch, accelerometer).
    static float flipCoordinateY(float value) {
        return 320 - value;
    }
};

} // END namespace Discover

#endif // #ifndef __GenericModel_H__