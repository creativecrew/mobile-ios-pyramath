#include "GameController.h"

using namespace Discover;

//------------------------------------------------------------------------------
GameController::GameController() {
    _hasResource = 0;
    
    _sio2Base = NULL;
    _sio2Window = NULL;
    _sio2Resource = NULL;
    _sio2Camera = NULL;
    
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
void GameController::setSimulationEngine(SIO2 *sio2Base) {
    _sio2Window = sio2Base->_SIO2window;
    _sio2Resource = sio2Base->_SIO2resource;
    _sio2Camera = sio2Base->_SIO2camera;
    
    _sio2Base = sio2Base;
}
//------------------------------------------------------------------------------
string GameController::toString() {
    return "Object: GameController";
}
//------------------------------------------------------------------------------
bool GameController::load() {
    std::cout << std::endl << std::endl;
    std::cout << "hello word" << std::endl;
    
    // Create camera.
    _sio2Camera = sio2CameraInit("default");

    // Set camera perspective.
    sio2Perspective(_sio2Camera->fov, _sio2Window->scl->x / _sio2Window->scl->y, _sio2Camera->cstart, _sio2Camera->cend);

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
    //std::cout << _gameModel->getDeck(0)->toString() << std::endl;
    
    _gameView->setSimulationEngine(_sio2Resource, _sio2Window);
    _gameView->load();
    _gameView->setDebug(false);
/*
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
*/
    
    // Set world background color.
    glClearColor(0.3, 0.3, 0.3, 1.0);
    
    return true;
}
//------------------------------------------------------------------------------
void GameController::frameBegin() {
    // Set which matrix stack is the target for subsequent matrix operations.
    glMatrixMode(GL_MODELVIEW);
    // Reset transformations to origin.
    glLoadIdentity();
    // Clear buffers to preset values.
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
/*
    // Render card views.
    for(int i = 0;i < _cardViews.size(); i++) {
        _cardViews.at(i)->frameBegin();
    }
*/

    static GLfloat rot = 0.0;
    
    const GLfloat squareVertices1[] = {
        -1.0, -1.0, 0.0, // Bottom-left.
        1.0, -1.0, 0.0, // Bottom-right.
        -1.0, 1.0, 0.0, // Top-left.
        1.0, 1.0, 0.0 // Top-right.
    };
    
    const GLubyte squareColors[] = {
        255, 255, 0, 255,
        0, 255, 255, 255,
        0, 0, 0, 0,
        255, 0, 255, 255
    };
    
    glPushMatrix();
    {
        glTranslatef(0.0, 0.0, -10.0);
        glRotatef(rot, 0.0, 1.0, 0.0);

        // Start state.
        glEnableClientState(GL_VERTEX_ARRAY);
        glEnableClientState(GL_COLOR_ARRAY);
        glEnable(GL_TEXTURE_2D);

        glVertexPointer(3, GL_FLOAT, 0, squareVertices1);
        glColorPointer(4, GL_UNSIGNED_BYTE, 0, squareColors);
        
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        
        // End state.
        glDisable(GL_TEXTURE_2D);
        glDisableClientState(GL_COLOR_ARRAY);
        //glDisableClientState(GL_VERTEX_ARRAY);
    }
    glPopMatrix();
    
    const GLfloat cubeVertices[] = {
        // Front.
        -0.5, -0.5, 0.5,
        0.5, -0.5, 0.5,
        -0.5, 0.5, 0.5,
        0.5, 0.5, 0.5,
        // Back.
        -0.5, -0.5, -0.5,
        -0.5, 0.5, -0.5,
        0.5, -0.5, -0.5,
        0.5, 0.5, -0.5,
        // Left.
        -0.5, -0.5, 0.5,
        -0.5, 0.5, 0.5,
        -0.5, -0.5, -0.5,
        -0.5, 0.5, -0.5,
        // Right.
        0.5, -0.5, -0.5,
        0.5, 0.5, -0.5,
        0.5, -0.5, 0.5,
        0.5, 0.5, 0.5,
        // Top.
        -0.5, 0.5, 0.5,
        0.5, 0.5, 0.5,
        -0.5, 0.5, -0.5,
        0.5, 0.5, -0.5,
        // Bottom.
        -0.5, -0.5, 0.5,
        -0.5, -0.5, -0.5,
        0.5, -0.5, 0.5,
        0.5, -0.5, -0.5
    };
    
    const GLfloat cubeColors[] = {
        // Front.
        0.0, 0.0, 1.0, 0.0,
        1.0, 0.0, 0.0, 0.0,
        1.0, 0.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        // Back.
        1.0, 0.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        1.0, 0.0, 0.0, 0.0,
        // Left.
        0.0, 0.0, 1.0, 0.0,
        1.0, 0.0, 0.0, 0.0,
        1.0, 0.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        // Right.
        0.0, 0.0, 1.0, 0.0,
        1.0, 0.0, 0.0, 0.0,
        1.0, 0.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        // Top.
        1.0, 0.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        1.0, 0.0, 0.0, 0.0,
        // Bottom.
        0.0, 0.0, 1.0, 0.0,
        1.0, 0.0, 0.0, 0.0,
        1.0, 0.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0
    };
    
    glPushMatrix();
    {
        glTranslatef(0.0, 3.0, -10.0);
        glRotatef(rot, 1.0, 1.0, 1.0);
        
        glEnableClientState(GL_VERTEX_ARRAY);
        glEnableClientState(GL_COLOR_ARRAY);
        
        glVertexPointer(3, GL_FLOAT, 0, cubeVertices);
        glColorPointer(4, GL_FLOAT, 0, cubeColors);

        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        glDrawArrays(GL_TRIANGLE_STRIP, 4, 4);

        glDrawArrays(GL_TRIANGLE_STRIP, 8, 4);
        glDrawArrays(GL_TRIANGLE_STRIP, 12, 4);

        glDrawArrays(GL_TRIANGLE_STRIP, 16, 4);
        glDrawArrays(GL_TRIANGLE_STRIP, 20, 4); 
        
        glDisableClientState(GL_COLOR_ARRAY);
        //glDisableClientState(GL_VERTEX_ARRAY);
    }
    glPopMatrix();

    const GLfloat vertices[]= {
        0, -0.525731, 0.850651,
        0.850651, 0, 0.525731,
        0.850651, 0, -0.525731,
        -0.850651, 0, -0.525731,
        -0.850651, 0, 0.525731,
        -0.525731, 0.850651, 0,
        0.525731, 0.850651, 0,
        0.525731, -0.850651, 0,
        -0.525731, -0.850651, 0,
        0, -0.525731, -0.850651,
        0, 0.525731, -0.850651,
        0, 0.525731, 0.850651
    };
    
    const GLfloat colors[] = {
        1.0, 0.0, 0.0, 1.0,
        1.0, 0.5, 0.0, 1.0,
        1.0, 1.0, 0.0, 1.0,
        0.5, 1.0, 0.0, 1.0,
        0.0, 1.0, 0.0, 1.0,
        0.0, 1.0, 0.5, 1.0,
        0.0, 1.0, 1.0, 1.0,
        0.0, 0.5, 1.0, 1.0,
        0.0, 0.0, 1.0, 1.0,
        0.5, 0.0, 1.0, 1.0,
        1.0, 0.0, 1.0, 1.0,
        1.0, 0.0, 0.5, 1.0
    };
    
    static const GLubyte icosahedronFaces[] = {
        1, 2, 6,
        1, 7, 2,
        3, 4, 5,
        4, 3, 8,
        6, 5, 11,
        5, 6, 10,
        9, 10, 2,
        10, 9, 3,
        7, 8, 9,
        8, 7, 0,
        11, 0, 1,
        0, 11, 4,
        6, 2, 10,
        1, 6, 11,
        3, 5, 10,
        5, 4, 11,
        2, 7, 9,
        7, 1, 0,
        3, 9, 8,
        4, 8, 0,
    };
    
    glPushMatrix();
    {
        glTranslatef(0.0, -3.0, -10.0);
        glRotatef(rot, 1.0, 1.0, 1.0);
        
        glEnableClientState(GL_VERTEX_ARRAY);
        glEnableClientState(GL_COLOR_ARRAY);
        
        glVertexPointer(3, GL_FLOAT, 0, vertices);
        glColorPointer(4, GL_FLOAT, 0, colors);

        glDrawElements(GL_TRIANGLES, 60, GL_UNSIGNED_BYTE, icosahedronFaces);

        glDisableClientState(GL_COLOR_ARRAY);
        //glDisableClientState(GL_VERTEX_ARRAY);
    }
    glPopMatrix();
    
    // Update the rotation speed based on the
    // current application delta time.
    rot += 20.0 * _sio2Base->_SIO2window->d_time;
    
    // Render game view.
    _gameView->frameBegin();
}
//------------------------------------------------------------------------------
void GameController::frameEnd() {
    /*
    // Set camera transformation.
    vec3 positionTarget = {0.0, 0.0, 0.0};
    vec3 upVector = {0.0, 0.0, 0.0};
    sio2LookAt(_sio2Base->_SIO2camera->_SIO2transform->loc, &positionTarget, &upVector);
    
    // Render to camera.
    sio2CameraRender(_sio2Base->_SIO2camera);
    // Update frustum of camera based on the current projection and GL_MODELVIEW matrix.
    sio2CameraUpdateFrustum(_sio2Base->_SIO2camera);
    */

    // Render game view.
    _gameView->frameEnd();
/*
    // Render card views.
    for(int i = 0;i < _cardViews.size(); i++) {
        _cardViews.at(i)->frameEnd();
    }
*/
}
//------------------------------------------------------------------------------
void GameController::onCardTapDown(void *obj1, void *obj2, vec2 *position) {
    std::cout << "Event: Card Tap Down, X:" << position->x << " Y:" << position->y << std::endl;

    //SIO2widget *sio2Widget = (SIO2widget *)obj1;
}
//------------------------------------------------------------------------------