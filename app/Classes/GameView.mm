#include "GameView.h"

using namespace Discover;

//------------------------------------------------------------------------------
GameView::GameView() {
    _debug = false;
    
    _sio2Font = NULL;
    _sio2ImageFont = NULL;
    _sio2MaterialFont = NULL;
    
    _sio2WidgetBackground = NULL;
    _sio2ImageBackground = NULL;
    _sio2MaterialBackground = NULL;
}
//------------------------------------------------------------------------------
GameView::~GameView() {
    /*if(_sio2WidgetBackground) {
        _sio2MaterialBackground = sio2MaterialFree(_sio2MaterialBackground);
        _sio2ImageBackground = sio2ImageFree(_sio2ImageBackground);
        _sio2WidgetBackground = sio2WidgetFree(_sio2WidgetBackground);
    }*/
}
//------------------------------------------------------------------------------
void GameView::setDebug(bool debug) {
    _debug = debug;
}
//------------------------------------------------------------------------------
void GameView::setSimulationEngine(SIO2resource *resource, SIO2window *window) {
    _sio2Resource = resource;
    _sio2Window = window;
}
//------------------------------------------------------------------------------
string GameView::toString() {
    return "Object: GameView";
}
//------------------------------------------------------------------------------
void GameView::load() {
    SIO2stream *sio2Stream;
    
    sio2Stream = sio2StreamOpen("default16x16.tga", 1);
    if(sio2Stream) {
        _sio2ImageFont = sio2ImageInit("default16x16");
        sio2ImageLoad(_sio2ImageFont, sio2Stream);
        sio2ImageGenId(_sio2ImageFont, NULL, 0.0);
        sio2Stream = sio2StreamClose(sio2Stream);
        
        _sio2MaterialFont = sio2MaterialInit("default16x16");
        _sio2MaterialFont->_SIO2image[SIO2_MATERIAL_CHANNEL0] = _sio2ImageFont;
        _sio2MaterialFont->blend = SIO2_MATERIAL_COLOR;
        
        _sio2Font = sio2FontInit("default16x16");
        _sio2Font->_SIO2material = _sio2MaterialFont;
        _sio2Font->n_char = 16;
        _sio2Font->size = 16.0;
        _sio2Font->space = 8.0;
        
        // Build font and store in the fast graphics memory.
        sio2FontBuild(_sio2Font);
    }
    
    sio2Stream = sio2StreamOpen("background1.png", 1);
    if(sio2Stream) {
        _sio2ImageBackground = sio2ImageInit("background1");
        sio2ImageLoad(_sio2ImageBackground, sio2Stream);
        sio2ImageGenId(_sio2ImageBackground, NULL, 0.0);
        sio2Stream = sio2StreamClose(sio2Stream);

        _sio2MaterialBackground = sio2MaterialInit("background1");
        _sio2MaterialBackground->_SIO2image[SIO2_MATERIAL_CHANNEL0] = _sio2ImageBackground;
        _sio2MaterialBackground->blend = SIO2_MATERIAL_COLOR;
    }
}
//------------------------------------------------------------------------------
void GameView::frameBegin() {
    // Vertice Array: X, Y, Z
    const GLfloat squareVertices[] = {
        -3.0, -4.0, 0.0, // Bottom-left.
        3.0, -4.0, 0.0, // Bottom-right.
        -3.0, 4.0, 0.0, // Top-left.
        3.0, 4.0, 0.0 // Top-right.
    };
    
    // Texture Coordinates Array: X, Y
    const GLfloat squareTextureCoordinates[] = {
        0.0, 1.0, // Top-left.
        1.0, 1.0, // Top-right.
        0.0, 0.0, // Bottom-left.
        1.0, 0.0  // Bottom-right.
    };
    
    // Render square.
    glPushMatrix();
    {
         glTranslatef(0.0, 0.0, -20.0);
        
        // Start state.
        glEnableClientState(GL_VERTEX_ARRAY);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        glEnable(GL_TEXTURE_2D);
        
        glBindTexture(GL_TEXTURE_2D, _sio2ImageBackground->tid);
        glTexCoordPointer(2, GL_FLOAT, 0, squareTextureCoordinates);
        glVertexPointer(3, GL_FLOAT, 0, squareVertices);
        
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        
        // End state.
        glDisable(GL_TEXTURE_2D);
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
        //glDisableClientState(GL_VERTEX_ARRAY);
    }
    glPopMatrix();

    sio2WindowEnter2D(_sio2Window, 0.0, 1.0);
	{
        // Debug.
        if(_debug == true) {
            // Show debug information for touch.
            vec2 pos;
            pos.x = 8.0;
            pos.y = 8.0;
            _sio2Font->_SIO2material->diffuse->x = 1.0;
            _sio2Font->_SIO2material->diffuse->y = 0.0;
            _sio2Font->_SIO2material->diffuse->z = 0.0;
            _sio2Font->_SIO2material->diffuse->w = 1.0;
            if(_sio2Window->n_touch) {
                unsigned int i = 0;
                while(i != _sio2Window->n_touch) {
                    _sio2Font->_SIO2transform->loc->x = pos.x;
                    _sio2Font->_SIO2transform->loc->y = pos.y;
                    // Switch X and Y coordinates for portrait window.
                    //sio2FontPrint(_sio2Font, &pos, "Touch #%d X:%.0f Y:%.0f", i, _sio2Window->touch[i]->y, GenericModel::flipCoordinateX(_sio2Window->touch[i].x));
                    // Default.
                    sio2FontPrint(_sio2Font, SIO2_TRANSFORM_MATRIX_APPLY, "Touch #%d X:%.0f Y:%.0f", i, _sio2Window->touch[i]->x, _sio2Window->touch[i]->y);
                    pos.y += 16.0;
                    ++i;
                }
                sio2MaterialReset();
            }
            sio2FontReset();
            sio2MaterialReset();
        }
    }
    sio2WindowLeave2D();
}
//------------------------------------------------------------------------------
void GameView::frameEnd() {
    sio2WindowEnter2D(_sio2Window, 0.0, 1.0);
	{
        sio2WindowEnterLandscape2D(_sio2Window);
        {
            // Debug.
            if(_debug == true) {
                // Show debug point for touch.
                sio2ObjectReset();
                sio2WindowDebugTouch(_sio2Window);
            }
        }
        sio2WindowLeaveLandscape2D(_sio2Window);
    }
    sio2WindowLeave2D();
}
//------------------------------------------------------------------------------