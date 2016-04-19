//
//  BuildMeUp.h
//  BuildMeUp
//
//  Created by Craig Edwards on 19/04/2016.
//  Copyright © 2016 BlackDog Foundry Pty Ltd. All rights reserved.
//

#import <AppKit/AppKit.h>

@class BuildMeUp;

static BuildMeUp *sharedPlugin;

@interface BuildMeUp : NSObject

@property (nonatomic, strong) NSDate *start;

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@end