//
//  UINavigationController+FDRouter.m
//  FDControl
//
//  Created by zhangyu528 on 2019/4/16.
//  Copyright © 2019 zhangyu528. All rights reserved.
//

#import "UINavigationController+FDRouter.h"
#import "FDRouter.h"

@implementation UINavigationController (FDRouter)

+ (void)registerRoutes:(NSSet<FDNavigationRouterRegParam*>*)routes {
    [[FDRouter shared]registerRoutes:routes];
}

- (void)navTo:(NSString*)path {
    UIViewController* viewCtl = [[FDRouter shared]navTo:path];
    [self pushViewController:viewCtl animated:YES];
}

- (void)navToUrl:(NSURL*)url {
    UIViewController* viewCtl = [[FDRouter shared]navToUrl:url];
    [self pushViewController:viewCtl animated:YES];
}

- (void)navToName:(NSString*)name param:(NSDictionary*)param {
    UIViewController* viewCtl = [[FDRouter shared]navToName:name param:param];
    [self pushViewController:viewCtl animated:YES];
}

- (void)presentTo:(NSString*)path {
    UIViewController* viewCtl = [[FDRouter shared]navTo:path];
    [self presentViewController:viewCtl animated:YES completion:nil];
}
- (void)presentToUrl:(NSURL*)url {
    UIViewController* viewCtl = [[FDRouter shared]navToUrl:url];
    [self presentViewController:viewCtl animated:YES completion:nil];
}
- (void)presentToName:(NSString*)name param:(nullable NSDictionary*)param {
    UIViewController* viewCtl = [[FDRouter shared]navToName:name param:param];
    [self presentViewController:viewCtl animated:YES completion:nil];
}
@end
