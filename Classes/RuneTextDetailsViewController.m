//
//  RuneTextDetailsViewController.m
//  Runemal
//
//  Created by Dirk on 4/21/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import "RuneTextDetailsViewController.h"


@implementation RuneTextDetailsViewController


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
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
