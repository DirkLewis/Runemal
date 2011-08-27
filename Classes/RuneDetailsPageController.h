//
//  RuneDetailsPageController.h
//  Runemal
//
//  Created by Dirk on 4/17/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <QuartzCore/QuartzCore.h>


@interface RuneDetailsPageController : UIViewController <UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    NSMutableArray *viewControllers;
	
	NSDictionary *theRune;
    BOOL pageControlUsed;
	
	CGPoint startTouchPosition;
	NSString *dirString;

}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic, retain) NSDictionary *theRune;

- (void)loadScrollViewWithPage:(UIViewController*)controller :(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;

- (id)initRunePage:(NSString*)nib :(NSDictionary*) therune ;
- (IBAction)changePage:(id)sender;

@end
