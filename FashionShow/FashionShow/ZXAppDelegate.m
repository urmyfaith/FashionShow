//
//  ZXAppDelegate.m
//  FashionShow
//
//  Created by zx on 15/2/3.
//  Copyright (c) 2015年 zx. All rights reserved.
//

#import "ZXAppDelegate.h"
#import "INTERFACE.h"

#import "TesTViewController.h"
#import "MainViewController.h"
#import "ZXTabBarVC.h"


/*==========导入友盟的库===========*/
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "TencentOpenAPI/QQApiInterface.h"
#import "TencentOpenAPI/TencentOAuth.h"


@implementation ZXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    [self createUmeng];
    
#define TEST NO
    if (TEST) {
        TesTViewController *tvc = [[TesTViewController alloc]init];
        self.window.rootViewController = tvc;
    }
    else{
        
        
        MainViewController *mvc = [[MainViewController alloc]init];
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mvc];
        nav.navigationBar.hidden = YES;
        self.window.rootViewController = nav;
        
        //ZXTabBarVC *tvc = [[ZXTabBarVC alloc]init];
        //self.window.rootViewController = tvc;
    }
#undef TEST

    NSLog(@"home = %@",NSHomeDirectory());
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


-(void)createUmeng{
    
    [UMSocialData setAppKey:zxYOUMENG_APPKEY];
    
    NSString *url = @"http://zuoxue.sinaapp.com/UISettingResources/userInfo.json";
    
    [UMSocialWechatHandler setWXAppId:zxWEIXIN_APPKEY
                                  url:url];
    
    [UMSocialConfig setQQAppId:zxQQ_APPKEY
                           url:url
                 importClasses:@[[QQApiInterface class],[TencentOAuth class]]];
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
