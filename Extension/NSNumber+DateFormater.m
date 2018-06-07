//
//  NSNumber+DateFormater.m
//  YJQQ
//
//  Created by 包宇津 on 2018/6/7.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "NSNumber+DateFormater.h"

static NSInteger secondsOneDay = 60 * 60 * 24;

@implementation NSNumber (DateFormater)

- (NSString *)normalFormaterString {
    NSString *result = @"";
    NSDate *nowDate = [NSDate date];
    NSTimeInterval now = [nowDate timeIntervalSince1970];
    NSInteger thisTime = self.integerValue / 1000;
    NSDate *thisDate = [nowDate initWithTimeIntervalSince1970:thisTime];
    NSInteger apartDay = [NSNumber getHowManyDaysApart:nowDate date2:thisDate];
    
    if (now - thisTime < secondsOneDay) {
        if (apartDay == 1) {
            result = @"昨天";
        }else if (now - thisTime < secondsOneDay * 2) {
            if (apartDay == 2) {
                result = @"前天";
            }else {
                result = @"昨天";
            }
        }else if (now - thisTime < secondsOneDay * 3) {
            if (apartDay == 3) {
                NSDateFormatter *format = [[NSDateFormatter alloc] init];
                [format setDateFormat:@"YYYY-MM-dd"];
                result = [format stringFromDate:thisDate];
            }else {
                result = @"前天";
            }
        }else {
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            format.dateFormat = @"YYYY-MM-dd";
            result = [format stringFromDate:thisDate];
        }
    }
    return result;
}

- (NSString *)homeOrderTimeString {
    NSString *result = @"";
    NSDate *nowDate = [NSDate date];
    NSTimeInterval now = [nowDate timeIntervalSince1970];
    
    NSTimeInterval thisTime = self.integerValue / 1000;
    NSDate *thisDate = [nowDate initWithTimeIntervalSince1970:thisTime];
    
    NSInteger apartDay = [NSNumber getHowManyDaysApart:nowDate date2:thisDate];
    
    if (now - thisTime < 60 * 60) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"mm分钟前";
        result = [format stringFromDate:thisDate];
    }else if (now - thisTime < secondsOneDay) {
        if (apartDay == 1) {
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            format.dateFormat = @"MM月dd日";
            result = [format stringFromDate:thisDate];
        }else {
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            format.dateFormat = @"HH:mm";
            result = [format stringFromDate:thisDate];
        }
    }else {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"MM月dd日";
        result = [format stringFromDate:thisDate];
    }
    return result;
}

//获取两个日期之间相隔几天
+ (NSInteger)getHowManyDaysApart:(NSDate *)date1 date2:(NSDate *)date2 {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *date1Components = [calendar components:unitFlags fromDate:date1];
    NSDateComponents *date2Compinents = [calendar components:unitFlags fromDate:date2];
    
    NSInteger year1 = [date1Components year];
    NSInteger year2 = [date2Compinents year];
    
    //获取该日期是此年中的第几天
    NSDateFormatter *countDayFormater = [[NSDateFormatter alloc] init];
    [countDayFormater setDateFormat:@"DDD"];
    NSInteger day1 = [[countDayFormater stringFromDate:date1] integerValue];
    NSInteger day2 = [[countDayFormater stringFromDate:date2] integerValue];
    
    if (year1 < year2) {
        NSInteger temp = year1;
        year1 = year2;
        year2 = temp;
        
        NSInteger tempDay = day1;
        day1 = day2;
        day2 = tempDay;
    }
    
    if (year1 == year2) {
        NSInteger tempDay = day1 - day2;
        tempDay = tempDay > 0 ? tempDay : (0 - tempDay);
        return tempDay;
    }else { //year1 > year2
        NSInteger apart = year1 - year2 - 1;
        NSInteger leapYearCount = apart / 4;  //计算闰年个数
        
        NSInteger daysInYear2 = 365;
        if ((year2 % 4 == 0 && year2 % 100 != 0) || year2 % 400 == 0) {
            daysInYear2 = 366;
        }
        
        NSInteger totalDay = leapYearCount * 365 + (apart - leapYearCount) * 365 + (daysInYear2 - day2) + day1;
        return totalDay;
    }
}
@end
