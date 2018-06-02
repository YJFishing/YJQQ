//
//  SideMenuViewController.m
//  YJQQ
//
//  Created by 包宇津 on 2018/5/31.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "SideMenuViewController.h"
#import "YJNavigationContentViewController.h"
#import "YJCollectionViewController.h"
#import "Masonry.h"

@interface SideMenuViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTopView];
    [self setBottomView];
    [self setTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  --懒加载--
- (NSArray *)imageName {
    if (!_imageName) {
        _imageName = [NSArray arrayWithObjects:@"vip_shadow",@"sidebar_purse",@"sidebar_decoration",@"sidebar_favorit",@"sidebar_album",@"sidebar_file", nil];
    }
    return _imageName;
}

- (NSArray *)text {
    if (!_text) {
        _text = [NSArray arrayWithObjects:@"了解会员特权",@"QQ钱包",@"个性装扮",@"我的收藏",@"我的相册",@"我的文件", nil];
    }
    return _text;
}

#pragma mark --UI--
- (void)setTopView {
    self.topView = [[UIView alloc] init];
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(0);
        make.height.equalTo(@200);
        make.width.equalTo(self.view.mas_width).offset(-[YJNavigationContentViewController getSpace]);
    }];
    
    _bgImageView = [[UIImageView alloc] init];
    _bgImageView.image = [UIImage imageNamed:@"2"];
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgImageView.clipsToBounds = YES;
    [self.topView addSubview:_bgImageView];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.topView);
    }];
}

- (void)setBottomView {
    __weak typeof(self) weakself = self;
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(@49);
    }];
    
    self.settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_settingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [_settingBtn setImage:[UIImage imageNamed:@"sidebar_setting"] forState:UIControlStateNormal];
    [_settingBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:_settingBtn];
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(0);
        make.width.greaterThanOrEqualTo(0);
    }];
    self.nightModeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nightModeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_nightModeBtn setTitle:@"夜间" forState:UIControlStateNormal];
    [_nightModeBtn setImage:[UIImage imageNamed:@"sidebar_nighymode_off"] forState:UIControlStateNormal];
    [_nightModeBtn addTarget:self action:@selector(bottomNightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:_nightModeBtn];
    [_nightModeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(0);
        make.left.equalTo(weakself.settingBtn.mas_right);
        make.width.equalTo(weakself.settingBtn.mas_width);
    }];
    
    self.cmShowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cmShowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cmShowBtn setTitle:@"厘米秀" forState:UIControlStateNormal];
    [_cmShowBtn setImage:[UIImage imageNamed:@"sidebar_cmshow"] forState:UIControlStateNormal];
    [_cmShowBtn addTarget:self action:@selector(bottomCmsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:_cmShowBtn];
    [_cmShowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(0);
        make.left.equalTo(weakself.nightModeBtn.mas_right);
        make.right.equalTo(weakself.bottomView.mas_right).offset(-[YJNavigationContentViewController getSpace]);
        make.width.equalTo(weakself.settingBtn.mas_width);
    }];
}

- (void)setTableView {
    __weak typeof(self) weakself = self;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.view.mas_top);
        make.bottom.mas_equalTo(weakself.bottomView.mas_top);
        make.top.mas_equalTo(weakself.topView.mas_bottom).offset(10);
        make.width.mas_equalTo(weakself.view.mas_width).offset(-[YJNavigationContentViewController getSpace]);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 50;
}

- (void)bottomBtnClick {
    NSLog(@"点击底部设置按钮");
}

- (void)bottomNightBtnClick {
    NSLog(@"点击底部夜间按钮");
}

- (void)bottomCmsBtnClick {
    NSLog(@"点击底部厘米秀按钮");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = self.text[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imageName[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.pushVCBlock != nil) {
        YJCollectionViewController *vc = [[YJCollectionViewController alloc] init];
        self.pushVCBlock(vc, YES);
    }
//    [YJNavigationContentViewController hideMenu:false];
}
@end
