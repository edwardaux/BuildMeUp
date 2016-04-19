//
//  NSUserDefaults+Extension.h
//  BuildMeUp
//
//  Created by Craig Edwards on 19/04/2016.
//  Copyright © 2016 BlackDog Foundry Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Extension)

-(BOOL)bmu_displayInSeconds;
-(NSTimeInterval)bmu_buildTime;
-(void)bmu_setBuildTime:(NSTimeInterval)time;

@end
