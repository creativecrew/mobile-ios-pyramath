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

        _sio2WidgetBackground = sio2WidgetInit("background1");
        _sio2WidgetBackground->_SIO2material = _sio2MaterialBackground;
        _sio2WidgetBackground->_SIO2transform->scl->x = _sio2ImageBackground->width;
        _sio2WidgetBackground->_SIO2transform->scl->y = _sio2ImageBackground->height;
        _sio2WidgetBackground->_SIO2transform->loc->x  = 0.5;
        _sio2WidgetBackground->_SIO2transform->loc->y  = 0.5;

        // Precalculate the 2D position / scale / rotation matrix for the widget.
        sio2TransformBindMatrix(_sio2WidgetBackground->_SIO2transform);
    }
    
    // Clear graphics (depth and color buffer).
    glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
}
//------------------------------------------------------------------------------
void GameView::frameBegin() {
    // Render 2D widget.
    sio2WidgetRender(_sio2WidgetBackground, _sio2Window, 1);
    // Reset 2D widget rendering state.
    sio2WidgetReset();
    sio2MaterialReset();
    
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
//------------------------------------------------------------------------------
void GameView::frameEnd() {
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
//------------------------------------------------------------------------------