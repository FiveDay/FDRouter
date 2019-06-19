//
//  FDRouterRegParam.m
//  FDControl
//
//  Created by zhangyu528 on 2019/4/15.
//  Copyright © 2019 zhangyu528. All rights reserved.
//

#import "FDRouterRegParam.h"

@implementation FDRouterRegParam

- (NSUInteger)hash {
    return YES;
}

- (BOOL)isEqual:(id)object {
    
    if (self == object) {
        return YES;
    }
    
    if ([object isMemberOfClass:[FDRouterRegParam class]]) {
        FDRouterRegParam* regObj = object;
        if ([regObj objectForKey:@"path"]
            &&[self objectForKey:@"path"]) {
            if ([regObj[@"path"] isEqualToString:self[@"path"]]) {
                return YES;
            }
        }
    }
    return NO;
}
@end
