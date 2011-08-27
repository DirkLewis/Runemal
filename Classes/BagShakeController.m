//
//  BagShakeController.m
//  Runemal
//
//  Created by Dirk on 4/26/09.
//  Copyright 2009 VideoHooHaa.com. All rights reserved.
//

#import "BagShakeController.h"
#import "Constants.h"
#import "Utility.h"


@implementation BagShakeController

-(id)init{
	
	if (self = [super init]) {
		//Configure and enable the accelerometer
		[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
		[[UIAccelerometer sharedAccelerometer] setDelegate:self];
    }
	return self;
}

// Called when the accelerometer detects motion; plays the erase sound and redraws the view if the motion is over a threshold.
- (void) accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
	UIAccelerationValue				length,
	x,
	y,
	z;
	
	//Use a basic high-pass filter to remove the influence of the gravity
	myAccelerometer[0] = acceleration.x * kFilteringFactor + myAccelerometer[0] * (1.0 - kFilteringFactor);
	myAccelerometer[1] = acceleration.y * kFilteringFactor + myAccelerometer[1] * (1.0 - kFilteringFactor);
	myAccelerometer[2] = acceleration.z * kFilteringFactor + myAccelerometer[2] * (1.0 - kFilteringFactor);
	// Compute values for the three axes of the acceleromater
	x = acceleration.x - myAccelerometer[0];
	y = acceleration.y - myAccelerometer[0];
	z = acceleration.z - myAccelerometer[0];
	
	//Compute the intensity of the current acceleration 
	length = sqrt(x * x + y * y + z * z);
	// If above a given threshold, play the erase sounds and erase the drawing view
	if((length >= kEraseAccelerationThreshold) && (CFAbsoluteTimeGetCurrent() > lastTime + kMinEraseInterval)) {
		
		NSLog(@"Hey I Was Shook");
		[[NSNotificationCenter defaultCenter] postNotificationName:@"BagShook" object:self];		

		lastTime = CFAbsoluteTimeGetCurrent();
	}
}

@end
