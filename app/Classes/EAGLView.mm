//
//  EAGLView.mm
//  template
//
//  Created by SIO2 Interactive on 8/22/08.
//  Copyright SIO2 Interactive 2008. All rights reserved.
//



#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>

#import "EAGLView.h"

#import "main.h"

#include "template.h"


// A class extension to declare private methods
@interface EAGLView ()

@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, assign) NSTimer *animationTimer;

- (BOOL) createFramebuffer;
- (void) destroyFramebuffer;

@end


@implementation EAGLView

@synthesize context;
@synthesize animationTimer;
@synthesize animationInterval;


// You must implement this
+ (Class)layerClass {
	return [CAEAGLLayer class];
}


//The GL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id)initWithCoder:(NSCoder*)coder {

	if ((self = [super initWithCoder:coder])) {
		// Get the layer
		CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
		
		eaglLayer.opaque = YES;
		eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
		   [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
		
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
		
		if (!context || ![EAGLContext setCurrentContext:context]) {
			[self release];
			return nil;
		}
		
		animationInterval = 1.0 / 60.0;
	}
	return self;
}


- (void)drawView {


	if( sio2->_SIO2window->_SIO2windowrender )
	{
		sio2->_SIO2window->_SIO2windowrender();

		sio2WindowSwapBuffers( sio2->_SIO2window );
	}

	
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	[context presentRenderbuffer:GL_RENDERBUFFER_OES];
}


- (void)layoutSubviews {
	[EAGLContext setCurrentContext:context];
	[self destroyFramebuffer];
	[self createFramebuffer];
	[self drawView];
}


- (BOOL)createFramebuffer {
	
	glGenFramebuffersOES(1, &viewFramebuffer);
	glGenRenderbuffersOES(1, &viewRenderbuffer);
	
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	[context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)self.layer];
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
	
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
	glGenRenderbuffersOES(1, &depthRenderbuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
	glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);



	if( !sio2 )
	{
		sio2Init( &tmp_argc, tmp_argv );
		
		sio2InitGL();
		
		sio2->_SIO2window = sio2WindowInit();
		
		sio2WindowUpdateViewport( sio2->_SIO2window, 0, 0, backingWidth, backingHeight );

		sio2->_SIO2resource = sio2ResourceInit();
		
		sio2->_SIO2window->_SIO2windowrender = templateLoading;	
		
		sio2WindowShutdown( sio2->_SIO2window, templateShutdown );
		
		sio2->_SIO2window->_SIO2windowtap			= templateScreenTap;
		sio2->_SIO2window->_SIO2windowtouchmove		= templateScreenTouchMove;
		sio2->_SIO2window->_SIO2windowaccelerometer = templateScreenAccelerometer;
	}

	
	return YES;
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch;
	CGPoint pos;
	
	sio2->_SIO2window->n_touch = 0;
	
	for( touch in touches )
	{
		pos = [ touch locationInView:self ];

		sio2->_SIO2window->touch[ sio2->_SIO2window->n_touch ].x = pos.y;
		sio2->_SIO2window->touch[ sio2->_SIO2window->n_touch ].y = pos.x;
		
		++sio2->_SIO2window->n_touch;
	}		
	
	sio2->_SIO2window->n_tap = [ [ touches anyObject ] tapCount ];
	
	sio2ResourceDispatchEvents( sio2->_SIO2resource,
								sio2->_SIO2window,
								SIO2_WINDOW_TAP,
								SIO2_WINDOW_TAP_DOWN );
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch;
	CGPoint pos;
	
	sio2->_SIO2window->n_touch = 0;
	
	for( touch in touches )
	{
		pos = [ touch locationInView:self ];
		
		sio2->_SIO2window->touch[ sio2->_SIO2window->n_touch ].x = pos.y;
		sio2->_SIO2window->touch[ sio2->_SIO2window->n_touch ].y = pos.x;
		
		++sio2->_SIO2window->n_touch;
	}
	
	sio2ResourceDispatchEvents( sio2->_SIO2resource,
								sio2->_SIO2window,
								SIO2_WINDOW_TOUCH_MOVE,
								SIO2_WINDOW_TAP_DOWN );
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch;
	CGPoint pos;
	
	sio2->_SIO2window->n_touch = 0;
	
	for( touch in touches )
	{
		pos = [ touch locationInView:self ];
		
		sio2->_SIO2window->touch[ sio2->_SIO2window->n_touch ].x = pos.y;
		sio2->_SIO2window->touch[ sio2->_SIO2window->n_touch ].y = pos.x;
		
		++sio2->_SIO2window->n_touch;
	}	
	
	sio2ResourceDispatchEvents( sio2->_SIO2resource,
								sio2->_SIO2window,
								SIO2_WINDOW_TAP,
								SIO2_WINDOW_TAP_UP );
}


- (void)destroyFramebuffer {
	
	glDeleteFramebuffersOES(1, &viewFramebuffer);
	viewFramebuffer = 0;
	glDeleteRenderbuffersOES(1, &viewRenderbuffer);
	viewRenderbuffer = 0;
	
	if(depthRenderbuffer) {
		glDeleteRenderbuffersOES(1, &depthRenderbuffer);
		depthRenderbuffer = 0;
	}
}


- (void)startAnimation {
	self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:animationInterval target:self selector:@selector(drawView) userInfo:nil repeats:YES];
}


- (void)stopAnimation {
	self.animationTimer = nil;
}


- (void)setAnimationTimer:(NSTimer *)newTimer {
	[animationTimer invalidate];
	animationTimer = newTimer;
}


- (void)setAnimationInterval:(NSTimeInterval)interval {
	
	animationInterval = interval;
	if (animationTimer) {
		[self stopAnimation];
		[self startAnimation];
	}
}


- (void)dealloc {
	
	[self stopAnimation];
	
	if ([EAGLContext currentContext] == context) {
		[EAGLContext setCurrentContext:nil];
	}
	
	[context release];	
	[super dealloc];
}

@end
