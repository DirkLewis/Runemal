//
//  SwitchViewController.h
//  iSave
//
//  Created by Dirk on 4/10/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RuneCastingController;
@class PagingScrollViewController;
@class SwitchBoardViewController;

@interface SwitchViewController : UIViewController {

	SwitchBoardViewController *switchBoardController;
	RuneCastingController *castingController;
	PagingScrollViewController *pageController;
	
	NSArray *theRunes;
}

@property (nonatomic, retain) RuneCastingController *castingController;
@property (nonatomic, retain) PagingScrollViewController *pageController;
@property (nonatomic, retain) SwitchBoardViewController *switchBoardController;
							 
-(void)SwitchViews:(UIViewController*)coming :(UIViewController*)going :(UIViewAnimationTransition)transition;


@end
