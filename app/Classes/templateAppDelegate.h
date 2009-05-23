//
//  templateAppDelegate.h
//  template
//
//  Created by SIO2 Interactive on 8/22/08.
//  Copyright SIO2 Interactive 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;

@interface templateAppDelegate : NSObject <UIAccelerometerDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet EAGLView *glView;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) EAGLView *glView;

@end

