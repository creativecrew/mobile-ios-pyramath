/**
@file
    CardModel.h
@brief
    Copyright 2009 Creative Crew. All rights reserved.
@author
    William Chang
@version
    0.1
@date
    - Created: 2009-05-19
    - Modified: 2009-05-23
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
#include "Model.h"

using namespace std;

namespace Discover {

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
    CardModel(string name, int value);
    /// Default destructor (optionally overridden).
    virtual ~CardModel();
    
    /// Get name.
    string getName();
    /// Get state.
    CardState getState();
    /// Get value.
    int getValue();
    /// Get visible.
    bool getVisible();
    /// Set name.
    void setName(string name);
    /// Set state.
    void setState(CardState state);
    /// Set value.
    void setValue(int value);
    /// Set visible.
    void setVisible(bool visible);

    /// Get position x.
    int getPositionX();
    /// Get position y.
    int getPositionY();
    /// Set position x.
    void setPositionX(int x);
    /// Set position y.
    void setPositionY(int y);
    
    /// To string.
    string toString();
protected:
    string _name;
    int _value;
    bool _visible;
    CardState _state;
    
    int _positionX, _positionY;
};

} // END namespace Discover

#endif // #ifndef __CardModel_H__