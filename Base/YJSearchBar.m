//
//  YJSearchBar.m
//  YJQQ
//
//  Created by 包宇津 on 2018/6/4.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJSearchBar.h"

@implementation YJSearchBar

- (instancetype)initWithFrame:(CGRect)fram {
    if (self = [super initWithFrame:fram]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.barTintColor = [UIColor whiteColor];
    self.backgroundImage = [UIImage new];
    NSArray *views = self.subviews;
    for (UIView *view in views) {
        if ([view isKindOfClass:[UITextField class]]) {
            view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        }
    }
}
@end
