//
//  RuneListViewController.h
//  Runemal
//
//  Created by Dirk on 4/17/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
@class RuneLibraryDataModel;


@interface RuneListViewController : UITableViewController {
	
	NSArray *runeData;
	SystemSoundID click;
}
@property (nonatomic, retain) NSArray *runeData;

@end
