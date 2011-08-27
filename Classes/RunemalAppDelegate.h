//
//  RunemalAppDelegate.h
//  Runemal
//
//  Created by Dirk on 4/16/09.
//  Copyright VideoHooHaa.com 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SoundEffectsController;

@interface RunemalAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *rootTabController;
	UINavigationController *navController;
	SoundEffectsController *soundEffectsController;
	
	


}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootTabController;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) SoundEffectsController *soundEffectsController;
@end

