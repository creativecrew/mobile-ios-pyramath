#include "CardModel.h"

using namespace Discover;

//------------------------------------------------------------------------------
CardModel::CardModel() {
    _id = 0;
    _name = "";
    _value = 0;
    _visible = CARD_VISIBLE_CLOSED;
    _state = CARD_STATE_NEW;
}
//------------------------------------------------------------------------------
CardModel::CardModel(unsigned int id, string name, int value) {
    CardModel();
    _id = id;
    _name = name;
    _value = value;
}
//------------------------------------------------------------------------------
CardModel::~CardModel() {}
//------------------------------------------------------------------------------
unsigned int CardModel::getId() {
    return _id;
}
//------------------------------------------------------------------------------
string CardModel::getName() {
    return _name;
}
//------------------------------------------------------------------------------
int CardModel::getPositionX() {
    return _positionX;
}
//------------------------------------------------------------------------------
int CardModel::getPositionY() {
    return _positionY;
}
//------------------------------------------------------------------------------
CardState CardModel::getState() {
    return _state;
}
//------------------------------------------------------------------------------
CardVisible CardModel::getVisible() {
    return _visible;
}
//------------------------------------------------------------------------------
int CardModel::getValue() {
    return _value;
}
//------------------------------------------------------------------------------
void CardModel::setId(unsigned int id) {
    _id = id;
}
//------------------------------------------------------------------------------
void CardModel::setName(string name) {
    _name = name;
}
//------------------------------------------------------------------------------
void CardModel::setPositionX(int x) {
    _positionX = x;
}
//------------------------------------------------------------------------------
void CardModel::setPositionY(int y) {
    _positionY = y;
}
//------------------------------------------------------------------------------
void CardModel::setState(CardState state) {
    _state = state;
}
//------------------------------------------------------------------------------
void CardModel::setValue(int value) {
    _value = value;
}
//------------------------------------------------------------------------------
void CardModel::setVisible(CardVisible visible) {
    _visible = visible;
}
//------------------------------------------------------------------------------
string CardModel::toString() {
    return "Object:CardModel Id:" + GenericModel::convertToString(_id) + " Name:" + _name + " Value:" + GenericModel::convertToString(_value);
}
//------------------------------------------------------------------------------