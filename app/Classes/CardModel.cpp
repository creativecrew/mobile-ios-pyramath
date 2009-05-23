#include "CardModel.h"

using namespace Discover;

//------------------------------------------------------------------------------
CardModel::CardModel() {
    _name = "";
    _value = 0;
    _visible = true;
    _state = CARD_STATE_NEW;
}
//------------------------------------------------------------------------------
CardModel::CardModel(string name, int value) {
    _name = name;
    _value = value;
}
//------------------------------------------------------------------------------
CardModel::~CardModel() {}
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
bool CardModel::getVisible() {
    return _visible;
}
//------------------------------------------------------------------------------
int CardModel::getValue() {
    return _value;
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
void CardModel::setVisible(bool visible) {
    _visible = visible;
}
//------------------------------------------------------------------------------
string CardModel::toString() {
    return "Object:CardModel Name:" + _name + " Value:" + GenericModel::convertToString(_value);
}
//------------------------------------------------------------------------------