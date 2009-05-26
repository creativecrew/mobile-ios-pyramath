#include "PlayerModel.h"

using namespace Discover;

//------------------------------------------------------------------------------
PlayerModel::PlayerModel() {
    _id = 0;
    _name = "";
}
//------------------------------------------------------------------------------
PlayerModel::PlayerModel(unsigned int id, string name) {
    _id = id;
    _name = name;
}
//------------------------------------------------------------------------------
PlayerModel::~PlayerModel() {}
//------------------------------------------------------------------------------
unsigned int PlayerModel::getId() {
    return _id;
}
//------------------------------------------------------------------------------
string PlayerModel::getName() {
    return _name;
}
//------------------------------------------------------------------------------
int PlayerModel::getScore() {
    return _score;
}
//------------------------------------------------------------------------------
void PlayerModel::setId(unsigned int id) {
    _id = id;
}
//------------------------------------------------------------------------------
void PlayerModel::setName(string name) {
    _name = name;
}
//------------------------------------------------------------------------------
void PlayerModel::setScore(int score) {
    _score = score;
}
//------------------------------------------------------------------------------
string PlayerModel::toString() {
    return "Object: PlayerModel Id:" + GenericModel::convertToString(_id);
}
//------------------------------------------------------------------------------