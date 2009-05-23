/**
@file
    GameController.h
@brief
    Copyright 2009 Creative Crew. All rights reserved.
@author
    William Chang
@version
    0.1
@date
    - Created: 2009-05-21
    - Modified: 2009-05-21
    .
@note
    References:
    - General:
        - Nothing.
        .
    .
*/

#ifndef __GameController_H__
#define __GameController_H__

#include "Model.h"

namespace Discover {

/** @class GameController */
class GameController {
public:
    /// Default constructor.
    GameController();
    /// Default destructor (optionally overridden).
    virtual ~GameController();
    
    /// Create deck of cards.
    void createDeck();
    DeckModel * getDeck();
    
    /// To string.
    string toString();
protected:
    DeckModel *_deck;
};

} // END namespace Discover

#endif // #ifndef __GameController_H__