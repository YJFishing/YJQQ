//
//  YJTabBarView.h
//  YJQQ
//
//  Created by 包宇津 on 2018/6/4.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJTabBarView;
@protocol YJTablBarViewDelegate<NSObject>

- (BOOL)YJTabBar:(YJTabBarView *)tabbar shoudSelectItemAtIndex:(int)index;
- (void)YJTabBar:(YJTabBarView *)tabbar didSelectItemAtIndex:(int)index;
- (void)YJTabBar:(YJTabBarView *)tabbar shouldClearUnreadCountAtIndex:(int)index;

@end

@interface YJTabBarView : UIView

@property (nonatomic, weak) id<YJTablBarViewDelegate> delegate;

@end
