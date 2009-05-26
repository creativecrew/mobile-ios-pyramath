#include "DeckModel.h"

using namespace Discover;

//------------------------------------------------------------------------------
DeckModel::DeckModel() {
    _cardIndexCurrent = 0;
    _visible = true;
}
//------------------------------------------------------------------------------
DeckModel::DeckModel(int length) {
    DeckModel();
    if(length <= 0) {
        length = DECK_CARDS_MAX;
    }
    // Create an object for each pointer.
    int count = 1;
    for(int i = 0;i < length;i++) {
        _cards.push_back(new CardModel("hello", count));
        if(count >= 10) {
            count = 1;
        } else {
            count++;
        }
    }
}
//------------------------------------------------------------------------------
DeckModel::~DeckModel() {
    CardModel *card;
    while(!_cards.empty()) {
        // Get first element.
        card = _cards.front();
        // Remove first element from vector.
        _cards.erase(_cards.begin());
        // Delete pointer of object.
        delete card;
    }
}
//------------------------------------------------------------------------------
void DeckModel::addCard(CardModel *card) {
    _cards.push_back(card);
}
//------------------------------------------------------------------------------
CardModel * DeckModel::getCard(int index) {
    return _cards.at(index);
}
//------------------------------------------------------------------------------
int DeckModel::getDeckLength() {
    return _cards.size();
}
//------------------------------------------------------------------------------
int DeckModel::getPositionX() {
    return _positionX;
}
//------------------------------------------------------------------------------
int DeckModel::getPositionY() {
    return _positionY;
}
//------------------------------------------------------------------------------
bool DeckModel::getVisible() {
    return _visible;
}
//------------------------------------------------------------------------------
void DeckModel::removeCard(int index) {
    CardModel *card = _cards.at(index);
    _cards.erase(_cards.begin() + index);
    delete card;
}
//------------------------------------------------------------------------------
void DeckModel::setPositionX(int x) {
    _positionX = x;
}
//------------------------------------------------------------------------------
void DeckModel::setPositionY(int y) {
    _positionY = y;
}
//------------------------------------------------------------------------------
void DeckModel::setVisible(bool visible) {
    _visible = visible;
}
//------------------------------------------------------------------------------
void DeckModel::shuffleDeck() {
    // Init seed randomly for rand() function.
    srand(unsigned(time(NULL)));
    // Shuffle.
    random_shuffle(_cards.begin(), _cards.end());
}
//------------------------------------------------------------------------------
string DeckModel::toString() {
    string str = "";
    for(int i = 0;i < _cards.size(); i++) {
        str += _cards.at(i)->toString() + "\n";
    }
    return "Object:DeckModel \n" + str;
}
//------------------------------------------------------------------------------