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
    - Modified: 2009-05-26
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

#include <iostream>
#include <vector>

#include "../../src/sio2/sio2.h"
#include "Models.h"
#include "GameView.h"
#include "DeckView.h"
#include "CardView.h"

namespace Discover {

/** @class GameController */
class GameController {
public:
    /// Default constructor.
    GameController();
    /// Default destructor (optionally overridden).
    virtual ~GameController();
    
    /// Load.
    void load();
    /// Frame begin
    void frameBegin();
    /// Frame end.
    void frameEnd();
    
    /// Set graphics window.
    void setWindow(SIO2window *window);
    
    /// To string.
    string toString();
protected:
    GameModel *_gameModel;
    
    GameView *_gameView;
    vector<CardView *> _cardViews;
    
    SIO2window *_sio2Window;
};

} // END namespace Discover

#endif // #ifndef __GameController_H__