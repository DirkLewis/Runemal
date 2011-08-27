//
//  RunemalAppDelegate.m
//  Runemal
//
//  Created by Dirk on 4/16/09.
//  Copyright VideoHooHaa.com 2009. All rights reserved.
//

#import "RunemalAppDelegate.h"
#import "SoundEffectsController.h"

@implementation RunemalAppDelegate

@synthesize window;
@synthesize rootTabController;
@synthesize navController;
@synthesize soundEffectsController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	[window addSubview:rootTabController.view];
    [window makeKeyAndVisible];
	
	self.soundEffectsController = [[[SoundEffectsController alloc]init]autorelease];


}

- (void)dealloc {
	[soundEffectsController release];
	[navController release];
	[rootTabController release];
    [window release];
    [super dealloc];
}


@end
