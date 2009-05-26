#include "GameController.h"

using namespace Discover;

//------------------------------------------------------------------------------
GameController::GameController() {
    _gameModel = new GameModel();
    _gameView = new GameView();
}
//------------------------------------------------------------------------------
GameController::~GameController() {
    delete _gameView;
    delete _gameModel;
}
//------------------------------------------------------------------------------
void GameController::setWindow(SIO2window *window) {
    _sio2Window = window;
}
//------------------------------------------------------------------------------
void GameController::load() {
    std::cout << std::endl << std::endl;
    std::cout << "hello word" << std::endl;
    
    DeckModel *deck1 = new DeckModel(52);
    deck1->shuffleDeck();
    
    _gameModel->addDeck(deck1);
    //std::cout << _gameModel->getDeck()->getCard(9)->toString() << std::endl;
    //std::cout << _gameModel->getDeck(0)->toString() << std::endl;
    
    _gameView->setWindow(_sio2Window);
    _gameView->load();
}
//------------------------------------------------------------------------------
void GameController::frameBegin() {
    _gameView->frameBegin();
}
//------------------------------------------------------------------------------
void GameController::frameEnd() {
    _gameView->frameEnd();
}
//------------------------------------------------------------------------------
string GameController::toString() {
    return "Object: GameController";
}
//------------------------------------------------------------------------------