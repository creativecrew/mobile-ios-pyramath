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
void GameController::setSimulationEngine(SIO2resource *resource, SIO2window *window) {
    _sio2Resource = resource;
    _sio2Window = window;
}
//------------------------------------------------------------------------------
string GameController::toString() {
    return "Object: GameController";
}
//------------------------------------------------------------------------------
void GameController::load() {
    std::cout << std::endl << std::endl;
    std::cout << "hello word" << std::endl;
    
    CardModel *card1 = new CardModel(1, "1", 1);
    card1->setPositionX(100);
    card1->setPositionY(200);
    
    CardModel *card2 = new CardModel(2, "1", 1);
    card2->setPositionX(0);
    card2->setPositionY(0);
    
    DeckModel *deck1 = new DeckModel();
    deck1->addCard(card1);
    deck1->addCard(card2);
    deck1->shuffleDeck();
    
    _gameModel->addDeck(deck1);
    //std::cout << _gameModel->getDeck()->getCard(9)->toString() << std::endl;
    std::cout << _gameModel->getDeck(0)->toString() << std::endl;
    
    _gameView->setSimulationEngine(_sio2Resource, _sio2Window);
    _gameView->load();
    _gameView->setDebug(true);
    
    //_sio2WidgetCallbackCardTapDown = onCardTapDown;
    
    CardView *cardView1 = new CardView("card1.png", "1", card1);
    cardView1->setSimulationEngine(_sio2Resource, _sio2Window);
    cardView1->load();
    _cardViews.push_back(cardView1);
    
    CardView *cardView2 = new CardView("card1.png", "2", card2);
    cardView2->setSimulationEngine(_sio2Resource, _sio2Window);
    cardView2->load();
    cardView2->setCallbackTapDown(onCardTapDown);
    cardView2->setDebug(false);
    _cardViews.push_back(cardView2);
}
//------------------------------------------------------------------------------
void GameController::frameBegin() {
    // Vertex Array: X, Y, Z
    /*const GLfloat squareVertices[] = {
    100.0, 100.0, 0.0,
    200.0, 100.0, 0.0,
    100.0, 200.0, 0.0,
    200.0, 200.0, 0.0
    };*/
    
    // 2D Graphics.
    sio2WindowEnter2D(_sio2Window, 0.0, 1.0);
	{
        // Render game.
        _gameView->frameBegin();
        
        // Render cards.
        for(int i = 0;i < _cardViews.size(); i++) {
            _cardViews.at(i)->frameBegin();
        }
        
        /*glVertexPointer(3, GL_FLOAT, 0, squareVertices);
        glEnableClientState(GL_VERTEX_ARRAY);

        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);*/
    }
    sio2WindowLeave2D();
}
//------------------------------------------------------------------------------
void GameController::frameEnd() {
    // 2D Graphics.
    sio2WindowEnter2D(_sio2Window, 0.0, 1.0);
	{
        // Render cards.
        for(int i = 0;i < _cardViews.size(); i++) {
            _cardViews.at(i)->frameEnd();
        }
        
        // Render game.
        _gameView->frameEnd();
    }
    sio2WindowLeave2D();
}
//------------------------------------------------------------------------------
void GameController::onCardTapDown(void *obj1, void *obj2, vec2 *position) {
    std::cout << "Event: Card Tap Down, X:" << position->x << " Y:" << position->y << std::endl;

    //SIO2widget *sio2Widget = (SIO2widget *)obj1;
}
//------------------------------------------------------------------------------