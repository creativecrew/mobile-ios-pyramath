#include "DeckView.h"

using namespace Discover;

//------------------------------------------------------------------------------
DeckView::DeckView() {
    _debug = false;
    _deckModel = NULL;

    _sio2WidgetDeck = NULL;
    _sio2ImageDeck = NULL;
    _sio2MaterialDeck = NULL;
}
//------------------------------------------------------------------------------
DeckView::DeckView(string filepath, string name, DeckModel *model) {
    DeckView();
    _filepath = filepath;
    _name = name;
    _deckModel = model;
}
//------------------------------------------------------------------------------
DeckView::~DeckView() {
    /*if(_sio2WidgetDeck) {
        _sio2WidgetDeck = sio2WidgetFree(_sio2WidgetDeck);
        _sio2MaterialDeck = sio2MaterialFree(_sio2MaterialDeck);
        _sio2ImageDeck = sio2ImageFree(_sio2ImageDeck);
    }*/
}
//------------------------------------------------------------------------------
void DeckView::setDebug(bool debug) {
    _debug = debug;
}
//------------------------------------------------------------------------------
void DeckView::setDeckModel(DeckModel *model) {
    _deckModel = model;
}
//------------------------------------------------------------------------------
void DeckView::setCallbackTapDown(SIO2widgettapdown *fnName) {
    _sio2WidgetDeck->userdata = _deckModel;
    _sio2WidgetDeck->_SIO2widgettapdown = fnName;
}
//------------------------------------------------------------------------------
void DeckView::setCallbackTapDown(SIO2widgettapdown *fnName, void *objData) {
    _sio2WidgetDeck->userdata = objData;
    _sio2WidgetDeck->_SIO2widgettapdown = fnName;
}
//------------------------------------------------------------------------------
void DeckView::setSimulationEngine(SIO2resource *resource, SIO2window *window) {
    _sio2Resource = resource;
    _sio2Window = window;
}
//------------------------------------------------------------------------------
string DeckView::toString() {
    return "Object: DeckView";
}
//------------------------------------------------------------------------------
void DeckView::load() {
    SIO2stream *sio2Stream;
    
    sio2Stream = sio2StreamOpen(GenericModel::convertToCharPointer(_filepath), 1);
    if(sio2Stream) {
        _sio2ImageDeck = sio2ImageInit(GenericModel::convertToCharPointer(_name));
        sio2ImageLoad(_sio2ImageDeck, sio2Stream);
        sio2ImageGenId(_sio2ImageDeck, 0, 0.0);
        sio2Stream = sio2StreamClose(sio2Stream);

        _sio2MaterialDeck = sio2MaterialInit(GenericModel::convertToCharPointer(_name));
        _sio2MaterialDeck->_SIO2image[SIO2_MATERIAL_CHANNEL0] = _sio2ImageDeck;
        _sio2MaterialDeck->blend = SIO2_MATERIAL_COLOR;

        _sio2WidgetDeck = sio2WidgetInit(GenericModel::convertToCharPointer(_name));
        _sio2WidgetDeck->_SIO2material = _sio2MaterialDeck;
        _sio2WidgetDeck->_SIO2transform->scl->x = _sio2ImageDeck->width;
        _sio2WidgetDeck->_SIO2transform->scl->y = _sio2ImageDeck->height;
        _sio2WidgetDeck->_SIO2transform->loc->x = 0.0;
        _sio2WidgetDeck->_SIO2transform->loc->y = 0.0;

        // Set event boundary.
        _sio2WidgetDeck->area->x = _sio2ImageDeck->width - 20.0;
        _sio2WidgetDeck->area->y = _sio2ImageDeck->height;
        
        // Enable the necessary widget states
        sio2EnableState(&_sio2WidgetDeck->flags,
            SIO2_WIDGET_VISIBLE |
            SIO2_WIDGET_ENABLED
        );

        // Precalculate the 2D position / scale / rotation matrix for the widget.
        sio2TransformBindMatrix(_sio2WidgetDeck->_SIO2transform);
    }
}
//------------------------------------------------------------------------------
void DeckView::frameBegin() {
    if(_deckModel) {
        // Get and set positions.
        _sio2WidgetDeck->_SIO2transform->loc->x = _deckModel->getPositionX();
        _sio2WidgetDeck->_SIO2transform->loc->y = _deckModel->getPositionY();
        // Recalculate the new matrix.
        sio2TransformBindMatrix(_sio2WidgetDeck->_SIO2transform);
    }
    
    // Render 2D widget.
    sio2WidgetRender(_sio2WidgetDeck, _sio2Window, 0);
    // Reset 2D widget rendering state.
    sio2WidgetReset();
    sio2MaterialReset();
}
//------------------------------------------------------------------------------
void DeckView::frameEnd() {
    
}
//------------------------------------------------------------------------------