/**
@file
    DeckModel.h
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
        - http://www.devmaster.net/forums/showthread.php?t=7470
        - http://wiki.forum.nokia.com/index.php/CS001142_-_Shuffling_data_using_STL_random_shuffle_algorithm
        .
    - Array:
        - http://www.fredosaurus.com/notes-cpp/misc/random-shuffle.html
        .
    - Pointer:
        - http://www.scribd.com/doc/10989281/C-Lecture-13-Pointers-and-Dynamic-Arrays-WYP
        - http://www.infernodevelopment.com/simple-c-pointers-and-references
        - http://www.java2s.com/Tutorial/Cpp/0180__Class/Anarrayofpointerstoobjects.htm
        - http://stackoverflow.com/questions/320506/c-how-to-create-an-array-of-objects-on-the-stack
        .
    .
*/

#ifndef __DeckModel_H__
#define __DeckModel_H__

#include <stdlib.h> // rand(), srand()
#include <time.h> // time()
#include <vector>
#include <algorithm> // random_shuffle()
#include "GenericModel.h"
#include "Models.h"

#define DECK_CARDS_MAX 52

using namespace std;

namespace Discover {

// Forward declaration.
class CardModel;

enum DeckVisible {
    DECK_VISIBLE_HIDDEN = 0,
    DECK_VISIBLE_BACKSIDE = 1,
    DECK_VISIBLE_FRONTSIDE = 2
};

/** @class DeckModel */
class DeckModel : GenericModel {
public:
    /// Default constructor.
    DeckModel();
    /// Parameter constructor.
    DeckModel(int length);
    /// Default destructor (optionally overridden).
    virtual ~DeckModel();
    
    /// Get id.
    unsigned int getId();
    /// Get visible.
    DeckVisible getVisible();
    /// Set id.
    void setId(unsigned int id);
    /// Set visible.
    void setVisible(DeckVisible visible);
    
    /// Add card to deck.
    void addCard(CardModel *card);
    /// Get card from deck by index.
    CardModel * getCard(int index);
    /// Get deck length.
    int getDeckLength();
    /// Remove card from deck by index.
    void removeCard(int index);
    /// Shuffle deck of cards.
    void shuffleDeck();
    
    /// Get position x.
    float getPositionX();
    /// Get position y.
    float getPositionY();
    /// Set position x.
    void setPositionX(float x);
    /// Set position y.
    void setPositionY(float y);
    
    /// To string.
    string toString();
protected:
    unsigned int _id;
    vector<CardModel *> _cards;
    int _cardIndexCurrent;
    DeckVisible _visible;
    
    float _positionX, _positionY;
};

} // END namespace Discover

#endif // #ifndef __DeckModel_H__