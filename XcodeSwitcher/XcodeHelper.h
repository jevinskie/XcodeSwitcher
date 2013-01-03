//
//  XcodeHelper.h
//  XcodeSwitcher
//
//  Created by Jevin Sweval on 1/2/13.
//  Copyright (c) 2013 Arxan Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XcodeHelper : NSObject {
    
}

+ (NSArray *)getPaths;
+ (NSString *)getCurrentPath;
+ (NSString *)stripContentsDeveloper:(NSString *)path;

@end
