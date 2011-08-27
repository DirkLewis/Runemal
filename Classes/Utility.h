//
//  Utility.h
//  Runemal
//
//  Created by Dirk on 4/17/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Utility : NSObject {

}

+(NSArray*)GetRuneList;
+(void)PlayAudioClick:(SystemSoundID)sound;
+(void)PlayAudioChime:(SystemSoundID)sound;
+(void)PlayAudioRuneClick:(SystemSoundID)sound;

@end
