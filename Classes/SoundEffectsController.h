//
//  SoundEffectsController.h
//  Runemal
//
//  Created by Dirk on 4/20/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundEffectsController : NSObject  <AVAudioPlayerDelegate>{
	
}


-(void)StartSoundTrack:(NSString*)soundtrackname :(NSString*)ext :(int)number;

@end
