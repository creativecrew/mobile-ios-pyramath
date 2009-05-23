//
//  templateAppDelegate.m
//  template
//
//  Created by SIO2 Interactive on 8/22/08.
//  Copyright SIO2 Interactive 2008. All rights reserved.
//

#import "templateAppDelegate.h"
#import "EAGLView.h"

@implementation templateAppDelegate

@synthesize window;
@synthesize glView;

- (void)applicationDidFinishLaunching:(UIApplication *)application {

	glView.animationInterval = 1.0 / 60.0;
	[glView startAnimation];
	
	[ [UIApplication sharedApplication] setIdleTimerDisabled:NO ];

    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:( 1.0f / 30.0f )];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];		
}


- (void)applicationWillResignActive:(UIApplication *)application {
	glView.animationInterval = 1.0 / 5.0;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	glView.animationInterval = 1.0 / 60.0;
}

- (void)dealloc {
	[window release];
	[glView release];
	[super dealloc];
}


- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	sio2->_SIO2window->accel->x = acceleration.x * ( 1.0f - sio2->_SIO2window->accel_smooth ) + sio2->_SIO2window->accel->x * sio2->_SIO2window->accel_smooth;
	sio2->_SIO2window->accel->y = acceleration.y * ( 1.0f - sio2->_SIO2window->accel_smooth ) + sio2->_SIO2window->accel->y * sio2->_SIO2window->accel_smooth;
	sio2->_SIO2window->accel->z = acceleration.z * ( 1.0f - sio2->_SIO2window->accel_smooth ) + sio2->_SIO2window->accel->z * sio2->_SIO2window->accel_smooth;	

	sio2->_SIO2window->accel->x = ( int )( sio2->_SIO2window->accel->x * 100.0f );
	sio2->_SIO2window->accel->x *= 0.01f;

	sio2->_SIO2window->accel->y = ( int )( sio2->_SIO2window->accel->y * 100.0f );
	sio2->_SIO2window->accel->y *= 0.01f;		

	sio2ResourceDispatchEvents( sio2->_SIO2resource,
								sio2->_SIO2window,
								SIO2_WINDOW_ACCELEROMETER,
								SIO2_WINDOW_TAP_NONE );
}

@end
