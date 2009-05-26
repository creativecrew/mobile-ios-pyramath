/**
@file
    CardView.h
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
        - Nothing.
        .
    .
*/

#ifndef __CardView_H__
#define __CardView_H__

#include "../../src/sio2/sio2.h"
#include "GenericModel.h"

using namespace std;

namespace Discover {

/** @class CardView */
class CardView {
public:
    /// Default constructor.
    CardView();
    /// Parameter constructor.
    CardView(string filepath, string name);
    /// Default destructor (optionally overridden).
    virtual ~CardView();
    
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
    string _filepath;
    string _name;
    
    SIO2window *_sio2Window;
    
    SIO2widget *_sio2WidgetCard;
    SIO2image *_sio2ImageCard;
    SIO2material *_sio2MaterialCard;
};

} // END namespace Discover

#endif // #ifndef __CardView_H__