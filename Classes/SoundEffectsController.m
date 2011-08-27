//
//  SoundEffectsController.m
//  Runemal
//
//  Created by Dirk on 4/20/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import "SoundEffectsController.h"


@implementation SoundEffectsController

-(void)StartSoundTrack:(NSString*)soundtrackname :(NSString*)ext :(int)number{
	
	AVAudioPlayer *soundtrack;
	NSString *backgroundmusicpath = [[NSBundle mainBundle] pathForResource:soundtrackname ofType:ext];
	soundtrack = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:backgroundmusicpath] error:nil];
	
	soundtrack.delegate = self;
	
	[soundtrack prepareToPlay];
	[soundtrack play];
	
	soundtrack.numberOfLoops = number;
	
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
	
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
	NSLog(@"Error: %d",[error code]);
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
	//use the url to find what file was played if you need to send notifications.
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player{
	
}

-(void)dealloc{
	
	[super dealloc];
}

@end
