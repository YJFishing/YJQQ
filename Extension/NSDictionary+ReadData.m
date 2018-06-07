//
//  NSDictionary+ReadData.m
//  YJQQ
//
//  Created by 包宇津 on 2018/6/7.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import "NSDictionary+ReadData.h"

@implementation NSDictionary (ReadData)

- (BOOL)readBoolWithKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    NSDictionary<NSString* ,id> *dic = self;
    defaultValue = false;
    if ([dic objectForKey:key]) {
        if ([dic[key] isKindOfClass:[NSNumber class]]) {
            if ([dic[key] boolValue]) {
                return dic[key];
            }else if ([dic[key] intValue]){
                return ([dic[key] intValue] != 0);
            }
        }
    }
    return defaultValue;
}

- (int)readIntWithKey:(NSString *)key defaultValue:(int)defaultValue {
    NSDictionary<NSString *,id> *dic = self;
    defaultValue = 0;
    if ([dic objectForKey:key]) {
        if ([dic[key] isKindOfClass:[NSNumber class]]) {
            return [dic[key] intValue];
        }
    }
    return defaultValue;
}

- (float)readCGFloatWithKey:(NSString *)key defaultValue:(CGFloat)defaultValue {
    defaultValue = 0;
    NSDictionary<NSString *,id> *dic = self;
    if ([dic objectForKey:key]) {
        if ([dic[key] isKindOfClass:[NSNumber class]]) {
            return [dic[key] floatValue];
        }
    }
    return defaultValue;
}

- (NSString *)readStringWithKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    defaultValue = @"";
    NSDictionary<NSString *,id> *dic = self;
    if ([dic objectForKey:key]) {
        if ([dic[key] isKindOfClass:[NSString class]]) {
            return dic[key];
        }
    }
    return defaultValue;
}

- (NSArray *)readArrayWithKey:(NSString *)key defaultValue:(NSArray *)defaultValue {
    defaultValue = [NSArray array];
    NSDictionary<NSString *,id> *dic = self;
    if ([dic objectForKey:key]) {
        if ([dic[key] isKindOfClass:[NSArray class]]) {
            return dic[key];
        }
    }
    return defaultValue;
}
- (NSDictionary *)readDicWithKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue {
    defaultValue = [NSDictionary dictionary];
    NSDictionary<NSString *,id> *dic = self;
    if ([dic objectForKey:key]) {
        if ([dic[key] isKindOfClass:[NSDictionary class]]) {
            return dic[key];
        }
    }
    return defaultValue;
}
@end
