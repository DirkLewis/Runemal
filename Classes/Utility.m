//
//  Utility.m
//  Runemal
//
//  Created by Dirk on 4/17/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import "Utility.h"


@implementation Utility

+(NSArray*)GetRuneList{
	
	NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"RuneData" ofType:@"plist"]];
	NSLog(@"Rune count is:%d", [array count]);

	if([array count] != 0){
		return array;
	}
	else{
		return nil;
	}
	
}

+(void)PlayAudioChime:(SystemSoundID)sound{
	
	id sndpath = [[NSBundle mainBundle] pathForResource:@"ShortChime" ofType:@"wav"];
	CFURLRef base = (CFURLRef)[[NSURL alloc] initFileURLWithPath:sndpath];
	AudioServicesCreateSystemSoundID(base, &sound);
	AudioServicesPlaySystemSound(sound);

	
}

+(void)PlayAudioClick:(SystemSoundID)sound{
	
	id sndpath = [[NSBundle mainBundle] pathForResource:@"click_off" ofType:@"wav"];
	CFURLRef base = (CFURLRef)[[NSURL alloc] initFileURLWithPath:sndpath];
	AudioServicesCreateSystemSoundID(base, &sound);
	AudioServicesPlaySystemSound(sound);
	
}

+(void)PlayAudioRuneClick:(SystemSoundID)sound{
	
	id sndpath = [[NSBundle mainBundle] pathForResource:@"RuneClick" ofType:@"wav"];
	CFURLRef base = (CFURLRef)[[NSURL alloc] initFileURLWithPath:sndpath];
	AudioServicesCreateSystemSoundID(base, &sound);
	AudioServicesPlaySystemSound(sound);
	
}
 
@end
