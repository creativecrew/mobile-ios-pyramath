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
    - Modified: 2010-02-07
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
    bool load();
    /// Frame begin
    void frameBegin();
    /// Frame end.
    void frameEnd();
    
    /// On event, card tap down.
    static void onCardTapDown(void *obj1, void *obj2, vec2 *position);
    
    /// Set simulation engine.
    void setSimulationEngine(SIO2 *sio2Base);
    
    /// To string.
    string toString();

    vector<CardView *> _cardViews;
protected:
    bool _hasResource;
    
    GameModel *_gameModel;
    
    GameView *_gameView;

    SIO2 *_sio2Base;
    SIO2window *_sio2Window;
    SIO2resource *_sio2Resource;
    SIO2camera *_sio2Camera;
    
    SIO2widgettapdown *_sio2WidgetCallbackCardTapDown;
};


} // END namespace Discover

#endif // #ifndef __GameController_H__