//
//  YJTabBarItemView.m
//  YJQQ
//
//  Created by 包宇津 on 2018/6/9.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJTabBarItemView.h"

typedef NS_ENUM(NSInteger,YJTabBarItemType) {
    message,
    contacts,
    dynamic,
};

typedef NS_ENUM(NSInteger,YJTabbarSelectedOrientation) {
    left,
    selected,
    right,
};

static CGFloat image_max_offset_x = 5;
static CGFloat image_max_offset_y = 3;

@interface YJTabBarItemView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIColor *highlightedColor;
@property (nonatomic, assign) YJTabBarItemType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIView *imageContentView;
@property (nonatomic, strong) CAShapeLayer *contentLayer;
//@property (nonatomic, strong) YJBadgeLabel *badgeLabel;
@end

@implementation YJTabBarItemView



@end
