/*
 *  template.h
 *  template
 *
 *  Created by SIO2 Interactive on 8/22/08.
 *  Copyright 2008 SIO2 Interactive. All rights reserved.
 *
 */

#ifndef TEMPLATE_H
#define TEMPLATE_H

void templateRender( void );

void templateLoading( void );

void templateShutdown( void );

void templateScreenTap( void *_ptr, unsigned char _state );

void templateScreenTouchMove( void *_ptr );

void templateScreenAccelerometer( void *_ptr );

#endif
