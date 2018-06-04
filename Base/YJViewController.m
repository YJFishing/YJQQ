//
//  YJViewController.m
//  YJQQ
//
//  Created by 包宇津 on 2018/6/2.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJViewController.h"

@interface YJViewController ()

@end

@implementation YJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return false;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *subViews = self.tabBarController.tabBar.subviews;
    for (UIView *subview in subViews) {
        if ([subview isKindOfClass:[UIControl class]]) {
            [subview removeFromSuperview];
        }
    }
}
@end
