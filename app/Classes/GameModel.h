/**
@file
    GameModel.h
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

#ifndef __GameModel_H__
#define __GameModel_H__

#include <vector>

#include "GenericModel.h"
#include "Models.h"

using namespace std;

namespace Discover {

// Forward declaration.
class PlayerModel;
class DeckModel;

/** @class GameModel */
class GameModel : GenericModel {
public:
    /// Default constructor.
    GameModel();
    /// Default destructor (optionally overridden).
    virtual ~GameModel();
    
    /// Add player to game.
    void addPlayer(PlayerModel *player);
    /// Get player from game.
    PlayerModel * getPlayer(int index);
    /// Get number of players.
    int getPlayersLength();
    /// Remove player.
    void removePlayer(int index);
    
    /// Add deck to board.
    void addDeck(DeckModel *deck);
    /// Get deck from board.
    DeckModel * getDeck(int index);
    /// Get number of decks.
    int getDecksLength();
    /// Remove deck.
    void removeDeck(int index);
    
    /// Get time count in seconds.
    unsigned int getCountTime();
    /// Get turn count.
    unsigned int getCountTurn();
    /// Set time count in seconds.
    void setCountTime(unsigned int count);
    /// Set turn count.
    void setCountTurn(unsigned int count);
    
    /// To string.
    string toString();
protected:
    vector<PlayerModel *> _players;
    vector<DeckModel *> _decks;

    unsigned int _countTime;
    unsigned int _countTurn;
};

} // END namespace Discover

#endif // #ifndef __GameModel_H__