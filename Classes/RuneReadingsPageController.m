//
//  RuinReadingsPageController.m
//  Runemal
//
//  Created by Dirk on 4/19/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import "RuneReadingsPageController.h"
#import "Constants.h"
#import "Utility.h"
#import "RuneReadingsViewController.h"

@implementation RuneReadingsPageController

@synthesize scrollView;
@synthesize pageControl;
@synthesize viewControllers;
@synthesize theRunes;

- (id)initRuneReading:(NSString*)nib :(int)pagecount :(NSArray*)runes{
	if (self = [super initWithNibName:nib bundle:[NSBundle mainBundle]]) {
		self.theRunes = runes;
		pages = pagecount;
    }
	
    return self;
}

- (void)loadScrollViewWithPage:(UIViewController*)controller :(int)page{
	
	if (page < 0) return;
    if (page >= pages) return;
	
	CGRect frame = scrollView.frame;
	frame.origin.x = frame.size.width * page;
	frame.origin.y = 0;
	controller.view.frame = frame;
	[scrollView addSubview:controller.view];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender{
	// We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
	
	
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
	
	
}


// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;

    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
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
	
	NSMutableArray *controllers = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < pages; i++) {
		
		[controllers addObject:[[RuneReadingsViewController alloc] initWithDetails:i :[self.theRunes objectAtIndex:i]]];
		
	}
	
	self.viewControllers = controllers;
    [controllers release];
	
	// a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * pages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
	
    pageControl.numberOfPages = pages;
    pageControl.currentPage = 0;
	
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
	
	


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
	[theRunes release];
	[scrollView release];
	[pageControl release];
	[viewControllers release];
    [super dealloc];
}


@end
