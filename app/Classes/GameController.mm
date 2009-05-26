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
    
    CardView *cardViews;
    while(!_cardViews.empty()) {
        // Get first element.
        cardViews = _cardViews.front();
        // Remove first element from vector.
        _cardViews.erase(_cardViews.begin());
        // Delete pointer of object.
        delete cardViews;
    }
    
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
    
    CardModel *card1 = new CardModel(1, "1", 1);
    card1->setPositionX(100);
    card1->setPositionY(370);
    
    CardModel *card2 = new CardModel(2, "1", 1);
    card2->setPositionX(160);
    card2->setPositionY(370);
    
    DeckModel *deck1 = new DeckModel();
    deck1->addCard(card1);
    deck1->addCard(card2);
    deck1->shuffleDeck();
    
    _gameModel->addDeck(deck1);
    //std::cout << _gameModel->getDeck()->getCard(9)->toString() << std::endl;
    std::cout << _gameModel->getDeck(0)->toString() << std::endl;
    
    _gameView->setWindow(_sio2Window);
    _gameView->load();
    
    CardView *cardView1 = new CardView("card1.png", "1", card1);
    cardView1->load();
    _cardViews.push_back(cardView1);
    
    CardView *cardView2 = new CardView("card1.png", "2", card2);
    cardView2->load();
    _cardViews.push_back(cardView2);
}
//------------------------------------------------------------------------------
void GameController::frameBegin() {
    // Render game.
    _gameView->frameBegin();
    
    // Render cards.
    for(int i = 0;i < _cardViews.size(); i++) {
        _cardViews.at(i)->frameBegin();
    }
}
//------------------------------------------------------------------------------
void GameController::frameEnd() {
    // Render cards.
    for(int i = 0;i < _cardViews.size(); i++) {
        _cardViews.at(i)->frameEnd();
    }
    
    // Render game.
    _gameView->frameEnd();
}
//------------------------------------------------------------------------------
string GameController::toString() {
    return "Object: GameController";
}
//------------------------------------------------------------------------------