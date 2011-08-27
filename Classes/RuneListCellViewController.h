//
//  RuneListCellViewController.h
//  Runemal
//
//  Created by Dirk on 4/17/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RuneListCellViewController : UITableViewCell {

	UIImageView *runeImage;
	UILabel *runeName;
}

@property (nonatomic, retain) IBOutlet UIImageView *runeImage;
@property (nonatomic, retain) IBOutlet UILabel *runeName;
@end
