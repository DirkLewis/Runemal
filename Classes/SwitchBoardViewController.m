//
//  SwitchBoardViewController.m
//  Runemal
//
//  Created by Dirk on 4/20/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import "SwitchBoardViewController.h"
#import "Constants.h"
#import "Utility.h"
#import "DragView.h"
#import "RuneCastingController.h"
#import "RunemalAppDelegate.h"
#import "SoundEffectsController.h"

@implementation SwitchBoardViewController


-(IBAction)OneRune:(id)sender{
	
	[Utility PlayAudioClick:click];
	RuneCastingController *controller = [[RuneCastingController alloc] initWithNibName:@"OneRuneCastView" bundle:[NSBundle mainBundle]];

	[[NSNotificationCenter defaultCenter] postNotificationName:@"FlipToFieldFromSwitchBoard" object:controller];		
	[controller release];
}

-(IBAction)ThreeRune:(id)sender{
	[Utility PlayAudioClick:click];	
	RuneCastingController *controller = [[RuneCastingController alloc] initWithNibName:@"ThreeRuneCastView" bundle:[NSBundle mainBundle]];

	[[NSNotificationCenter defaultCenter] postNotificationName:@"FlipToFieldFromSwitchBoard" object:controller];		
	[controller release];
}

-(IBAction)SixRune:(id)sender{

	[Utility PlayAudioClick:click];
	RuneCastingController *controller = [[RuneCastingController alloc] initWithNibName:@"SixRuneCastView" bundle:[NSBundle mainBundle]];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"FlipToFieldFromSwitchBoard" object:controller];		
	[controller release];

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if([defaults boolForKey:@"Music_Pref"] && !bacgroundMusicPlaying){
		
		RunemalAppDelegate *delegate = 	[[UIApplication sharedApplication] delegate]; 
		[delegate.soundEffectsController StartSoundTrack:[defaults objectForKey:@"Background_Music"] :@"aiff" :-1];
		bacgroundMusicPlaying = TRUE;
	}
	

    [super viewDidLoad];
	
	
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
    [super dealloc];
}


@end
