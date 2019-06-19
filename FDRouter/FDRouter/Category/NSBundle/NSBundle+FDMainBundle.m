//
//  NSBundle+FDMainBundle.m
//  FDControl
//
//  Created by zhangyu528 on 2019/4/16.
//  Copyright © 2019 zhangyu528. All rights reserved.
//

#import "NSBundle+FDMainBundle.h"

@implementation NSBundle (FDMainBundle)

+ (NSString*)firstScheme {
    NSString* scheme;
    NSArray* types = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleURLTypes"];
    if ([types count] > 0) {
        NSArray* schemes = [types[0]objectForKey:@"CFBundleURLSchemes"];
        if ([schemes count] > 0) {
            scheme = schemes[0];
        }
    }
    return scheme;
}

@end
