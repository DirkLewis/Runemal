//
//  SwitchBoardViewController.h
//  Runemal
//
//  Created by Dirk on 4/20/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SwitchBoardViewController : UIViewController {
	
	SystemSoundID click;
	bool bacgroundMusicPlaying;
}
-(IBAction)OneRune:(id)sender;
-(IBAction)ThreeRune:(id)sender;
-(IBAction)SixRune:(id)sender;
@end
