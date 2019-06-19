//
//  FDRouter.m
//  FDControl
//
//  Created by zhangyu528 on 2019/4/15.
//  Copyright © 2019 zhangyu528. All rights reserved.
//

#import "FDRouter.h"

#import <UIKit/UIKit.h>
#import "FDRouter.h"
#import "NSBundle+FDMainBundle.h"
#import "UINavigationController+FDRouter.h"
#import "NSString+FDOperator.h"
#import "NSString+FDURL.h"
#import "UIViewController+FDRouter.h"

@interface FDRouter ()
@property(strong, nonatomic)NSSet<FDRouterRegParam*>* routes;
@property(strong, nonatomic)NSMutableDictionary* routeTable;
@property(strong, nonatomic)NSMutableDictionary* nameTable;
@property(strong, nonatomic)NSString* scheme;
@property(strong, nonatomic)NSString* host;
@end

@implementation FDRouter

//+ (instancetype)initialize {
//    if (self == [FDRouter class]) {
//        
//    }
//}

+ (instancetype)shared {
    static FDRouter* _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _host = @"localhost";
        _scheme = [NSBundle firstScheme]?[NSBundle firstScheme]:@"fd";
    }
    return self;
}

- (void)registerRoutes:(NSSet<FDRouterRegParam*>*)routes {
    if (routes == nil || routes.count == 0) {
        return;
    }
    _routes = routes;
    _routeTable = [NSMutableDictionary new];
    _nameTable = [NSMutableDictionary new];
    
    [self parseRouteRegParam];
}

- (NSString*)getAbsoluteUri:(NSString*)path {
    NSString* scheme = [self.scheme stringByAppendingString:@"://"];
    NSString* uri = [[scheme stringByAppendingString:self.host]stringByAppendingFormat:@"/%@", path];
    return uri;
}

- (void)parseRouteRegParam {
    NSArray* ary = [_routes allObjects];
    for (FDRouterRegParam* param in ary) {
        
        NSString* component = [param objectForKey:@"component"];
        FDRouterRedirect redirect = [param objectForKey:@"redirect"];
        NSString* path = [param objectForKey:@"path"];
        path = [path stringByTrimming:@"/"];
        NSString* name = [param objectForKey:@"name"];
        
        NSString* uri = [self getAbsoluteUri:path];
        NSURL* url = [NSURL URLWithString:uri];
        NSURLComponents* urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
        
        if (url) {
            NSMutableDictionary* subRoutes = self.routeTable;
            for (NSString* pathComponent in urlComponents.path.pathComponents) {
                if ([subRoutes objectForKey:pathComponent]) {
                    subRoutes = [subRoutes objectForKey:pathComponent];
                }else {
                    NSMutableDictionary* node = [NSMutableDictionary new];
                    [subRoutes setObject:node forKey:pathComponent];
                    if ([pathComponent isEqual:[uri.pathComponents lastObject]]) {
                        if (name) {
                            [node setObject:name forKey:@"name"];
                            [_nameTable setObject:component forKey:name];
                        }
                        if (component) {
                            [node setObject:component forKey:@"component"];
                        }
                        if (redirect) {
                            [node setObject:redirect forKey:@"redirect"];
                        }
                    }
                    subRoutes = [subRoutes objectForKey:pathComponent];
                }
            }
        };
    }
}

- (NSDictionary*)getQueryparam:(NSURL*)url {
    NSURLComponents* urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSMutableDictionary* param = [NSMutableDictionary new];
    for (NSURLQueryItem* item in urlComponents.queryItems) {
        [param setObject:item.value forKey:item.name];
    }
    return [param copy];
}

- (Class)getClsOfComponent:(NSURL*)url {
    NSURLComponents* urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSDictionary* subRoutes = self.routeTable;
    for (NSString* pathComponent in urlComponents.path.pathComponents) {
        subRoutes = [subRoutes objectForKey:pathComponent];
    }
    Class cls = NSClassFromString([subRoutes objectForKey:@"component"]);
    return cls;
}

- (NSString*)getRedirectPath:(NSString*)path {
    NSString* uri = [self getAbsoluteUri:path];
    NSURL* url = [NSURL URLWithString:uri];
    NSURLComponents* urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSDictionary* subRoutes = self.routeTable;
    for (NSString* pathComponent in urlComponents.path.pathComponents) {
        subRoutes = [subRoutes objectForKey:pathComponent];
    }
    FDRouterRedirect redirect = [subRoutes objectForKey:@"redirect"];
    if (redirect) {
        return redirect(path);
    }
    return path;
}

- (UIViewController*)navTo:(NSString*)path {
    path = [path stringByTrimming:@"/"];
    if (![path isValidURL]) {
        return nil;
    };
    NSString* targetPath = [self getRedirectPath:path];
    NSString* uri = [self getAbsoluteUri:targetPath];
    NSURL* url = [NSURL URLWithString:uri];
    
    Class cls = [self getClsOfComponent:url];
    NSDictionary* param = [self getQueryparam:url];
    UIViewController* ctl = [cls viewControllerWithParam:param];
    return ctl;
}

- (UIViewController*)navToUrl:(NSURL*)url {
    if (!url) {
        return nil;
    }
    NSURLComponents* urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSString* path = urlComponents.path;
    return [self navTo:path];
}

- (UIViewController*)navToName:(NSString*)name param:(NSDictionary*)param {
    if (!name) {
        return nil;
    }
    Class cls = NSClassFromString([self.nameTable objectForKey:name]);
    UIViewController* ctl = [cls viewControllerWithParam:param];
    return ctl;
}
@end
