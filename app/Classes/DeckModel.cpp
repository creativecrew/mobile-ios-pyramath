#include "DeckModel.h"

using namespace Discover;

//------------------------------------------------------------------------------
DeckModel::DeckModel() {
    _id = 0;
    _cardIndexCurrent = 0;
    _visible = DECK_VISIBLE_BACKSIDE;
    
    _positionX = 0;
    _positionY = 0;
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
        _cards.push_back(new CardModel(i, "hello", count));
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
unsigned int DeckModel::getId() {
    return _id;
}
//------------------------------------------------------------------------------
int DeckModel::getDeckLength() {
    return _cards.size();
}
//------------------------------------------------------------------------------
float DeckModel::getPositionX() {
    return _positionX;
}
//------------------------------------------------------------------------------
float DeckModel::getPositionY() {
    return _positionY;
}
//------------------------------------------------------------------------------
DeckVisible DeckModel::getVisible() {
    return _visible;
}
//------------------------------------------------------------------------------
void DeckModel::removeCard(int index) {
    CardModel *card = _cards.at(index);
    _cards.erase(_cards.begin() + index);
    delete card;
}
//------------------------------------------------------------------------------
void DeckModel::setId(unsigned int id) {
    _id = id;
}
//------------------------------------------------------------------------------
void DeckModel::setPositionX(float x) {
    _positionX = x;
}
//------------------------------------------------------------------------------
void DeckModel::setPositionY(float y) {
    _positionY = y;
}
//------------------------------------------------------------------------------
void DeckModel::setVisible(DeckVisible visible) {
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
    return "Object:DeckModel Id:" + GenericModel::convertToString(_id) + "\n" + str;
}
//------------------------------------------------------------------------------