/*
 *  template.mm
 *  template
 *
 *  Created by SIO2 Interactive on 8/22/08.
 *  Copyright 2008 SIO2 Interactive. All rights reserved.
 *
 */

#include<iostream>
#include "template.h"

#include "../src/sio2/sio2.h"

#include "GameController.h"

//#define SHOW_INFO 0

Discover::GameController gameController;

void templateRender( void )
{
	glMatrixMode( GL_MODELVIEW );
	glLoadIdentity();
    
	glClear( GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT );
    
    gameController.frameBegin();
    gameController.frameEnd();
}

void player_callback_tap_down( void *, void *, vec2 * ) {
}

void templateLoading( void )
{
    gameController.setSimulationEngine(sio2->_SIO2resource, sio2->_SIO2window);
    gameController.load();
    
    //gameController._cardViews.at(0)->_sio2WidgetCard->_SIO2widgettapdown = player_callback_tap_down;
    
    // Set (render loop) pointer to function.
    sio2->_SIO2window->_SIO2windowrender = templateRender;
}

void templateShutdown( void )
{
	sio2ResourceUnloadAll( sio2->_SIO2resource );
    
	sio2->_SIO2resource = sio2ResourceFree( sio2->_SIO2resource );
	
	sio2->_SIO2window = sio2WindowFree( sio2->_SIO2window );
	
	sio2ShutdownWidget();
    
	sio2 = sio2Shutdown();
    
	printf("\nSIO2: shutdown...\n" );
}


void templateScreenTap( void *_ptr, unsigned char _state )
{
#ifdef SHOW_INFO == 1
	if( sio2->_SIO2window->n_touch )
	{
		// Print the position of the first touche found.
		printf("templateScreenTap >> state:%d tap:%d x:%f y:%f\n", _state,
               sio2->_SIO2window->n_tap,
               sio2->_SIO2window->touch[ 0 ].x,
               sio2->_SIO2window->touch[ 0 ].y );
	}
#endif
}


void templateScreenTouchMove( void *_ptr )
{
#ifdef SHOW_INFO == 1
	if( sio2->_SIO2window->n_touch )
	{
		// Print the position of the first touche found.
		printf("templateScreenTouchMove >> x:%f y:%f\n", sio2->_SIO2window->touch[ 0 ].x,
               sio2->_SIO2window->touch[ 0 ].y );
	}
#endif
}


void templateScreenAccelerometer( void *_ptr )
{


}
