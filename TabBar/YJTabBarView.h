//
//  YJTabBarView.h
//  YJQQ
//
//  Created by 包宇津 on 2018/6/4.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YJTablBarViewDelegate:NSObject
@end

@interface YJTabBarView : UIView

@property (nonatomic, weak) id<YJTablBarViewDelegate> delegate;

@end
