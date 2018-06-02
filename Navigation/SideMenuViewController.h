//
//  SideMenuViewController.h
//  YJQQ
//
//  Created by 包宇津 on 2018/5/31.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuViewController : UIViewController

@property (nonatomic ,strong) UIView *topView;
@property (nonatomic ,strong) UIImageView *bgImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *settingBtn;
@property (nonatomic, strong) UIButton *nightModeBtn;
@property (nonatomic, strong) UIButton *cmShowBtn;
@property (nonatomic, strong) NSArray *imageName;
@property (nonatomic, strong) NSArray *text;
@property (nonatomic, copy) void (^pushVCBlock)(UIViewController *vc,BOOL animatd);

@end
