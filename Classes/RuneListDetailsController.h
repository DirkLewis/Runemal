//
//  RuneListDetailsController.h
//  Runemal
//
//  Created by Dirk on 4/17/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
@class RuneListDetailsController;

@interface RuneListDetailsController : UIViewController {
	
	UILabel *shortDesc;
	UILabel *runeName;
	UILabel *germanic;
	UILabel *oldenglish;
	UILabel *letter;
	UILabel *aettir;
	UIImageView *theImage;
	
	UITextView *upright;
	UITextView *reversed;
	
	UITextView *detailText;
	
	NSDictionary *theRune;
	
	int pageNumber;
	
	BOOL textViewNeedsUpdate;
	
	SystemSoundID click;

}
@property (nonatomic, retain)  IBOutlet UILabel *shortDesc;
@property (nonatomic, retain) IBOutlet UILabel *runeName;
@property (nonatomic, retain) IBOutlet UILabel *germanic;
@property (nonatomic, retain) IBOutlet UILabel *oldenglish;
@property (nonatomic, retain) IBOutlet UILabel *letter;
@property (nonatomic, retain) IBOutlet UILabel *aettir;
@property (nonatomic, retain) IBOutlet UIImageView *theImage;
@property (nonatomic, retain) IBOutlet UITextView *upright;
@property (nonatomic, retain) IBOutlet UITextView *reversed;
@property (nonatomic, retain) IBOutlet UITextView *detailText;

@property (nonatomic, retain) NSDictionary *theRune;

- (id)initWithDetails:(int)page :(NSString*)nib :(NSDictionary*) therune;
- (void)updateTextViews:(BOOL)force;

-(void)SetButton:(NSString*)title;

@end
