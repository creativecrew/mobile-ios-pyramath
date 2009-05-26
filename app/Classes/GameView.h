/**
@file
    GameView.h
@brief
    Copyright 2009 Creative Crew. All rights reserved.
@author
    William Chang
@version
    0.1
@date
    - Created: 2009-05-25
    - Modified: 2009-05-26
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
    
    /// Set graphics window.
    void setWindow(SIO2window *window);
    
    /// To string.
    string toString();
protected:
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