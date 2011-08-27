//
//  RuneListDetailsController.m
//  Runemal
//
//  Created by Dirk on 4/17/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import "RuneListDetailsController.h"
#import "Constants.h"
#import "Utility.h"
#import "RunemalAppDelegate.h"

const CGFloat TEXT_VIEW_PADDING = 50.0;


@implementation RuneListDetailsController

@synthesize theImage;
@synthesize shortDesc;
@synthesize runeName;
@synthesize germanic;
@synthesize oldenglish;
@synthesize letter;
@synthesize aettir;
@synthesize theRune;
@synthesize upright;
@synthesize reversed;
@synthesize detailText;

-(id)init{
	if(self = [super init]){
		
	}
	return self;
}

- (id)initWithDetails:(int)page :(NSString*)nib :(NSDictionary*) therune {
    if (self = [super initWithNibName:nib bundle:[NSBundle mainBundle]]) {
		self.theRune = therune;
        pageNumber = page;
    }
    return self;
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		self = [super initWithNibName:@"RuneListDetailsView" bundle:[NSBundle mainBundle]];
    }
    return self;
}

*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

-(void)viewDidAppear:(BOOL)animated{
	NSLog(@"Rune details view did appear");
}

- (void)viewWillAppear:(BOOL)animated { 

	NSLog(@"Rune details view will appear");	
	[super viewWillAppear:animated];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSString *uprightpath = nil;

	switch (pageNumber) {
		case 0:
			self.shortDesc.text = [theRune objectForKey:kShortDescription];
			self.germanic.text = [theRune objectForKey:kGermanic];
			self.oldenglish.text = [theRune objectForKey:kOldEnglish];
			self.runeName.text = [theRune objectForKey:kBaseDescription];
			self.letter.text = [theRune objectForKey:kLetter];
			self.aettir.text = [theRune objectForKey:kAettir];
			self.theImage.image = [UIImage imageNamed: [theRune objectForKey:kIconImagePath]];
			[self SetButton :@"Next Page"];
			break;
		case 1:
			
			uprightpath = [[NSBundle mainBundle] pathForResource:[self.theRune objectForKey:kUprightDesciption] ofType:@"txt"];
			NSLog(@"File Name is: %@", uprightpath);
			self.detailText.text = [NSString stringWithContentsOfFile: uprightpath encoding:NSUTF8StringEncoding error:nil];
			
			NSLog(@"Detail Text is: %@", self.detailText.text);
			
			if([[self.theRune objectForKey:kReversable] intValue] == 1){
				[self SetButton:@"Next Page"];
			}
			break;
		case 2:
			self.detailText.text = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[self.theRune objectForKey:kReversedDescription] ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
			break;
		default:
			break;
	}

    [super viewDidLoad];
}

-(void)SetButton:(NSString*)title{
	UIBarButtonItem *pageSwap = [[UIBarButtonItem alloc]
								 initWithTitle:title
								 style:UIBarButtonItemStyleBordered
								 target:self
								 action:@selector(myTest)];
	self.navigationItem.rightBarButtonItem = pageSwap;
	[pageSwap release];
}

-(void)myTest{
	
	[Utility PlayAudioClick:click];
	NSLog(@"myTest Fired");
	
	int newpage = pageNumber + 1;
	RuneListDetailsController *controller = [[RuneListDetailsController alloc] initWithDetails:newpage :@"RuneDetailsTextView" :self.theRune];
	
	if((newpage ) == 1){
		controller.title = @"Upright";

	}
	else{
		controller.title = @"Reversed";

	}
	
	
    RunemalAppDelegate *delegate = 	[[UIApplication sharedApplication] delegate]; 
    [delegate.navController pushViewController:controller animated:YES]; 
	[controller release];	
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

- (void)updateTextViews:(BOOL)force
{
	if (force ||(textViewNeedsUpdate &&	self.view.window && CGRectIntersectsRect([self.view.window convertRect:CGRectInset(detailText.bounds, TEXT_VIEW_PADDING, TEXT_VIEW_PADDING)
																				  fromView:detailText],
																				 [self.view.window bounds])))
	{
		for (UIView *childView in detailText.subviews)
		{
			[childView setNeedsDisplay];
		}
		textViewNeedsUpdate = NO;
	}
}

- (void)dealloc {
	[detailText release];
	[upright release];
	[reversed release];
	[theImage release];
	[letter release];
	[aettir release];
	[theRune release];
	[germanic release];
	[oldenglish release];
	[runeName release];
	[shortDesc release];
    [super dealloc];
}


@end
