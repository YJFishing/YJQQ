//
//  YJNavigationContentViewController.m
//  YJQQ
//
//  Created by 包宇津 on 2018/5/31.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJNavigationContentViewController.h"

#define screenWidth   ([[UIScreen mainScreen] bounds].size.width)
#define screenHeight   ([[UIScreen mainScreen] bounds].size.height)

//打开菜单后，右边留的空间
static CGFloat space = 75;
//打开菜单后，右边的透明度(黑色)
static CGFloat alpha = 0.5;

static NSString *YJSideMenuHideNotification = @"YJSideMenuHideNotification";
static NSString *YJSideMenuShowNotification = @"YJSideMenuShowNotification";
static NSString *YJSideMenuNotificationAnimatedKey = @"YJSideMenuNotificationAnimatedKey";

@interface YJNavigationContentViewController ()

@property (nonatomic, strong) SideMenuViewController *menuController;
@property (nonatomic, strong) YJTabBarController *rootViewController;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, strong) UIView *alphaView;
@property (nonatomic, assign) CGFloat pan_start_x;     //记录移动距离
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
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.menuController = menuViewController;
        self.rootViewController = rootViewController;
        
        [self addChildViewController:menuViewController];
        [self.view addSubview:menuViewController.view];
        [menuViewController.view setFrame:CGRectMake(([YJNavigationContentViewController getSpace]- screenWidth), 0, screenWidth, screenHeight)];
        
        [self addChildViewController:self.rootViewController];
        [self.view addSubview:self.rootViewController.view];
        _rootViewController.view.frame = self.view.bounds;
        [_rootViewController addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        
        self.alphaView = [[UIView alloc] initWithFrame:self.view.bounds];
        _alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];  //0代表透明
        _alphaView.hidden = YES;
        [self.view addSubview:_alphaView];
        
        __weak typeof(self) weakself = self;
        _menuController.pushVCBlock = ^(UIViewController *vc, BOOL animatd) {
            vc.hidesBottomBarWhenPushed = YES;
            NSInteger selectedIndex = weakself.rootViewController.selectedIndex;
            UINavigationController *nav ;
            switch(selectedIndex) {
                case 0:
                   
                    break;
                case 1:
                    
                    break;
                default:
                    break;
            }
        };
        
    }
    return self;
}

+ (CGFloat)getSpace {
    return space;
}

+ (CGFloat)getAlpha {
    return alpha;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.rootViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden {
    return self.rootViewController.prefersStatusBarHidden;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.rootViewController.supportedInterfaceOrientations;
}
@end
