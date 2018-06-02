//
//  YJNavigationContentViewController.m
//  YJQQ
//
//  Created by 包宇津 on 2018/5/31.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJNavigationContentViewController.h"

//打开菜单后，右边留的空间
static CGFloat space = 75;
//打开菜单后，右边的透明度(黑色)
static CGFloat alpha = 0.5;
@interface YJNavigationContentViewController ()

@end

@implementation YJNavigationContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (YJNavigationContentViewController *)initWithMenuViewController:(SideMenuViewController *)menuViewController rootViewController:(YJTabBarController *)rootViewController {
    return [[YJNavigationContentViewController alloc] init];
}

+ (CGFloat)getSpace {
    return space;
}

+ (CGFloat)getAlpha {
    return alpha;
}
@end
