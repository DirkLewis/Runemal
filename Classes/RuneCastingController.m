//
//  RuneCastingController.m
//  Runemal
//
//  Created by Dirk on 4/18/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import "RuneCastingController.h"
#import "Constants.h"
#import "Utility.h"
#import "DragView.h"
#import "PagingScrollViewController.h"
#import "RunemalAppDelegate.h"
#import "SoundEffectsController.h"
#import "BagShakeController.h"

@implementation RuneCastingController

@synthesize theRunes;
@synthesize theShaker;

-(IBAction)BackToHome:(id)sender{
	
	[Utility PlayAudioClick:click];	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"FlipToSwitchBoard" object:self];		
}

-(IBAction)ReadRunes:(id)sender{
	
	if(castMax != runeCount || isRevealed == FALSE){
		return;
	}
	
	[Utility PlayAudioClick:click];
	NSLog(@"Read Runes Fired");
	
	//When the read is pushed the screen should flip to a scroll view
	//that has a number of pages equal to the castmax count.
	//This will then load up a result for the rune based up upright or reversed.
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	for (DragView *iv in [self.view subviews]) {
		
		if([iv isKindOfClass:[DragView class]]){
			[array addObject:iv];
		}
	}
	
	NSSortDescriptor *positionSorter = [[NSSortDescriptor alloc] initWithKey:@"runePosition" ascending:YES];
	[array sortUsingDescriptors:[NSArray arrayWithObjects:positionSorter,nil]];
	
	NSArray *theField = [NSArray arrayWithArray:array];
	
	PagingScrollViewController *pc = [[PagingScrollViewController alloc] initRuneReading:@"RuneReadPagesView" :castMax :theField];
    	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"FlipToReadFromField" object:pc];	
    

	
}

-(IBAction)DrawRune{
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if([defaults boolForKey:@"Effects_Pref"]){
		RunemalAppDelegate *delegate = 	[[UIApplication sharedApplication] delegate]; 
		[delegate.soundEffectsController StartSoundTrack:@"Shake" :@"mp3" : 0];
	}
	else {
		[Utility PlayAudioClick:click];
	}	[self PullRune];

}

-(void)DetermineRunePosition:(DragView*)theRune{
	
	
	for(UIImageView *iv in [self.view subviews]){
		
		if(iv.tag >= 100 && iv.tag <= 106){
			
			CGRect positionFrame = [iv frame];
			CGRect runeFrame = [theRune frame];
			
			//if position frame x and y are + or - currentlocation x and y then snap
			
			float theX = positionFrame.origin.x - theRune.currentLocation.x;
			float theY = positionFrame.origin.y - theRune.currentLocation.y;
			
			if((theX >= -20 && theX <=20) && (theY >= -20 && theY <= 20)){
				//set the position
				runeFrame.origin.x = positionFrame.origin.x;
				runeFrame.origin.y = positionFrame.origin.y;
				[theRune setFrame:runeFrame];
				theRune.currentLocation = CGPointMake(runeFrame.origin.x, runeFrame.origin.y);
				theRune.runePosition = iv.tag;
				NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
				if([defaults boolForKey:@"Effects_Pref"]){
					RunemalAppDelegate *delegate = 	[[UIApplication sharedApplication] delegate]; 
					[delegate.soundEffectsController StartSoundTrack:@"RuneClick" :@"mp3" : 0];
				}
				else {
					[Utility PlayAudioClick:click];
				}

				return;
			}
			else {
				theRune.runePosition = 0;
			}

		}
	}
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

-(void)viewDidDisappear:(BOOL)animated{
	NSLog(@"Did disappear");
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"BagShook" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
	NSLog(@"will appear");
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BagShook:) name:@"BagShook" object:nil];

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
		
	NSLog(@"%@",[self nibName]);
	
	isRevealed = FALSE;
	
	if([[self nibName] isEqualToString:@"SixRuneCastView"] ){
		castMax = 6;
	}
	
	if([[self nibName] isEqualToString:@"ThreeRuneCastView"] ){
		castMax = 3;
	}

	if([[self nibName] isEqualToString:@"OneRuneCastView"] ){
		castMax = 1;
	}
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RuneMoved:) name:@"RuneMoved" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LockedRuneTouched:) name:@"LockedRuneTouched" object:nil];
	
	self.theRunes = [NSMutableArray arrayWithArray:[Utility GetRuneList]];
	
	self.theShaker = [[[BagShakeController alloc] init]autorelease];

    [super viewDidLoad];
}

