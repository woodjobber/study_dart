#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
    [UMConfigure initWithAppkey:@"5861e5daf5ade41326001eab" channel:@"App Store"];
    BOOL res = [[UMSocialManager defaultManager]  isInstall:UMSocialPlatformType_WechatSession];
    NSLog(@"______ %d",res);
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
