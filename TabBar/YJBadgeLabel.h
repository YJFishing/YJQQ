//
//  YJBadgeLabel.h
//  YJQQ
//
//  Created by 包宇津 on 2018/6/9.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat max_distance = 80;
static CGFloat max_translation_cancel = 20;

@interface YJBadgeLabel : UILabel

@property (nonatomic, copy) void(^clearBadgeCompletion)(YJBadgeLabel *label);
//能否通过拖动角标清空未读数据
@property (nonatomic, assign) BOOL draggable;
//badgeLabel原始位置的center
@property (nonatomic, assign) CGPoint badgeLabelCenter;
//badgeLabel原始位置圆半径
@property (nonatomic, assign) CGFloat radius1;
//badgeLabel拖动位置的圆半径
@property (nonatomic, assign) CGFloat radius2;
@property (nonatomic, strong) CAShapeLayer *viscosityLayer;
//badgeLabel位置，连接移动轨道
@property (nonatomic, strong) UIView *stayPutView;
//是否超过最大距离
@property (nonatomic, assign) BOOL beyond;
//用户结束拖动，没有清空的情况下，label回到的那个view
@property (nonatomic, strong) UIView *originalSuperView;

@end
