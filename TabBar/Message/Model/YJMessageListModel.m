//
//  YJMessageListModel.m
//  YJQQ
//
//  Created by 包宇津 on 2018/6/11.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "YJMessageListModel.h"

@implementation YJMessageListModel

- (instancetype)initWithDic:(NSDictionary<NSString *,id> *)dic {
    if (self = [super init]) {
        self.icon = [dic objectForKey:@"icon"];
        self.title = [dic objectForKey:@"title"];
        self.lastMessage = [dic objectForKey:@"lastMessage"];
        self.time = [[dic objectForKey:@"time"] doubleValue];
        self.badge = [[dic objectForKey:@"badge"] intValue];
        self.notDisturb = [dic objectForKey:@"notDisturb"];
    }
    return self;
}

@end
