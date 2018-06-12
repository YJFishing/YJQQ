//
//  YJMessageListModel.h
//  YJQQ
//
//  Created by 包宇津 on 2018/6/11.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YJMessageListModel : NSObject

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *lastMessage;
@property (nonatomic, assign) CGFloat time;
@property (nonatomic, assign) int badge;
@property (nonatomic, assign) BOOL notDisturb;

- (instancetype)initWithDic:(NSDictionary<NSString *,id> *)dic;

@end
