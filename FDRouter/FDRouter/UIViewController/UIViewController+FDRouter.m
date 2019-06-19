//
//  UIViewController+FDRouter.m
//  FDControl
//
//  Created by zhangyu528 on 2019/4/17.
//  Copyright © 2019 zhangyu528. All rights reserved.
//

#import "UIViewController+FDRouter.h"
#import <objc/runtime.h>

@implementation UIViewController (FDRouter)

static char kAssociatedParamObjectKey;

+ (instancetype) viewControllerWithParam:(NSDictionary*)param {
    return [[self alloc]initWithParam:param];
}

- (instancetype)initWithParam:(NSDictionary*)param {
    if (self = [self init]) {
        self.param = param;
    }
    return self;
}

- (void)setParam:(NSDictionary *)paramDictionary
{
    objc_setAssociatedObject(self, &kAssociatedParamObjectKey, paramDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)param
{
    return objc_getAssociatedObject(self, &kAssociatedParamObjectKey);
}
@end
