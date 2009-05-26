#include "GameModel.h"

using namespace Discover;

//------------------------------------------------------------------------------
GameModel::GameModel() {
    _countTime = 0;
    _countTurn = 0;
}
//------------------------------------------------------------------------------
GameModel::~GameModel() {}
//------------------------------------------------------------------------------
void GameModel::addDeck(DeckModel *deck) {
    _decks.push_back(deck);
}
//------------------------------------------------------------------------------
void GameModel::addPlayer(PlayerModel *player) {
    _players.push_back(player);
}
//------------------------------------------------------------------------------
int GameModel::getDecksLength() {
    return _decks.size();
}
//------------------------------------------------------------------------------
int GameModel::getPlayersLength() {
    return _players.size();
}
//------------------------------------------------------------------------------
unsigned int GameModel::getCountTime() {
    return _countTime;
}
//------------------------------------------------------------------------------
unsigned int GameModel::getCountTurn() {
    return _countTurn;
}
//------------------------------------------------------------------------------
PlayerModel * GameModel::getPlayer(int index) {
    return _players.at(index);
}
//------------------------------------------------------------------------------
DeckModel * GameModel::getDeck(int index) {
    return _decks.at(index);
}
//------------------------------------------------------------------------------
void GameModel::removePlayer(int index) {
    PlayerModel *player = _players.at(index);
    _players.erase(_players.begin() + index);
    delete player;
}
//------------------------------------------------------------------------------
void GameModel::removeDeck(int index) {
    DeckModel *deck = _decks.at(index);
    _decks.erase(_decks.begin() + index);
    delete deck;
}
//------------------------------------------------------------------------------
void GameModel::setCountTime(unsigned int count) {
    _countTime = count;
}
//------------------------------------------------------------------------------
void GameModel::setCountTurn(unsigned int count) {
    _countTurn = count;
}
//------------------------------------------------------------------------------
string GameModel::toString() {
    return "Object:GameModel";
}
//------------------------------------------------------------------------------