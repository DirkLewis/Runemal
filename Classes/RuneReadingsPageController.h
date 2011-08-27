//
//  RuinReadingsPageController.h
//  Runemal
//
//  Created by Dirk on 4/19/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RuneReadingsPageController : UIViewController <UIScrollViewDelegate> {

	IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    BOOL pageControlUsed;
	CGPoint startTouchPosition;
	NSString *dirString;
	
	NSArray *theRunes;
	int pages;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic, retain) NSArray *theRunes;

- (void)loadScrollViewWithPage:(UIViewController*)controller :(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;
- (IBAction)changePage:(id)sender;
- (id)initRuneReading:(NSString*)nib :(int)pagecount :(NSArray*)runes;
@end
