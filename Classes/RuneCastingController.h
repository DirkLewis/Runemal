//
//  RuneCastingController.h
//  Runemal
//
//  Created by Dirk on 4/18/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@class BagShakeController;
@class DragView;
@class RuneReadingsPageController;

@interface RuneCastingController : UIViewController {
	
	NSMutableArray *theRunes;
	SystemSoundID click;
	SystemSoundID chime;
	int runeCount;
	int castMax;
	bool isRevealed;
	bool allowShake;
	
	BagShakeController *theShaker;
	//UIImageView *yourDraw;
	
}

@property (nonatomic, retain) NSMutableArray *theRunes;
@property (nonatomic, retain) BagShakeController *theShaker;

-(int)GetRandomNumber;
-(void)DetermineRunePosition:(DragView*)theRune;
-(void)PullRune;

-(IBAction) DrawRune;
-(IBAction) RevealRunes:(id)sender;
-(IBAction) ReadRunes:(id)sender;
-(IBAction) BackToHome:(id)sender;

@end
