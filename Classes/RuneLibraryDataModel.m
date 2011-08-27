//
//  RuneLibraryDataModel.m
//  Runemal
//
//  Created by Dirk on 4/17/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import "RuneLibraryDataModel.h"


@implementation RuneLibraryDataModel

@synthesize theRunes;

-(void)init{
	
	NSLog(@"Rune Library Data Model Fired");
	
	NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"RuneData" ofType:@"plist"]];
	
	if([array count] != 0){
		theRunes = [NSArray arrayWithArray:array];
	}
	
	NSLog(@"Rune count is:%d", [theRunes count]);
	
	[super init];
}

- (void)dealloc {
	[theRunes release];
    [super dealloc];
}
@end
