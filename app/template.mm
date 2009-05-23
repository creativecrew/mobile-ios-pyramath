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

void templateRender( void )
{
    const GLfloat squareVertices[] = {
        100.0, 100.0, 0.0,
        200.0, 100.0, 0.0,
        100.0, 200.0, 0.0,
        200.0, 200.0, 0.0
    };
    
	glMatrixMode( GL_MODELVIEW );
	glLoadIdentity();
    
	glClear( GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT );
    
    sio2WindowEnter2D(sio2->_SIO2window, 0.0f, 1.0f);
	{
        glVertexPointer(3, GL_FLOAT, 0, squareVertices);
        glEnableClientState(GL_VERTEX_ARRAY);
        
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    }
    sio2WindowLeave2D();
}

void templateLoading( void )
{
    std::cout << std::endl << std::endl;
    std::cout << "hello word" << std::endl;
    
    Discover::GameController game;
    game.createDeck();
    game.getDeck()->shuffleDeck();
    std::cout << game.getDeck()->getCard(9)->toString() << std::endl;
    
    // Set (render loop) pointer to function.
    sio2->_SIO2window->_SIO2windowrender = templateRender;
}

void templateShutdown( void )
{
	// Clean up
	sio2->_SIO2window = sio2WindowFree( sio2->_SIO2window );
	
	sio2ResourceUnloadAll( sio2->_SIO2resource );

	sio2->_SIO2resource = sio2ResourceFree( sio2->_SIO2resource );

	sio2 = sio2Shutdown();
	
	printf("\nSIO2: shutdown...\n" );
}


void templateScreenTap( void *_ptr, unsigned char _state )
{

}


void templateScreenTouchMove( void *_ptr )
{


}


void templateScreenAccelerometer( void *_ptr )
{


}
