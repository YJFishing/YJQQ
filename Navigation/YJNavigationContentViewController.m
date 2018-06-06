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

@interface YJNavigationContentViewController ()<UIGestureRecognizerDelegate>

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

- (void)dealloc {
    
    [self.rootViewController.view removeObserver:self forKeyPath:@"frame"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (YJNavigationContentViewController *)initWithMenuViewController:(SideMenuViewController *)menuViewController rootViewController:(YJTabBarController *)rootViewController {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.menuController = menuViewController;
        self.rootViewController = rootViewController;
        
        [self addChildViewController:menuViewController];
        [self.view addSubview:menuViewController.view];
        [menuViewController.view setFrame:CGRectMake(([YJNavigationContentViewController getSpace]- screenWidth) / 2.0, 0, screenWidth, screenHeight)];
        
        [self addChildViewController:self.rootViewController];
        [self.view addSubview:self.rootViewController.view];
        _rootViewController.view.frame = self.view.bounds;
        [_rootViewController.view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        
        self.alphaView = [[UIView alloc] initWithFrame:self.view.bounds];
        _alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];  //0代表透明
        _alphaView.hidden = YES;
        [self.view addSubview:_alphaView];
        
        __weak typeof(self) weakself = self;
        _menuController.pushVCBlock = ^(UIViewController *vc, BOOL animatd) {
            vc.hidesBottomBarWhenPushed = YES;
            NSInteger selectedIndex = weakself.rootViewController.selectedIndex;
            UINavigationController *nav = nil;
            switch(selectedIndex) {
                case 0:
                    nav = weakself.rootViewController.messageViewController.navigationController;
                    break;
                case 1:
                    nav = weakself.rootViewController.contactMessageController.navigationController;
                    break;
                default:
                    nav = weakself.rootViewController.dynamicViewController.navigationController;
                    break;
            }
            [nav pushViewController:vc animated:YES];
        };
        
        //点击灰色部分 关闭菜单
        UITapGestureRecognizer *hideMenuTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenuTap:)];
        [self.alphaView addGestureRecognizer:hideMenuTap];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
        pan.delegate = self;
        [self.view addGestureRecognizer:pan];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideMenuTap:) name:YJSideMenuShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getShowMenu:) name:YJSideMenuShowNotification object:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"frame"]) {
        CGRect newFrame = [change[NSKeyValueChangeNewKey] CGRectValue];
        _alphaView.frame = newFrame;
        [_alphaView setHidden:_alphaView.frame.origin.x == 0];
    }
}
- (void)hideMenuTap:(UIGestureRecognizer *)gesture {
    [self hideMenu:true];
}

- (void)hideMenu:(BOOL)animated {
    UIView *rootView = self.rootViewController.view;
    UIView *menuView = self.menuController.view;
    
    if (animated) {
        CGFloat duration = [self getAnimationDuration:false];
        [UIView animateWithDuration:duration animations:^{
            CGRect menuViewFrame = menuView.frame;
            menuViewFrame.origin.x = [YJNavigationContentViewController getSpace] - screenWidth;
            menuView.frame = menuViewFrame;
            
            CGRect rootViewFrame = rootView.frame;
            rootViewFrame.origin.x = 0;
            rootView.frame = rootViewFrame;
            
            self.alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        } completion:nil];
    }else {
        CGRect menuViewFrame = menuView.frame;
        menuViewFrame.origin.x = [YJNavigationContentViewController getSpace] - screenWidth;
        menuView.frame = menuViewFrame;
        
        CGRect rootViewFrame = rootView.frame;
        rootViewFrame.origin.x = 0;
        rootView.frame = rootViewFrame;
        
        self.alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    }
}

- (CGFloat)getAnimationDuration:(BOOL)isShownDuration {
    CGFloat allDuration = 0.2;
    CGFloat distance = 0;
    if (isShownDuration) {
        distance = [self getDistance] - self.rootViewController.view.frame.origin.x;
    }else {
        distance = self.rootViewController.view.frame.origin.x;
    }
    return allDuration / (distance / [self getDistance]);
}

