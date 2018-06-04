//
//  YJMainNavigationController.m
//  YJQQ
//
//  Created by 包宇津 on 2018/6/4.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJMainNavigationController.h"

@interface YJMainNavigationController ()

@end

@implementation YJMainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg_message"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self setNavigationBarHidden:false animated:false];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.visibleViewController.supportedInterfaceOrientations ? (self.visibleViewController.supportedInterfaceOrientations): UIInterfaceOrientationMaskPortrait;
}

- (BOOL)prefersStatusBarHidden {
    return self.visibleViewController.prefersStatusBarHidden ? (self.visibleViewController.prefersStatusBarHidden):false;
}


@end
