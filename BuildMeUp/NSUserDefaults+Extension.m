//
//  NSUserDefaults+Extension.m
//  BuildMeUp
//
//  Created by Craig Edwards on 19/04/2016.
//  Copyright © 2016 BlackDog Foundry Pty Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSUserDefaults+Extension.h"

@implementation NSUserDefaults (Extension)

-(NSTimeInterval)bmu_buildTime {
	return [self bmu_timeForField:@"build"];
}
-(void)bmu_setBuildTime:(NSTimeInterval)time {
	[self bmu_setTime:time forField:@"build"];
}

#
#pragma mark - Private methods
#
/** Figures out the project name of the current (focused) project */
-(NSString *)projectName {
	NSArray *workspaceWindowControllers = [NSClassFromString(@"IDEWorkspaceWindowController") valueForKey:@"workspaceWindowControllers"];
	id workspace = nil;
	for (id controller in workspaceWindowControllers) {
		if ([[controller valueForKey:@"window"] isEqual:[NSApp keyWindow]]) {
			workspace = [controller valueForKey:@"_workspace"];
		}
	}
	return [workspace valueForKey:@"name"];
}

/** Returns a time value for a specific field name */
-(NSTimeInterval)bmu_timeForField:(NSString *)fieldName {
	NSString *projectName = [self projectName];
	NSString *key = [NSString stringWithFormat:@"BuildMeUp_%@_%@", projectName, fieldName];
	return [self doubleForKey:key];
}

/** Stores a time value for a specific field name */
-(void)bmu_setTime:(NSTimeInterval)time forField:(NSString *)fieldName {
	NSString *projectName = [self projectName];
	NSString *key = [NSString stringWithFormat:@"BuildMeUp_%@_%@", projectName, fieldName];
	[self setValue:@(time) forKey:key];
}

@end
