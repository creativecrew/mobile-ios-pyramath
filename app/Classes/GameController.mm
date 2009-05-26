#include "GameController.h"

using namespace Discover;

//------------------------------------------------------------------------------
GameController::GameController() {}
//------------------------------------------------------------------------------
GameController::~GameController() {}
//------------------------------------------------------------------------------
void GameController::createDeck() {
    _deck = new DeckModel(52);
}
//------------------------------------------------------------------------------
DeckModel * GameController::getDeck() {
    return _deck;
}
//------------------------------------------------------------------------------
string GameController::toString() {
    return "Object: GameController";
}
//------------------------------------------------------------------------------