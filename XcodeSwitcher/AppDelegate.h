//
//  AppDelegate.h
//  XcodeSwitcher
//
//  Created by Jevin Sweval on 1/2/13.
//  Copyright (c) 2013 Arxan Technologies. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
}

@property (assign) IBOutlet NSWindow *window;

@end
