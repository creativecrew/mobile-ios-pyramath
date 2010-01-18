/**
@file
    GameView.h
@brief
    Copyright 2010 Creative Crew. All rights reserved.
@author
    William Chang
@version
    0.1
@date
    - Created: 2009-05-25
    - Modified: 2010-01-18
    .
@note
    References:
    - General:
        - http://sio2interactive.wikidot.com/
        .
    .
*/

#ifndef __GameView_H__
#define __GameView_H__

#include "../../src/sio2/sio2.h"
#include "GenericModel.h"

using namespace std;

namespace Discover {

/** @class GameView */
class GameView {
public:
    /// Default constructor.
    GameView();
    /// Default destructor (optionally overridden).
    virtual ~GameView();
    
    /// Load before rendering.
    void load();
    /// Frame begin
    void frameBegin();
    /// Frame end.
    void frameEnd();
    
    /// Set graphics engine.
    void setSimulationEngine(SIO2resource *resource, SIO2window *window);
    
    /// Set debug.
    void setDebug(bool debug);
    /// To string.
    string toString();
protected:
    bool _debug;
    
    SIO2resource *_sio2Resource;
    SIO2window *_sio2Window;
    
    SIO2font *_sio2Font;
    SIO2image *_sio2ImageFont;
    SIO2material *_sio2MaterialFont;
    
    SIO2widget *_sio2WidgetBackground;
    SIO2image *_sio2ImageBackground;
    SIO2material *_sio2MaterialBackground;
};

} // END namespace Discover

#endif // #ifndef __GameView_H__