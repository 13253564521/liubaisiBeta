//
//  NSDate+GSExtension.h
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/3.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GSExtension)
/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;
@end
