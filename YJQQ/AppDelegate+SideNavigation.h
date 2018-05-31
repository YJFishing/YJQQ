//
//  AppDelegate+SideNavigation.h
//  YJQQ
//
//  Created by 包宇津 on 2018/5/31.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "AppDelegate.h"
#import "SideMenuViewController.h"
#import "YJNavigationContentViewController.h"
@interface AppDelegate (SideNavigation)

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler;
- (void)setShortCutItem:(UIApplication *)application;
- (void)setSideNavigationController;
@end
