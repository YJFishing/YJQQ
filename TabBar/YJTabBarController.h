//
//  YJTabBarController.h
//  YJQQ
//
//  Created by 包宇津 on 2018/5/31.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJMessageViewController.h"
#import "YJContactsViewController.h"
#import "YJDynamicViewController.h"

@interface YJTabBarController : UITabBarController
@property (nonatomic, strong) YJMessageViewController *messageViewController;
@property (nonatomic,strong) YJContactsViewController *contactMessageController;
@property (nonatomic, strong) YJDynamicViewController *dynamicViewController;
@end
