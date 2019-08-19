# FDRouter
FDRouter is an in-app native URL router, for iOS.

## Feature
* 统一管理URL注册.
* 解耦URL和ViewController绑定.
* 扩展UINavigationController.
* 支持push/present两种方式展现页面.
* 支持通过url/path/name方式打开页面.
* 支持重定向页面.
## Installation
### Carthage
For Carthage, add the following to your Cartfile:

github "FiveDay/FDRouter"

## Getting Started

```objc

#import <FDRouter/FDRouter.h>
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

      NSSet* routes = [NSSet setWithArray:@[
          @{
              @"path":@"Main/NSObjectDemo",
              @"component":@"NSObjectViewController",
              @"name":@"nsobject"
            },
             @{
              @"path":@"Main/AudioFrequencyDemo",
              @"name":@"audio",
              @"component":@"AudioFrequencySpectrumDemoViewController"
            },
      ];

     [UINavigationController registerRoutes:routes];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options
{
  return [self.navigationController navToUrl:url];
}
```


