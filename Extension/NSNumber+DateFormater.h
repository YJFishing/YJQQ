//
//  NSNumber+DateFormater.h
//  YJQQ
//
//  Created by 包宇津 on 2018/6/7.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (DateFormater)
- (NSString *)normalFormaterString;
- (NSString *)homeOrderTimeString;
+ (NSInteger)getHowManyDaysApart:(NSDate *)date1 date2:(NSDate *)date2;
@end
