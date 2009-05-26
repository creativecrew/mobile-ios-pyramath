/**
@file
    DeckView.h
@brief
    Copyright 2009 Creative Crew. All rights reserved.
@author
    William Chang
@version
    0.1
@date
    - Created: 2009-05-26
    - Modified: 2009-05-26
    .
@note
    References:
    - General:
        - Nothing.
        .
    .
*/

#ifndef __DeckView_H__
#define __DeckView_H__

#include "../../src/sio2/sio2.h"
#include "DeckModel.h"

using namespace std;

namespace Discover {

/** @class DeckView */
class DeckView {
public:
    /// Default constructor.
    DeckView();
    /// Parameter constructor.
    DeckView(string filepath, string name, DeckModel *model);
    /// Default destructor (optionally overridden).
    virtual ~DeckView();
    
    // Set deck model.
    void setDeckModel(DeckModel *model);
    
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
    DeckModel *_deckModel;
    
    SIO2window *_sio2Window;
    
    SIO2widget *_sio2WidgetDeck;
    SIO2image *_sio2ImageDeck;
    SIO2material *_sio2MaterialDeck;
};

} // END namespace Discover

#endif // #ifndef __DeckView_H__