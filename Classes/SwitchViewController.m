//
//  SwitchViewController.m
//  iSave
//
//  Created by Dirk on 4/10/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import "SwitchViewController.h"
#import "RuneCastingController.h"
#import "PagingScrollViewController.h"
#import "SwitchBoardViewController.h"

@implementation SwitchViewController
@synthesize castingController;
@synthesize pageController;
@synthesize switchBoardController;



-(void)SwitchViews:(UIViewController*)coming :(UIViewController*)going :(UIViewAnimationTransition)transition{
	
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		

		[UIView setAnimationTransition: transition forView:self.view cache:YES];
		[coming viewWillAppear:YES];
		[going viewWillDisappear:YES];
		[going.view removeFromSuperview];
		[self.view insertSubview:coming.view atIndex:0];
		[going viewDidDisappear:YES];
		[coming viewDidAppear:YES];	
	
	[UIView commitAnimations];
	
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
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SwitchBoardToField:) name:@"FlipToFieldFromSwitchBoard" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FieldToRead:) name:@"FlipToReadFromField" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ToSwitchBoard:) name:@"FlipToSwitchBoard" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReadToField:) name:@"FlipFromReadToField" object:nil];


	self.view.backgroundColor =[UIColor	blackColor];
	SwitchBoardViewController *viewcontroller = [[SwitchBoardViewController alloc] initWithNibName:@"SwitchBoardView" bundle:nil];
	self.switchBoardController = viewcontroller;
	[self.view insertSubview:viewcontroller.view atIndex:0];
	[viewcontroller release];
 
    [super viewDidLoad];
}

-(void)SwitchBoardToField:(NSNotification*)notification{
	
	self.castingController = [notification object];
	
	[self SwitchViews:self.castingController :self.switchBoardController :UIViewAnimationTransitionFlipFromRight];
}

-(void)FieldToRead:(NSNotification*)notification{
	
	self.pageController = [notification object];
	[self SwitchViews:self.pageController :self.castingController :UIViewAnimationTransitionFlipFromRight];
	
}

-(void)ReadToField:(NSNotification*)notification{
	
	[self SwitchViews:self.castingController :self.pageController :UIViewAnimationTransitionFlipFromLeft];
}

-(void)ToSwitchBoard:(NSNotification*)notification{
	
	
	[self SwitchViews:self.switchBoardController :[notification object] :UIViewAnimationTransitionFlipFromLeft];
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
	[switchBoardController release];
	[castingController release];
	[pageController release];
    [super dealloc];
}


@end
