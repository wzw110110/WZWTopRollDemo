//
//  AppDelegate.m
//  WZWTopRollDemo
//
//  Created by iOS on 16/7/1.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "AppDelegate.h"
#import "WZWTabbarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    WZWTabbarController * wzwTabbar = [[WZWTabbarController alloc]init];
    self.window.rootViewController = wzwTabbar;
    
    return YES;
}


@end
