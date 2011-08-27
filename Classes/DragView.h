//
//  DragView.h
//  Runemal
//
//  Created by Dirk on 4/18/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

@interface DragView : UIImageView {
	
	CGPoint startLocation;
	CGPoint currentLocation;
	NSDictionary *theRune;
	bool reversed;
	int runePosition;
	int previousRunePosition;
	bool imageReversed;
	UIImageView *runeFrontView;
	UIImageView *runeBackView;
	bool revealed;
}

@property (nonatomic, retain) NSDictionary *theRune;
@property bool reversed;
@property CGPoint currentLocation;
@property int runePosition;
@property int previousRunePosition;
@property bool imageReversed;
@property bool revealed;
@property (nonatomic, retain) UIImageView *runeBackView;
@property (nonatomic, retain) UIImageView *runeFrontView;


- (void)createAlternateFlipView;
-(NSString*)GetPosition;
-(void)RotateRuneImage;
@end
