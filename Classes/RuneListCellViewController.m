//
//  RuneListCellViewController.m
//  Runemal
//
//  Created by Dirk on 4/17/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import "RuneListCellViewController.h"
#import "Constants.h"


@implementation RuneListCellViewController

@synthesize runeName;
@synthesize runeImage;
/*
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {

        // Initialization code
    }
    return self;
}
*/
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	[runeName release];
	[runeImage release];
    [super dealloc];
}


@end
