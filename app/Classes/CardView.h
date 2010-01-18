/**
@file
    CardView.h
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
        - Nothing.
        .
    .
*/

#ifndef __CardView_H__
#define __CardView_H__

#include "../../src/sio2/sio2.h"
#include "CardModel.h"

using namespace std;

namespace Discover {

/** @class CardView */
class CardView {
public:
    /// Default constructor.
    CardView();
    /// Parameter constructor.
    CardView(string filepath, string name);
    /// Parameter constructor.
    CardView(string filepath, string name, CardModel *model);
    /// Default destructor (optionally overridden).
    virtual ~CardView();
    
    // Set card model.
    void setCardModel(CardModel *model);
    
    /// Set tap down callback. Arguments: SIO2widget, SIO2window, vec2.
    void setCallbackTapDown(SIO2widgettapdown *fnName);
    /// Set tap down callback. Arguments: SIO2widget, SIO2window, vec2.
    void setCallbackTapDown(SIO2widgettapdown *fnName, void *objData);
    
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
    
    SIO2widget *_sio2WidgetCard;
protected:
    string _filepath;
    string _name;
    bool _debug;
    CardModel *_cardModel;
    
    SIO2resource *_sio2Resource;
    SIO2window *_sio2Window;
    

    SIO2image *_sio2ImageCard;
    SIO2material *_sio2MaterialCard;
};

} // END namespace Discover

#endif // #ifndef __CardView_H__