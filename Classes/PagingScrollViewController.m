//
//  PagingScrollViewController.m
//  PagingScrollView
//
//  Created by Matt Gallagher on 24/01/09.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//

#import "PagingScrollViewController.h"
#import "RuneReadingsViewController.h"
#import "Constants.h"
#import "Utility.h"

@implementation PagingScrollViewController

@synthesize theRunes;
@synthesize pageControllers;
@synthesize nextPage;
@synthesize currentPage;
@synthesize scrollView;
@synthesize pageControl;

- (id)initRuneReading:(NSString*)nib :(int)pagecount :(NSArray*)runes{
	if (self = [super initWithNibName:nib bundle:[NSBundle mainBundle]]) {
		self.theRunes = runes;
		pages = pagecount;
    }
	
    return self;
}


- (void)applyNewIndex:(NSInteger)newIndex pageController:(RuneReadingsViewController *)pageController
{
	NSInteger pageCount = pages;
	BOOL outOfBounds = newIndex >= pageCount || newIndex < 0;

	if (!outOfBounds)
	{
		CGRect pageFrame = pageController.view.frame;
		pageFrame.origin.y = 0;
		pageFrame.origin.x = scrollView.frame.size.width * newIndex;
		pageController.view.frame = pageFrame;
	}
	else
	{
		CGRect pageFrame = pageController.view.frame;
		pageFrame.origin.y = scrollView.frame.size.height;
		pageController.view.frame = pageFrame;
	}

	pageController.pageNumber = newIndex;
}

- (void)viewDidLoad
{
	self.pageControllers = [[[NSMutableArray alloc]init]autorelease];
	if(pages > 1){
		
		RuneReadingsViewController *controller = [[RuneReadingsViewController alloc] initWithDetails:0 :[self.theRunes objectAtIndex:0]];
		[self.pageControllers addObject:controller];
		[controller release];
		self.currentPage = [self.pageControllers objectAtIndex:0];		
		[self.scrollView addSubview:self.currentPage.view];		
		[self applyNewIndex:0 pageController:self.currentPage];

	}
	else {
		currentPage = [[RuneReadingsViewController alloc] initWithDetails:0 :[self.theRunes objectAtIndex:0]];
		[self.scrollView addSubview:self.currentPage.view];
		[self applyNewIndex:0 pageController:currentPage];

	}

	NSInteger widthCount = pages;
	if (widthCount == 0)
	{
		widthCount = 1;
	}
	
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * widthCount,self.scrollView.frame.size.height);	
	self.scrollView.contentOffset = CGPointMake(0, 0);

	self.pageControl.numberOfPages = pages;
	self.pageControl.currentPage = 0;

	[super viewDidLoad];

}

- (void) SetRunePages: (NSInteger) upperNumber lowerNumber: (NSInteger) lowerNumber  {
	
	RuneReadingsViewController *controller = [[RuneReadingsViewController alloc] initWithDetails:upperNumber :[self.theRunes objectAtIndex:upperNumber]];
	[self.pageControllers addObject:controller];
	[controller release];
	self.currentPage = [self.pageControllers objectAtIndex:lowerNumber];
	self.nextPage = [self.pageControllers objectAtIndex:upperNumber];
	
	[self.scrollView addSubview:self.currentPage.view];
	[self.scrollView addSubview:self.nextPage.view];
	[self applyNewIndex:lowerNumber pageController:self.currentPage];
	[self applyNewIndex:upperNumber pageController:self.nextPage];
	
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
	
	NSInteger lowerNumber = floor(fractionalPage);
	NSInteger upperNumber = lowerNumber + 1;
	

	
	if(lowerNumber < 0){
		lowerNumber = 0;
		upperNumber = 1;
	}
	
	if(upperNumber > [self.theRunes count] -1){
		upperNumber = [self.theRunes count] -1 ;
		lowerNumber = upperNumber -1;
	}
	
	if((upperNumber == 1 && lowerNumber == 0) && [self.pageControllers count] == 1){
		[self SetRunePages: upperNumber lowerNumber: lowerNumber];

	}
	
	if((oldLower != lowerNumber) && (oldUpper != upperNumber)){
		
		oldLower = lowerNumber;
		oldUpper = upperNumber;
		if(upperNumber < [self.pageControllers count]){
			self.currentPage = [self.pageControllers objectAtIndex:upperNumber];
			self.nextPage = [self.pageControllers objectAtIndex:lowerNumber];

			[self.scrollView addSubview:self.currentPage.view];
			[self.scrollView addSubview:self.nextPage.view];
		}
		else{
			
			[self SetRunePages: upperNumber lowerNumber: lowerNumber];

			NSLog(@"Lower: %d", lowerNumber);
			NSLog(@"Upper: %d", upperNumber);
			
		}
	}

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)newScrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
	NSInteger nearestNumber = lround(fractionalPage);

	if (self.currentPage.pageNumber != nearestNumber)
	{
		RuneReadingsViewController *swapController = self.currentPage;
		self.currentPage = self.nextPage;
		self.nextPage = swapController;
	}

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)newScrollView
{
	[self scrollViewDidEndScrollingAnimation:newScrollView];
	self.pageControl.currentPage = self.currentPage.pageNumber;
}

- (IBAction)changePage:(id)sender
{
	NSInteger pageIndex = pageControl.currentPage;

	// update the scroll view to the appropriate page
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * pageIndex;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (void)dealloc
{
	[pageControl release];
	[scrollView release];
	[pageControllers release];
	[theRunes release];
	[currentPage release];
	[nextPage release];
	
	[super dealloc];
}

@end