-(void)BagShook:(NSNotification*)notification{
	
	NSLog(@"Casting Controller shook fired");
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if([defaults boolForKey:@"Effects_Pref"]){
		RunemalAppDelegate *delegate = 	[[UIApplication sharedApplication] delegate]; 
		[delegate.soundEffectsController StartSoundTrack:@"Shake" :@"mp3" : 0];
	}
	else {
		[Utility PlayAudioClick:click];
	}

	[self PullRune];
}

-(IBAction)RevealRunes:(id)sender{
	
	if(castMax != runeCount){
		return;
	}
	
	NSLog(@"Reveal Pushed.");
	[Utility PlayAudioClick:click];	
	for(DragView *iv in [self.view subviews]){
		
		if([iv isKindOfClass:[DragView class]]){
			//NSLog(@"the drawn rune is: %@", [iv.theRune objectForKey:kBaseDescription]);
			
			//I have the rune and need to flip it.
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:1.0f];
			[UIView setAnimationTransition:([iv.runeBackView superview] ?
											UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight)
								   forView:iv cache:YES];
			
			[iv setImage:iv.runeFrontView.image];
			[UIView commitAnimations];			
			
			[iv RotateRuneImage];
			
			iv.revealed = TRUE;
			
		}
	}
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if([defaults boolForKey:@"Effects_Pref"]){
		RunemalAppDelegate *delegate = 	[[UIApplication sharedApplication] delegate]; 
		[delegate.soundEffectsController StartSoundTrack:@"ShortChime" :@"mp3" :0 ];
	}
	
	isRevealed = TRUE;
}


-(void)PullRune{
	if(runeCount == castMax){
		
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:@"Your draw has been completed."
							  message:[NSString stringWithFormat:@"You have drawn %d runes.  Please place your stones, and reveal Runemal's insights.", runeCount]
							  delegate:self
							  cancelButtonTitle:@"OK"
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		return;
	}
	
	runeCount++;
	
	if([self.theRunes count] != 0){
		int index = [self GetRandomNumber];
		
		int reversed = arc4random() % 2;
		
		NSLog(@"Draw Rune Fired");
		NSLog(@"The Random Number is:%d", index);
		
		
		CGRect dragRect = CGRectMake(0.0f, 0.0f, 50.0f, 70.0f);
		dragRect.origin = CGPointMake(33.0f, 302.0f);
		DragView *dragger = [[DragView alloc] initWithFrame:dragRect];
		dragger.theRune = [self.theRunes objectAtIndex:index];
		[self.theRunes removeObjectAtIndex:index];
		
		if(reversed == 0){
			dragger.reversed = YES;
			NSLog(@"%@ Rune reversed ::: Bool number is %d",[dragger.theRune objectForKey:kBaseDescription],  dragger.reversed);
		}
		else {
			dragger.reversed = NO;
			NSLog(@"%@ Rune Upright ::: Bool number is %d",[dragger.theRune objectForKey:kBaseDescription],  dragger.reversed);
		}
		[dragger createAlternateFlipView];
		[dragger setImage:dragger.runeBackView.image];		
		[self.view addSubview:dragger];
		NSLog(@"the drawn rune is: %@", [dragger.theRune objectForKey:kBaseDescription]);
		NSLog(@"The total runes are:%d", [self.theRunes count]);	
		[dragger release];
		
		for (DragView *iv in [self.view subviews]) {
			
			if([iv isKindOfClass:[DragView class]]){
				NSLog(@"the drawn rune is: %@", [iv.theRune objectForKey:kBaseDescription]);
				
			}
		}		
	}
	else {
		
		NSLog(@"The Bag is empty");
	}
	
}

-(void)LockedRuneTouched:(NSNotification*)notification{
	
	NSLog(@"Locked Rune Touched Fired");
	
}

-(void)RuneMoved:(NSNotification*)notification{
	
	DragView *dv = [notification object];
	NSLog(@"Rune Name is: %@",[dv.theRune objectForKey:kBaseDescription]);
	
	//now that i have the object i should be able to see which position it is near and snap it in place
	[self DetermineRunePosition:dv];
	
}


-(int)GetRandomNumber{
	
	int result = arc4random() % [self.theRunes count];
	return result;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}




- (void)dealloc {
	[theShaker release];
	[theRunes release];
    [super dealloc];
}


@end
