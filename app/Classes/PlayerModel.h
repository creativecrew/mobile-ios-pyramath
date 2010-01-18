/**
@file
    PlayerModel.h
@brief
    Copyright 2010 Creative Crew. All rights reserved.
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
    .
*/

#ifndef __PlayerModel_H__
#define __PlayerModel_H__

#include "GenericModel.h"
#include "Models.h"

using namespace std;

namespace Discover {

/** @class PlayerModel */
class PlayerModel : GenericModel {
public:
    /// Default constructor.
    PlayerModel();
    /// Parameter constructor.
    PlayerModel(unsigned int id, string name);
    /// Default destructor (optionally overridden).
    virtual ~PlayerModel();

    /// Get id.
    unsigned int getId();
    /// Get name
    string getName();
    /// Get score.
    int getScore();
    /// Set id.
    void setId(unsigned int id);
    /// Set name.
    void setName(string name);
    /// Set score.
    void setScore(int score);
    
    /// To string.
    string toString();
protected:
    unsigned int _id;
    string _name;
    int _score;
};

} // END namespace Discover

#endif // #ifndef __PlayerModel_H__