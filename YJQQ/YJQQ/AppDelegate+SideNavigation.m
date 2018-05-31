//
//  AppDelegate+SideNavigation.m
//  YJQQ
//
//  Created by 包宇津 on 2018/5/31.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "AppDelegate+SideNavigation.h"

@implementation AppDelegate (SideNavigation)
- (void)setSideNavigationController {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    SideMenuViewController *sideMenuController = [[SideMenuViewController alloc] init];
    YJTabBarController *rootViewController = [[YJTabBarController alloc] init];
    
    YJNavigationContentViewController *nav = [[YJNavigationContentViewController alloc]initWithMenuViewController:sideMenuController rootViewController:rootViewController];
    
    self.window.rootViewController = nav;
}


- (void)setShortCutItem:(UIApplication *)application {
    if (@available(iOS 9.0,*)) {
        if (application.shortcutItems != nil && application.shortcutItems.count > 0) {
            return;
        }
        UIApplicationShortcutIcon *scanIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"add_icons_saoyisao"];
        UIApplicationShortcutItem *scanItem = [[UIApplicationShortcutItem alloc] initWithType:@"com.YJCoder.scan" localizedTitle:@"扫一扫" localizedSubtitle:nil icon:scanIcon userInfo:nil];
        
        UIApplicationShortcutIcon *addIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"AV_addmem_normal"];
        UIApplicationShortcutItem *addItem = [[UIApplicationShortcutItem alloc] initWithType:@"com.YJCoder.addFriend" localizedTitle:@"加好友" localizedSubtitle:nil icon:addIcon userInfo:nil];
        
        UIApplicationShortcutIcon *chatIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"add_icon_discuss"];
        UIApplicationShortcutItem * chatItem = [[UIApplicationShortcutItem alloc] initWithType:@"com.YJCoder.addChat" localizedTitle:@"发起聊天" localizedSubtitle:nil icon:chatIcon userInfo:nil];
        
        UIApplicationShortcutIcon *payIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"sidebar_puse"];
        UIApplicationShortcutItem *payItem = [[UIApplicationShortcutItem alloc] initWithType:@"com.YJCoder.pay" localizedTitle:@"付款" localizedSubtitle:nil icon:payIcon userInfo:nil];
        
        application.shortcutItems = [NSArray arrayWithObjects:scanItem,addItem,chatItem,payItem, nil];
    }
}
@end
