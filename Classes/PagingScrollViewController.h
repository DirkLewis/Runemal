//
//  PagingScrollViewController.h
//  PagingScrollView
//
//  Created by Matt Gallagher on 24/01/09.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RuneReadingsViewController;

@interface PagingScrollViewController : UIViewController
{
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIPageControl *pageControl;
	NSArray *theRunes;
	RuneReadingsViewController *currentPage;
	RuneReadingsViewController *nextPage;
	NSInteger oldLower;
	NSInteger oldUpper;
	NSInteger pages;
	
	NSMutableArray *pageControllers;
}
@property (nonatomic, retain) NSArray *theRunes;
@property (nonatomic, retain) NSMutableArray *pageControllers;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) RuneReadingsViewController *currentPage;
@property (nonatomic, retain) RuneReadingsViewController *nextPage;

- (id)initRuneReading:(NSString*)nib :(int)pagecount :(NSArray*)runes;


- (IBAction)changePage:(id)sender;

@end
