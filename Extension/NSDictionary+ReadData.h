//
//  NSDictionary+ReadData.h
//  YJQQ
//
//  Created by 包宇津 on 2018/6/7.
//  Copyright © 2018年 baoyujin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (ReadData)

- (BOOL)readBoolWithKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (int)readIntWithKey:(NSString *)key defaultValue:(int)defaultValue;
- (float)readCGFloatWithKey:(NSString *)key defaultValue:(CGFloat)defaultValue;
- (NSString *)readStringWithKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSArray *)readArrayWithKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSDictionary *)readDicWithKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;

@end
