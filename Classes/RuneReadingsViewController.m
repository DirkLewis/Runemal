//
//  RuneReadingsViewController.m
//  Runemal
//
//  Created by Dirk on 4/19/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import "RuneReadingsViewController.h"
#import "Utility.h"
#import "Constants.h"

#import "DragView.h"


@implementation RuneReadingsViewController

@synthesize myRune;
@synthesize pageNumber;
@synthesize myRuneImage;
@synthesize myReading;
@synthesize myTitle;
@synthesize myMeaning;

- (id)initWithDetails:(int)page :(DragView*) therune {
    if (self =  [super initWithNibName:@"RuneReadView" bundle:[NSBundle mainBundle]]) {
		self.myRune = therune;
        pageNumber = page;
    }
    return self;
}

-(IBAction)SwitchViews:(id)sender{

	[Utility PlayAudioClick:click];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"FlipFromReadToField" object:nil];		

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

- (void)viewWillAppear:(BOOL)animated{
	NSLog(@"View will appear fired");
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	
	
	myMeaning.text = [myRune GetPosition];
	myRuneImage.image =  myRune.runeFrontView.image; 
	if(myRune.reversed && ([[myRune.theRune objectForKey:kReversable] intValue]==1)){
		myReading.text = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[myRune.theRune objectForKey:kReversedSumary] ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
		myTitle.text = [NSString stringWithFormat:@"%@ - Reversed", [myRune.theRune objectForKey:kBaseDescription]];
		
		CGAffineTransform cgCTM = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
		myRuneImage.transform = cgCTM;
	}
	else {
		myReading.text = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[myRune.theRune objectForKey:kUprightSumary] ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];

		myTitle.text = [myRune.theRune objectForKey:kBaseDescription];
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
	[myMeaning release];
	[myRune release];
	[myReading release];
	[myTitle release];
	[myRuneImage release];
    [super dealloc];
}


@end
