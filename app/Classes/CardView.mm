#include "CardView.h"

using namespace Discover;

//------------------------------------------------------------------------------
CardView::CardView() {
    _sio2WidgetCard = NULL;
    _sio2ImageCard = NULL;
    _sio2MaterialCard = NULL;
}
//------------------------------------------------------------------------------
CardView::CardView(string filepath, string name) {
    CardView();
    _filepath = filepath;
    _name = name;
}
//------------------------------------------------------------------------------
CardView::~CardView() {
    if(_sio2WidgetCard) {
        _sio2WidgetCard = sio2WidgetFree(_sio2WidgetCard);
        _sio2MaterialCard = sio2MaterialFree(_sio2MaterialCard);
        _sio2ImageCard = sio2ImageFree(_sio2ImageCard);
    }
}
//------------------------------------------------------------------------------
void CardView::load() {
    SIO2stream *sio2Stream;
    
    sio2Stream = sio2StreamOpen(GenericModel::convertToCharPointer(_filepath), 1);
    if(sio2Stream) {
        _sio2ImageCard = sio2ImageInit(GenericModel::convertToCharPointer(_name));
        sio2ImageLoad(_sio2ImageCard, sio2Stream);
        sio2ImageGenId(_sio2ImageCard, 0, 0.0);
        sio2Stream = sio2StreamClose(sio2Stream);

        _sio2MaterialCard = sio2MaterialInit(GenericModel::convertToCharPointer(_name));
        _sio2MaterialCard->_SIO2image[SIO2_MATERIAL_CHANNEL0] = _sio2ImageCard;
        _sio2MaterialCard->blend = SIO2_MATERIAL_ALPHA;

        _sio2WidgetCard = sio2WidgetInit(GenericModel::convertToCharPointer(_name));
        _sio2WidgetCard->_SIO2material = _sio2MaterialCard;
        _sio2WidgetCard->_SIO2transform->scl->x = _sio2ImageCard->width;
        _sio2WidgetCard->_SIO2transform->scl->y = _sio2ImageCard->height;

        // Enable the necessary widget states
        sio2EnableState(&_sio2WidgetCard->flags,
            SIO2_WIDGET_VISIBLE
        );
        // Precalculate the 2D position / scale / rotation matrix for the widget.
        sio2TransformBindMatrix(_sio2WidgetCard->_SIO2transform);
    }
}
//------------------------------------------------------------------------------
void CardView::frameBegin() {
    sio2WidgetRender(_sio2WidgetCard, _sio2Window, 0);
}
//------------------------------------------------------------------------------
void CardView::frameEnd() {
    
}
//------------------------------------------------------------------------------
void CardView::setWindow(SIO2window *window) {
    _sio2Window = window;
}
//------------------------------------------------------------------------------
string CardView::toString() {
    return "Object: CardView";
}
//------------------------------------------------------------------------------