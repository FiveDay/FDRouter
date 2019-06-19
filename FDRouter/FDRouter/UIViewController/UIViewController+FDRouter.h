//
//  UIViewController+FDRouter.h
//  FDControl
//
//  Created by zhangyu528 on 2019/4/17.
//  Copyright © 2019 zhangyu528. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (FDRouter)

+ (instancetype)viewControllerWithParam:(NSDictionary*)param;

- (instancetype)initWithParam:(NSDictionary*)param;

@property(strong, nonatomic, nullable)NSDictionary* param;

@end

NS_ASSUME_NONNULL_END
