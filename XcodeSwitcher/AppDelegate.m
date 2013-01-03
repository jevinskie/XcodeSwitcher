//
//  AppDelegate.m
//  XcodeSwitcher
//
//  Created by Jevin Sweval on 1/2/13.
//  Copyright (c) 2013 Arxan Technologies. All rights reserved.
//

#import "AppDelegate.h"
#import "XcodeHelper.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"start");
    statusMenu = [[NSMenu alloc] initWithTitle:@"Xcode"];
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setTitle:[statusMenu title]];
    [statusItem setHighlightMode:YES];
    NSLog(@"paths: %@", [XcodeHelper getPaths]);
    [self updateMenu];
    NSLog(@"end");
}

- (void)updateMenu {
    [statusMenu addItemWithTitle:[[NSString alloc] initWithFormat:@"Current: %@", [XcodeHelper getCurrentPath]] action:nil keyEquivalent:@""];
    for (NSString *path in [XcodeHelper getPaths]) {
        [statusMenu addItemWithTitle:path action:nil keyEquivalent:@""];
    }
}

@end
