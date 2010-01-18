/**
@file
    CardModel.h
@brief
    Copyright 2010 Creative Crew. All rights reserved.
@author
    William Chang
@version
    0.1
@date
    - Created: 2009-05-19
    - Modified: 2010-01-18
    .
@note
    References:
    - General:
        - Nothing.
        .
    - typedef enum:
        - http://bytes.com/topic/c/answers/741829-difference-between-typedef-enum-enum
        .
    .
*/

#ifndef __CardModel_H__
#define __CardModel_H__

#include "GenericModel.h"
#include "Models.h"

using namespace std;

namespace Discover {

enum CardVisible {
    CARD_VISIBLE_HIDDEN = 0,
    CARD_VISIBLE_BACKSIDE = 1,
    CARD_VISIBLE_FRONTSIDE = 2
};

enum CardState {
    CARD_STATE_TRASHED = 0,
    CARD_STATE_NEW = 1,
    CARD_STATE_USED = 2
};

/** @class CardModel */
class CardModel : GenericModel {
public:
    /// Default constructor.
    CardModel();
    /// Parameter constructor.
    CardModel(unsigned int id, string name, int value);
    /// Default destructor (optionally overridden).
    virtual ~CardModel();
    
    /// Get id.
    unsigned int getId();
    /// Get name.
    string getName();
    /// Get state.
    CardState getState();
    /// Get value.
    int getValue();
    /// Get visible.
    CardVisible getVisible();
    /// Set id.
    void setId(unsigned int id);
    /// Set name.
    void setName(string name);
    /// Set state.
    void setState(CardState state);
    /// Set value.
    void setValue(int value);
    /// Set visible.
    void setVisible(CardVisible visible);

    /// Get position x.
    float getPositionX();
    /// Get position y.
    float getPositionY();
    /// Set position x.
    void setPositionX(float x);
    /// Set position y.
    void setPositionY(float y);
    
    /// To string.
    string toString();
protected:
    unsigned int _id;
    string _name;
    int _value;
    CardVisible _visible;
    CardState _state;
    
    float _positionX, _positionY;
};

} // END namespace Discover

#endif // #ifndef __CardModel_H__