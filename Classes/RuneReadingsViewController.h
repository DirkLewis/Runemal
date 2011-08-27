//
//  RuneReadingsViewController.h
//  Runemal
//
//  Created by Dirk on 4/19/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

@class DragView;


@interface RuneReadingsViewController : UIViewController {

	DragView *myRune;
	
	UILabel *myReading;
	UILabel *myTitle;
	UILabel *myMeaning;
	UIImageView *myRuneImage;
	
	
	SystemSoundID click;
	int pageNumber;
		
}

@property (nonatomic, retain) DragView *myRune;

@property (nonatomic, retain) IBOutlet UILabel *myMeaning;
@property (nonatomic, retain) IBOutlet UILabel *myReading;
@property (nonatomic, retain) IBOutlet UILabel *myTitle;
@property (nonatomic, retain) IBOutlet UIImageView *myRuneImage;

@property int pageNumber;

-(IBAction)SwitchViews:(id)sender;

- (id)initWithDetails:(int)page :(DragView*) therune;
@end
