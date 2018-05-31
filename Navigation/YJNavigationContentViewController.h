//
//  YJNavigationContentViewController.h
//  YJQQ
//
//  Created by 包宇津 on 2018/5/31.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuViewController.h"
#import "YJTabBarController.h"

@interface YJNavigationContentViewController : UIViewController
- (YJNavigationContentViewController *)initWithMenuViewController:(SideMenuViewController*)menuViewController rootViewController:(YJTabBarController *)rootViewController;
@end
