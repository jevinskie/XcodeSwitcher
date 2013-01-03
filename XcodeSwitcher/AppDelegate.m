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
    statusMenu = [[NSMenu alloc] initWithTitle:@"Xcode"];
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    statusItem.menu = statusMenu;
    statusItem.title = [statusMenu title];
    statusItem.highlightMode = YES;
    [self updateMenu];
}

- (void)updateMenu {
    [statusMenu addItemWithTitle:[[NSString alloc] initWithFormat:@"Current: %@", [XcodeHelper getCurrentPath]] action:nil keyEquivalent:@""];
    int i = 1;
    for (NSString *path in [XcodeHelper getPaths]) {
        NSString *key;
        if (i < 9) {
            key = [[NSString alloc] initWithFormat:@"%d", i];
        } else {
            key = @"";
        }
        i++;
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:path action:@selector(clicked:) keyEquivalent:key];
        item.target = self;
        [statusMenu addItem:item];
    }
}

- (void)clicked:(NSMenuItem *)item {
    NSLog(@"clicked %@", item.title);
}

@end
