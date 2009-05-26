#include "DeckView.h"

using namespace Discover;

//------------------------------------------------------------------------------
DeckView::DeckView() {
    _sio2WidgetDeck = NULL;
    _sio2ImageDeck = NULL;
    _sio2MaterialDeck = NULL;
}
//------------------------------------------------------------------------------
DeckView::DeckView(string filepath, string name) {
    DeckView();
    _filepath = filepath;
    _name = name;
}
//------------------------------------------------------------------------------
DeckView::~DeckView() {
    if(_sio2WidgetDeck) {
        _sio2WidgetDeck = sio2WidgetFree(_sio2WidgetDeck);
        _sio2MaterialDeck = sio2MaterialFree(_sio2MaterialDeck);
        _sio2ImageDeck = sio2ImageFree(_sio2ImageDeck);
    }
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
        _sio2MaterialDeck->blend = SIO2_MATERIAL_ALPHA;

        _sio2WidgetDeck = sio2WidgetInit(GenericModel::convertToCharPointer(_name));
        _sio2WidgetDeck->_SIO2material = _sio2MaterialDeck;
        _sio2WidgetDeck->_SIO2transform->scl->x = _sio2ImageDeck->width;
        _sio2WidgetDeck->_SIO2transform->scl->y = _sio2ImageDeck->height;

        // Enable the necessary widget states
        sio2EnableState(&_sio2WidgetDeck->flags,
            SIO2_WIDGET_VISIBLE
        );
        // Precalculate the 2D position / scale / rotation matrix for the widget.
        sio2TransformBindMatrix(_sio2WidgetDeck->_SIO2transform);
    }
}
//------------------------------------------------------------------------------
void DeckView::frameBegin() {
    sio2WidgetRender(_sio2WidgetDeck, _sio2Window, 0);
}
//------------------------------------------------------------------------------
void DeckView::frameEnd() {
    
}
//------------------------------------------------------------------------------
void DeckView::setWindow(SIO2window *window) {
    _sio2Window = window;
}
//------------------------------------------------------------------------------
string DeckView::toString() {
    return "Object: DeckView";
}
//------------------------------------------------------------------------------