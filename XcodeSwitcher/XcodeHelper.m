//
//  XcodeHelper.m
//  XcodeSwitcher
//
//  Created by Jevin Sweval on 1/2/13.
//  Copyright (c) 2013 Arxan Technologies. All rights reserved.
//

#import "XcodeHelper.h"

@implementation XcodeHelper

static NSArray *xcodePaths;

+ (NSArray *)getPaths {
    NSMetadataQuery *query = [[NSMetadataQuery alloc] init];
    query.predicate = [NSPredicate predicateWithFormat:@"kMDItemContentTypeTree == 'com.apple.application-bundle' && (kMDItemExecutableArchitectures == 'ppc' || kMDItemExecutableArchitectures == 'i386' || kMDItemExecutableArchitectures == 'x86_64')"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                          selector: @selector(queryFinished:)
                                          name:NSMetadataQueryDidFinishGatheringNotification
                                          object:query];
    [query startQuery];
    CFRunLoopRun();
    return xcodePaths;
}

+ (void)queryFinished:(NSNotification *)notification {
    NSMetadataQuery *query = [notification object];
    
    NSMutableArray *appPaths = [[NSMutableArray alloc] init];
    NSMutableArray *xps = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < [query resultCount]; i++) {
        NSMetadataItem *app = [query resultAtIndex:i];
        NSString *path = [app valueForAttribute:(NSString *)kMDItemPath];
        [appPaths addObject:path];
    }
    
    for (NSString *path in appPaths) {
        NSString *sent = [path stringByAppendingPathComponent:@"/Contents/Developer"];
        NSURL *sent_url = [NSURL fileURLWithPath:sent isDirectory:YES];
        if ([sent_url checkResourceIsReachableAndReturnError:nil]) {
            [xps addObject:path];
        }
    }
    
    xcodePaths = [NSArray arrayWithArray:xps];
    
    // stop the new run loop
    CFRunLoopStop(CFRunLoopGetCurrent());
}

+ (NSString *)stripContentsDeveloper:(NSString *)pathWithContentsDeveloper {
    NSArray *path_comp = [pathWithContentsDeveloper pathComponents];
    NSRange range;
    range.location = 0;
    range.length = [path_comp count] - 2;
    NSString *path = [NSString pathWithComponents:[path_comp subarrayWithRange:range]];
    return path;
}

+ (NSString *)getCurrentPath {
    NSString *path_w_cd = [@"/usr/share/xcode-select/xcode_dir_link" stringByResolvingSymlinksInPath];
    return [self stripContentsDeveloper:path_w_cd];
}

@end
