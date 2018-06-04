//
//  YJContactsViewController.m
//  YJQQ
//
//  Created by 包宇津 on 2018/6/4.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJContactsViewController.h"

@interface YJContactsViewController ()

@end

@implementation YJContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"联系人";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
