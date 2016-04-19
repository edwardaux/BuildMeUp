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

-(BOOL)bmu_displayInSeconds {
	NSString *key = [self keyForField:@"displayInSeconds"];
	return [self boolForKey:key];
}
-(NSTimeInterval)bmu_buildTime {
	NSString *key = [self keyForField:@"build"];
	return [self doubleForKey:key];
}
-(void)bmu_setBuildTime:(NSTimeInterval)time {
	NSString *key = [self keyForField:@"build"];
	[self setValue:@(time) forKey:key];
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

-(NSString *)keyForField:(NSString *)fieldName {
	NSString *projectName = [self projectName];
	return [NSString stringWithFormat:@"BuildMeUp_%@_%@", projectName, fieldName];
}

@end
