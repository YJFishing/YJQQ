//
//  YJTabBarController.m
//  YJQQ
//
//  Created by 包宇津 on 2018/5/31.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJTabBarController.h"
#import "YJMainNavigationController.h"
#import "YJTabBarView.h"
#import "Masonry.h"

@interface YJTabBarController ()<YJTablBarViewDelegate>



@end

@implementation YJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    switch (self.selectedIndex) {
        case 0:
            return _messageViewController.navigationController.supportedInterfaceOrientations;
            break;
        case 1:
            return _contactMessageController.navigationController.supportedInterfaceOrientations;
            break;
        default:
            return _dynamicViewController.navigationController.supportedInterfaceOrientations;
            break;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    switch (self.selectedIndex) {
        case 0:
            return _messageViewController.navigationController.preferredStatusBarStyle;
            break;
        case 1:
            return _contactMessageController.navigationController.preferredStatusBarStyle;
            break;
        default:
            return _dynamicViewController.navigationController.preferredStatusBarStyle;
            break;
    }
}

- (BOOL)prefersStatusBarHidden {
    switch (self.selectedIndex) {
        case 0:
            return _messageViewController.navigationController.prefersStatusBarHidden;
            break;
        case 1:
            return _contactMessageController.navigationController.prefersStatusBarHidden;
            break;
        default:
            return _dynamicViewController.navigationController.prefersStatusBarHidden;
            break;
    }
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _messageViewController = [[YJMessageViewController alloc] init];
    UINavigationController *messageNav = [[YJMainNavigationController alloc] initWithRootViewController:_messageViewController];
    
    _contactMessageController = [[YJContactsViewController alloc] init];
    UINavigationController *contactNav = [[YJMainNavigationController alloc] initWithRootViewController:contactNav];
    
    _dynamicViewController = [[YJDynamicViewController alloc] init];
    UINavigationController *dynamicNav = [[YJMainNavigationController alloc] initWithRootViewController:dynamicNav];
    
    [self addChildViewController:messageNav];
    [self addChildViewController:contactNav];
    [self addChildViewController:dynamicNav];
    
    YJTabBarView *tabBarView = [[YJTabBarView alloc] init];
    tabBarView.delegate = self;
    [self.tabBar addSubview:tabBarView];
    [tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

#pragma mark --YJTabBarViewDelegate--


//主界面在 消息、联系人、动态这三个页面之一
- (BOOL)isUserInMainView {
    BOOL userIsInMain = false;
    switch (self.selectedIndex) {
        case 0:
            userIsInMain = [_messageViewController.navigationController.visibleViewController isKindOfClass:[YJTabMainBaseViewController class]];
            break;
        case 1:
            userIsInMain = [_contactMessageController.navigationController.visibleViewController isKindOfClass:[YJTabMainBaseViewController class]];
            break;
        default:
            userIsInMain = [_dynamicViewController.navigationController.visibleViewController isKindOfClass:[YJTabMainBaseViewController class]];
            break;
    }
    return userIsInMain;
}
@end
