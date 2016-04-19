//
//  BuildMeUp.m
//  BuildMeUp
//
//  Created by Craig Edwards on 19/04/2016.
//  Copyright © 2016 BlackDog Foundry Pty Ltd. All rights reserved.
//

#import "BuildMeUp.h"
#import "JRSwizzle.h"
#import "NSUserDefaults+Extension.h"

@interface IDEBuildSystemActivityReporter
-(NSAttributedString *)attributedResultStringForBuildOperation:(id)object;
@end

@implementation NSObject (SwizzledMethods)

-(NSAttributedString *)bmu_attributedResultStringForBuildOperation:(id)object {
	// ask the original method for the string to display
	NSAttributedString *original = [self bmu_attributedResultStringForBuildOperation:object];

	// generate some info to append to it
	NSTimeInterval buildTime = [[NSUserDefaults standardUserDefaults] bmu_buildTime];
	NSString *timing = [NSString stringWithFormat:@" [%.2f secs]", buildTime];

	// append and return
	NSMutableAttributedString *modified = [original mutableCopy];
	[modified appendAttributedString:[[NSAttributedString alloc] initWithString:timing]];
	return modified;
}

@end

@implementation BuildMeUp

+(instancetype)sharedPlugin {
	return sharedPlugin;
}

-(id)initWithBundle:(NSBundle *)plugin {
	if (self = [super init]) {
		// these are the two events that signify that a build is starting / ending
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didStartBuild:) name:@"IDEBuildOperationWillStartNotification" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didStopBuild:) name:@"IDEBuildOperationDidStopNotification" object:nil];

		// we need to swizzle the -[IDEBuildSystemActivityReporter attributedResultStringForBuildOperation:]
		// method as that is the one that displays the results in the activity view
		NSError *error = nil;
		Class clazz = NSClassFromString(@"IDEBuildSystemActivityReporter");
		if (![clazz jr_swizzleMethod:@selector(attributedResultStringForBuildOperation:) withMethod:@selector(bmu_attributedResultStringForBuildOperation:) error:&error]) {
			NSLog(@"Unable to swizzle title method: %@", error);
		}
	}
	return self;
}

-(void)didStartBuild:(NSNotification*)notification {
	// start the timer
	self.start = [NSDate date];
}

-(void)didStopBuild:(NSNotification*)notification {
	// finish the timer, and add the difference to the previous total
	NSDate *now = [NSDate date];
	NSTimeInterval diff = [now timeIntervalSinceDate:self.start];
	NSTimeInterval total = [[NSUserDefaults standardUserDefaults] bmu_buildTime];
	[[NSUserDefaults standardUserDefaults] bmu_setBuildTime:total+diff];
}

-(void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
