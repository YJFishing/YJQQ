//
//  YJSingleChatViewController.m
//  YJQQ
//
//  Created by 包宇津 on 2018/6/12.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJSingleChatViewController.h"
#import "Masonry.h"

@interface YJSingleChatViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@end

@implementation YJSingleChatViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    [self.navigationController.navigationBar setBarTintColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTable];
    [self setLeftNavBarItem ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTable {
    __weak typeof(self) weakself = self;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.view.mas_left);
        make.right.mas_equalTo(weakself.view.mas_right);
        make.top.mas_equalTo(weakself.view.mas_top);
        make.bottom.mas_equalTo(weakself.view.mas_bottom);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 65;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 74, 0, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)setLeftNavBarItem {
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"aio_back_arrow"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)back {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg_message"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.contentView.backgroundColor = [UIColor colorWithRed:(arc4random() % 256) / 255.0 green:(CGFloat)(arc4random() % 256) / 255.0 blue:(arc4random() % 256) / 255.0 alpha:1.0];
    return cell;
}
@end
