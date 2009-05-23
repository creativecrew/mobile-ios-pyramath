/**
@file
    PlayerModel.h
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

#ifndef __PlayerModel_H__
#define __PlayerModel_H__

#include "GenericModel.h"
#include "Model.h"

using namespace std;

namespace Discover {

/** @class PlayerModel */
class PlayerModel : GenericModel {
public:
    /// Default constructor.
    PlayerModel();
    /// Default destructor (optionally overridden).
    virtual ~PlayerModel();

    /// Get score.
    int getScore();
    /// Set score.
    void setScore(int score);
    
    /// To string.
    string toString();
protected:
    int _score;
};

} // END namespace Discover

#endif // #ifndef __PlayerModel_H__