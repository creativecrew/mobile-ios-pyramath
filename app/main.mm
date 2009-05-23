//
//  main.mm
//  template
//
//  Created by SIO2 Interactive on 8/22/08.
//  Copyright SIO2 Interactive 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "main.h"

int tmp_argc;
char **tmp_argv;

int main(int argc, char *argv[]) {

	tmp_argc = argc;
	tmp_argv = argv;
	
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, nil);
	[pool release];
	return retVal;
}
