/**
@file
    GameController.h
@brief
    Copyright 2010 Creative Crew. All rights reserved.
@author
    William Chang
@version
    0.1
@date
    - Created: 2009-05-21
    - Modified: 2010-01-18
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

//void onCardTapDown(void *, void *, vec2 *);

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
    
    /// On event, card tap down.
    static void onCardTapDown(void *obj1, void *obj2, vec2 *position);
    
    /// Set simulation engine.
    void setSimulationEngine(SIO2resource *resource, SIO2window *window);
    
    /// To string.
    string toString();

    vector<CardView *> _cardViews;
protected:
    GameModel *_gameModel;
    
    GameView *_gameView;

    
    SIO2resource *_sio2Resource;
    SIO2window *_sio2Window;
    SIO2widgettapdown *_sio2WidgetCallbackCardTapDown;
};


} // END namespace Discover

#endif // #ifndef __GameController_H__