- (void)edgePanGesture:(UIPanGestureRecognizer *)edgePan {
    UIView *rootView = self.rootViewController.view;
    UIView *menuView = self.menuController.view;
    
    if (edgePan.state == UIGestureRecognizerStateBegan) {
        CGFloat startPointX = [edgePan locationInView:rootView].x;
        self.pan_start_x = startPointX;
    }
    
    //不是从左边开始拖动则无效
    if (self.pan_start_x >= 40 && rootView.frame.origin.x == 0) {
        return;
    }
    
    //移动距离
    CGFloat translationX = [edgePan translationInView:rootView].x;
    CGFloat rootViewX = rootView.frame.origin.x;
    CGFloat menuViewX = menuView.frame.origin.x;
    
    //rootView边界
    rootViewX = MIN(rootViewX + translationX, (screenWidth - [YJNavigationContentViewController getSpace]));
    rootViewX = MAX(rootViewX, 0);
    
    //menuView边界
    menuViewX = MIN(menuViewX + translationX / 2.0, 0);
    menuViewX = MAX(menuViewX, ([YJNavigationContentViewController getSpace] - screenWidth) / 2.0);
    
    
    CGRect rootViewFrame = rootView.frame;
    rootViewFrame.origin.x = rootViewX;
    rootView.frame = rootViewFrame;
    
    CGRect menuViewFrame = menuView.frame;
    menuViewFrame.origin.x = menuViewX;
    menuView.frame = menuViewFrame;
    
    _alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: [YJNavigationContentViewController getAlpha] * (rootView.frame.origin.x / (screenWidth - [YJNavigationContentViewController getSpace]))];
    
    [edgePan setTranslation:CGPointZero inView:rootView];
    
    if (edgePan.state == UIGestureRecognizerStateEnded || edgePan.state == UIGestureRecognizerStateCancelled) {
        if (rootViewX >= ([self getDistance] / 2.0)) {
            [self showMenu:true];
        }else {
            [self hideMenu:true];
        }
    }
        
    
}

- (void)showMenu:(BOOL)animated {
    UIView *rootView = self.rootViewController.view;
    UIView *menuView = self.menuController.view;
    
    if (animated) {
        CGFloat duration = [self getAnimationDuration:true];
        [UIView animateWithDuration:duration animations:^{
            CGRect menuViewFrame = menuView.frame;
            menuViewFrame.origin.x = 0;
            menuView.frame = menuViewFrame;
            
            CGRect rootViewFrame = rootView.frame;
            rootViewFrame.origin.x = screenWidth - [YJNavigationContentViewController getSpace];
            rootView.frame = rootViewFrame;
            
            self.alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:[YJNavigationContentViewController getAlpha]];
        } completion:nil];
    }else {
        CGRect menuViewFrame = menuView.frame;
        menuViewFrame.origin.x = 0;
        menuView.frame = menuViewFrame;
        
        CGRect rootViewFrame = rootView.frame;
        rootViewFrame.origin.x = screenWidth - [YJNavigationContentViewController getSpace];
        rootView.frame = rootViewFrame;
        
        self.alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:[YJNavigationContentViewController getAlpha]];
    }
}
#pragma mark 外部调用显示/隐藏菜单
- (void)getShowMenu:(NSNotification *)notification {
    NSDictionary *dic = [notification userInfo];
    BOOL animated = [dic valueForKey:YJSideMenuNotificationAnimatedKey];
    [self hideMenu:animated];
}

- (void)getHideMenu:(NSNotification *)notification {
    NSDictionary *dic = [notification userInfo];
    BOOL animated = [dic objectForKey:YJSideMenuNotificationAnimatedKey];
    [self hideMenu:animated];
}

- (CGFloat)getDistance {
    return screenWidth - [YJNavigationContentViewController getSpace];
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

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == _pan) {
        BOOL userIsInMain = [_rootViewController isUserInMainView];
        if (!userIsInMain) {
            return false;
        }
    }
    return true;
}
@end
