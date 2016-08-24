//
//  AppDelegate.m
//  OCToCollectionView
//
//  Created by 李天空 on 16/6/20.
//  Copyright © 2016年 李天空. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] init];
    
    HomeController * home = [[HomeController alloc] init];
    
    UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:home];
    
    
    self.window.rootViewController = nc;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
