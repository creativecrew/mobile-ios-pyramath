#include "CardView.h"

using namespace Discover;

//------------------------------------------------------------------------------
CardView::CardView() {
    _debug = false;
    _cardModel = NULL;
    
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
CardView::CardView(string filepath, string name, CardModel *model) {
    CardView();
    _filepath = filepath;
    _name = name;
    _cardModel = model;
}
//------------------------------------------------------------------------------
CardView::~CardView() {
    /*if(_sio2WidgetCard) {
        _sio2WidgetCard = sio2WidgetFree(_sio2WidgetCard);
        _sio2MaterialCard = sio2MaterialFree(_sio2MaterialCard);
        _sio2ImageCard = sio2ImageFree(_sio2ImageCard);
    }*/
}
//------------------------------------------------------------------------------
void CardView::setCardModel(CardModel *model) {
    _cardModel = model;
}
//------------------------------------------------------------------------------
void CardView::setDebug(bool debug) {
    _debug = debug;
}
//------------------------------------------------------------------------------
void CardView::setSimulationEngine(SIO2resource *resource, SIO2window *window) {
    _sio2Resource = resource;
    _sio2Window = window;
}
//------------------------------------------------------------------------------
void CardView::setCallbackTapDown(SIO2widgettapdown *fnName) {
    _sio2WidgetCard->userdata = _cardModel;
    _sio2WidgetCard->_SIO2widgettapdown = fnName;
}
//------------------------------------------------------------------------------
void CardView::setCallbackTapDown(SIO2widgettapdown *fnName, void *objData) {
    _sio2WidgetCard->userdata = objData;
    _sio2WidgetCard->_SIO2widgettapdown = fnName;
}
//------------------------------------------------------------------------------
string CardView::toString() {
    return "Object: CardView";
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
        _sio2MaterialCard->blend = SIO2_MATERIAL_COLOR;

        _sio2WidgetCard = sio2WidgetInit(GenericModel::convertToCharPointer(_name));
        _sio2WidgetCard->_SIO2material = _sio2MaterialCard;
        _sio2WidgetCard->_SIO2transform->scl->x = _sio2ImageCard->width;
        _sio2WidgetCard->_SIO2transform->scl->y = _sio2ImageCard->height;
        _sio2WidgetCard->_SIO2transform->loc->x = 0.0;
        _sio2WidgetCard->_SIO2transform->loc->y = 0.0;
        
        // Set event boundary.
        _sio2WidgetCard->area->x = _sio2ImageCard->width - 20.0;
        _sio2WidgetCard->area->y = _sio2ImageCard->height;
        
        // Enable the necessary widget states
        sio2EnableState(&_sio2WidgetCard->flags,
            SIO2_WIDGET_VISIBLE |
            SIO2_WIDGET_ENABLED
        );

        // Precalculate the 2D position / scale / rotation matrix for the widget.
        sio2TransformBindMatrix(_sio2WidgetCard->_SIO2transform);
    }
}
//------------------------------------------------------------------------------
void CardView::frameBegin() {
    if(_cardModel) {
        // Get and set positions.
        _sio2WidgetCard->_SIO2transform->loc->x = _cardModel->getPositionX();
        _sio2WidgetCard->_SIO2transform->loc->y = _cardModel->getPositionY();
        // Recalculate the new matrix.
        sio2TransformBindMatrix(_sio2WidgetCard->_SIO2transform);
    }
    
    // Render 2D widget.
    sio2WindowEnter2D(_sio2Window, 0.0, 1.0);
	{
    
    sio2WindowEnterLandscape2D(_sio2Window);
    {
        sio2WidgetRender(_sio2WidgetCard, _sio2Window, 1);
    }
    sio2WindowLeaveLandscape2D(_sio2Window);
    // Reset 2D widget rendering state.
    sio2WidgetReset();
    sio2MaterialReset();
    
    // Update widget's event boundary.
    sio2ResourceUpdateAllWidgetBoundaries(_sio2Resource, _sio2Window);
    
    // Debug.
    if(_debug == true) {
        // Display the "responsive" area of a widget.
        sio2WindowEnterLandscape2D(_sio2Window);
        {
            sio2WidgetDebug(_sio2WidgetCard);
        }
        sio2WindowLeaveLandscape2D(_sio2Window);
    }
        
    }
    sio2WindowLeave2D();
}
//------------------------------------------------------------------------------
void CardView::frameEnd() {
    sio2WindowEnter2D(_sio2Window, 0.0, 1.0);
	{
    }
    sio2WindowLeave2D();
}
//------------------------------------------------------------------------------