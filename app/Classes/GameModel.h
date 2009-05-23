/**
@file
    GameModel.h
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
    .
*/

#ifndef __GameModel_H__
#define __GameModel_H__

#include "GenericModel.h"
#include "Model.h"

using namespace std;

namespace Discover {

/** @class GameModel */
class GameModel : GenericModel {
public:
    /// Default constructor.
    GameModel();
    /// Default destructor (optionally overridden).
    virtual ~GameModel();
    
    /// Get turn count.
    int getCount();
    
    /// To string.
    string toString();
protected:
    int _count;
};

} // END namespace Discover

#endif // #ifndef __GameModel_H__