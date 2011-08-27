//
//  DragView.m
//  Runemal
//
//  Created by Dirk on 4/18/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import "DragView.h"
#import "Constants.h"
#import "Utility.h"

@implementation DragView

@synthesize theRune;
@synthesize reversed;
@synthesize currentLocation;
@synthesize runePosition;
@synthesize previousRunePosition;
@synthesize imageReversed;
@synthesize runeBackView;
@synthesize runeFrontView;
@synthesize revealed;

- (id)initWithFrame:(CGRect)aRect{
	if(self = [super initWithFrame:aRect]){
		
		self.revealed = FALSE;
		self.previousRunePosition = 0;
		self.runePosition = 0;
		self.imageReversed = FALSE;
		[self setUserInteractionEnabled:YES];

	}
	return self;
}

-(NSString*)GetPosition{
	switch (self.runePosition) {
		case kSelf:
			return @"Self - Where you are now";
		case kBehind:
			return @"Behind - Where you have been";
		case kAhead:
			return @"Ahead - What lies ahead";
		case kBelow:
			return @"Below - Foundation of your issue";
		case kBlocking:
			return @"Blocking - Nature of your obsticles";
		case kAbove:
			return @"Above - Best out come you can expect";
		default:
			return @"";
	}
}

- (void)createAlternateFlipView
{
	CGRect imageFrame = CGRectMake(0.0, 0.0, 50.0f, 70.0f);
	runeBackView = [[UIImageView alloc] initWithFrame:imageFrame];
	runeBackView.image = [UIImage imageNamed:@"RuneBack.png"];
	runeFrontView = [[UIImageView alloc] initWithFrame:imageFrame];
	runeFrontView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [theRune objectForKey:kRuneImagePath]]];
	
	
}

-(void)RotateRuneImage{
	NSLog(@"Rotate Image:: %@ rune, reversed: %d, reverable %d", [self.theRune objectForKey:kBaseDescription], reversed, [[self.theRune objectForKey:kReversable] intValue]);
	
	NSString *reversable = [self.theRune objectForKey:kReversable];
	int test = [reversable intValue];
	if(reversed & (test == 1)){
		NSLog(@"Rotate Transform fired");
		CGAffineTransform cgCTM = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
		self.transform = cgCTM;
	}
	else{
		CGAffineTransform cgCTM = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(360));
		self.transform = cgCTM;
	}
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	if(self.revealed){
		return;
	}
	// Retrieve the touch point
	self.previousRunePosition = self.runePosition;
	self.runePosition = 0;
	NSLog(@"Rune %@ was touched", [self.theRune objectForKey:kBaseDescription]);
	CGPoint pt = [[touches anyObject] locationInView:self];
	startLocation = pt;
	self.image = [UIImage imageNamed:@"RuneBackTouched.png"];
	[[self superview] bringSubviewToFront:self];
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)even{
	
	if(self.revealed){
		return;
	}
	
	NSLog(@"Rune %@ was released", [self.theRune objectForKey:kBaseDescription]);
	self.image = [UIImage imageNamed:@"RuneBack.png"];
	CGRect frame = [self frame];
	currentLocation = CGPointMake(frame.origin.x, frame.origin.y);
	NSLog(@"The points are x %f, y %f", currentLocation.x, currentLocation.y );
		
	//if a new position number is set then we have moved
	//if it is the same then we are locked or been off a position for 2 or more moves
	[[NSNotificationCenter defaultCenter] postNotificationName:@"RuneMoved" object:self];		

	NSLog(@"====Position is: %d , Previous is: %d=====", self.runePosition, self.previousRunePosition);
		
	//if the rune is locked we need to send a special event to see if the user wants to reverse the rune.
	if(self.previousRunePosition == self.runePosition){
			
		if(self.runePosition != 0 && self.runePosition != 100){
			
			imageReversed = !imageReversed;
			NSLog(@"Image Reversed is:%d", imageReversed);
			self.reversed = !self.reversed;		
			NSLog(@"Rune Reversed is: %d", self.reversed);
			
			if(imageReversed){
				CGAffineTransform cgCTM = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
				//self.runeFrontView.transform = cgCTM;
				self.transform = cgCTM;
			}
			else{
				CGAffineTransform cgCTM = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(360));
				//self.runeFrontView.transform = cgCTM;				
				self.transform = cgCTM;
			}
			
		
		}
	}
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	if(self.revealed){
		return;
	}
	
	if(imageReversed){
		self.imageReversed = !imageReversed;
		self.reversed = !reversed;
		CGAffineTransform cgCTM = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(360));
		self.transform = cgCTM;
	}
	// Move relative to the original touch point
	CGPoint pt = [[touches anyObject] locationInView:self];
	CGRect frame = [self frame];
	frame.origin.x += pt.x - startLocation.x;
	frame.origin.y += pt.y - startLocation.y;
	[self setFrame:frame];
}

- (void)dealloc {
	[runeFrontView release];
	[runeBackView release];
	[theRune release];
    [super dealloc];
}

@end
