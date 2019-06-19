//
//  FDRouter.h
//  FDRouter
//
//  Created by zhangyu528 on 2019/6/19.
//  Copyright © 2019 zhangyu528. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for FDRouter.
FOUNDATION_EXPORT double FDRouterVersionNumber;

//! Project version string for FDRouter.
FOUNDATION_EXPORT const unsigned char FDRouterVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FDRouter/PublicHeader.h>

#if __has_include(<FDRouter/FDRouter.h>)
#import <FDRouter/FDRouterRegParam.h>
#import <FDRouter/UINavigationController+FDRouter.h>
#import <FDRouter/UIViewController+FDRouter.h>
#else
#import "FDRouterRegParam.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface FDRouter : NSObject

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)shared;

- (void)registerRoutes:(NSSet<FDRouterRegParam*>*)routes;

//- (void)navTo:(NSString*)path handle:(nullable FDRouterHandle)handle;
//- (void)navToUrl:(NSURL*)url handle:(nullable FDRouterHandle)handle;
- (nullable UIViewController*)navTo:(NSString*)path;
- (nullable UIViewController*)navToUrl:(NSURL*)url;
- (nullable UIViewController*)navToName:(NSString*)name param:(NSDictionary*)param;

@end

NS_ASSUME_NONNULL_END
