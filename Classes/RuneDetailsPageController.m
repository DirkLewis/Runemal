//
//  RuneDetailsPageController.m
//  Runemal
//
//  Created by Dirk on 4/17/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import "RuneDetailsPageController.h"
#import "Constants.h"
#import "Utility.h"
#import "RuneListDetailsController.h"

static NSUInteger kNumberOfPages = 3;

@implementation RuneDetailsPageController

@synthesize viewControllers;
@synthesize scrollView;
@synthesize pageControl;
@synthesize theRune;

- (id)initRunePage:(NSString*)nib :(NSDictionary*) therune{
	if (self = [super initWithNibName:nib bundle:[NSBundle mainBundle]]) {
		self.theRune = therune;
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	// view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
	
	
	[controllers addObject:[[[RuneListDetailsController alloc] initWithDetails:1 :@"RuneListDetailsView" :self.theRune]autorelease]];
	[controllers addObject:[[[RuneListDetailsController alloc] initWithDetails:2 :@"RuneDetailsTextView" :self.theRune]autorelease]];
	[controllers addObject:[[[RuneListDetailsController alloc] initWithDetails:3 :@"RuneDetailsTextView" :self.theRune]autorelease]];

    self.viewControllers = controllers;
    [controllers release];
	
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
	
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
	
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    [self loadScrollViewWithPage:[self.viewControllers objectAtIndex:0] :0];
    [self loadScrollViewWithPage:[self.viewControllers objectAtIndex:1] :1];
	
    [super viewDidLoad];
}



- (void)loadScrollViewWithPage:(UIViewController*)controller :(int)page {
	
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
	
    // add the controller's view to the scroll view
	// if (nil == controller) {
	CGRect frame = scrollView.frame;
	frame.origin.x = frame.size.width * page;
	frame.origin.y = 0;
	controller.view.frame = frame;
	[scrollView addSubview:controller.view];
	
	
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
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
		
	if(!page == 0){
		RuneListDetailsController *controller1 = [self.viewControllers objectAtIndex:page - 1];
		[self loadScrollViewWithPage:controller1	:page - 1];	
	}
	
	RuneListDetailsController *controller2 = [self.viewControllers objectAtIndex:page];
	[controller2 updateTextViews:TRUE];
	[self loadScrollViewWithPage:controller2	:page];
	
	
	if(!page == 3){
		RuneListDetailsController *controller3 = [self.viewControllers objectAtIndex:page+1];
		[controller3 updateTextViews:TRUE];
		[self loadScrollViewWithPage:controller3 :page+1];
	}
	
	
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
	if(!page == 0){
		RuneListDetailsController *controller1 = [self.viewControllers objectAtIndex:page - 1];
		[self loadScrollViewWithPage:controller1	:page - 1];	
	}
	
	
	RuneListDetailsController *controller2 = [self.viewControllers objectAtIndex:page];
	[controller2 updateTextViews:TRUE];
	[self loadScrollViewWithPage:controller2	:page];
	
	if(!page == 3){
		RuneListDetailsController *controller3 = [self.viewControllers objectAtIndex:page+1];
		[controller3 updateTextViews:TRUE];

		[self loadScrollViewWithPage:controller3 :page+1];
	}
    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
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


// The following swipe code derives from Apple Sample Code
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{ 
	NSLog(@"Touches Began");
} 

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{ 
	NSLog(@"Something moved");
} 

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	NSLog(@"Touches Ended");
}

- (void)dealloc {
	[theRune release];
	[viewControllers release];
	[scrollView release];
	[pageControl release];
    [super dealloc];
}
@end
