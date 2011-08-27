//
//  BagShakeController.h
//  Runemal
//
//  Created by Dirk on 4/26/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BagShakeController : NSObject <UIAccelerometerDelegate>{
	UIAccelerationValue	myAccelerometer[3];
	CFTimeInterval		lastTime;

}

@end
