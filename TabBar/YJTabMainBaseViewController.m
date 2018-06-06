//
//  YJTabMainBaseViewController.m
//  YJQQ
//
//  Created by 包宇津 on 2018/6/4.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJTabMainBaseViewController.h"
#import "YJNavigationContentViewController.h"
#import "YJSearchBar.h"
#import "Masonry.h"
#import <UIImageView+WebCache.h>

@interface YJTabMainBaseViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YJTabMainBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTable];
    [self setLeftBarItem];
    [self setRightBarItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg_message"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTable {
    __weak typeof(self) weakself = self;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(weakself.view);
    }];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 65;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    YJSearchBar *searchBar = [[YJSearchBar alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    searchBar.placeholder = @"搜索";
    searchBar.delegate = self;
    _tableView.tableHeaderView = searchBar;
}

- (void)setLeftBarItem {
    UIImageView *avatarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    avatarImg.layer.cornerRadius = 20;
    avatarImg.clipsToBounds = YES;
    [avatarImg setUserInteractionEnabled:YES];
    [avatarImg sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528110863252&di=9fc3524aa979db12e706a2794e9fe7ef&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201411%2F16%2F20141116001507_KczEw.png"] placeholderImage:[UIImage imageNamed:@"login_avatar_default"] options:SDWebImageRetryFailed];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftBarItemTap)];
    [avatarImg addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(leftBarItemLongPress)];
    [avatarImg addGestureRecognizer:longPress];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:avatarImg];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

- (void)setRightBarItem {
    
}

- (void)leftBarItemTap {
    NSLog(@"点击LeftBarItemTap!");

}

- (void)leftBarItemLongPress {
    NSLog(@"长按LeftBarItemTap!");
}

#pragma mark --UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
@end
