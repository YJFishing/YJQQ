//
//  YJMessageViewController.m
//  YJQQ
//
//  Created by 包宇津 on 2018/6/4.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJMessageViewController.h"


@interface YJMessageViewController ()

@property (nonatomic, strong) NSMutableArray<YJMessageListModel *> *dataSource;

@end

@implementation YJMessageViewController

- (NSArray<YJMessageListModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self mockData];
    self.title = @"消息";
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_plus"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mockData {
    NSInteger time0 = 1498200913000;
    NSInteger time1 = 1498200913000;
    NSInteger time2 = 1498200913000;
    NSInteger time3 = 1498143309000;
    NSInteger time4 = 1478143309000;
    NSDictionary *dic1 = @{@"icon":@"https://qlogo1.store.qq.com/qzone/291491692/291491692/100",@"title":@"我是第一条标题",@"lastMessage":@"我是第一条消息",@"time":[NSNumber numberWithInteger:time0],@"badge":[NSNumber numberWithInteger:4],@"notDisturb":[NSNumber numberWithBool:YES]};
    NSDictionary *dic2 = @{@"iocn":@"https://qlogo1.store.qq.com/qzone/291491692/291491692/100",@"title":@"我是第二条标题",@"lastMessage":@"我是第二条消息",@"time":[NSNumber numberWithInteger:time1],@"badge":[NSNumber numberWithInteger:0],@"notDisturb":[NSNumber numberWithBool:YES]};
    NSDictionary *dic3 = @{@"icon":@"https://qlogo1.store.qq.com/qzone/291491692/291491692/100",@"title":@"第三条标题",@"lastMessage":@"我是第三条消息",@"time":[NSNumber numberWithInteger:time2],@"badge":[NSNumber numberWithInt:0],@"notDisturb":[NSNumber numberWithBool:YES]};
    NSDictionary *dic4 = @{@"iocn":@"https://qlogo1.store.qq.com/qzone/291491692/291491692/100",@"title":@"第四条标题",@"lastMessage":@"我是第四条消息",@"time":[NSNumber numberWithInteger:time3],@"badge":[NSNumber numberWithInt:0],@"notDisturb":[NSNumber numberWithBool:YES]};
    NSDictionary *dict5 = @{@"icon":@"https://qlogo1.store.qq.com/qzone/291491692/291491692/100",@"title":@"第四条标题",@"lastMessage":@"第四条消息",@"time":[NSNumber numberWithInteger:time4],@"badge":[NSNumber numberWithInteger:23],@"notDisturb":[NSNumber numberWithBool:NO]};
    NSArray *source = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dict5,nil];
    for (NSDictionary *dic in source) {
        YJMessageListModel *messageModel = [[YJMessageListModel alloc] initWithDic:dic];
        [self.dataSource addObject:messageModel];
    }
    
}

- (void)rightBarItemClick {
    
}
@end
