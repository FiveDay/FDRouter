//
//  NSString+FDURL.m
//  FDControl
//
//  Created by zhangyu528 on 2019/4/17.
//  Copyright © 2019 zhangyu528. All rights reserved.
//

#import "NSString+FDURL.h"

@implementation NSString (FDURL)

- (BOOL)isValidURL {
    NSURL *url = [NSURL URLWithString:self];
    if (url) {
        return YES;
    }
    return NO;
}
@end
