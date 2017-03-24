//
//  GSNetWorkTools.h
//  Kitchen
//
//  Created by 刘高升 on 17/2/9.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^complationHandle)(id responseObject, NSError *error);
@interface GSNetWorkTools : NSObject
/**
 *GET请求
 *url 连接
 *parameters 参数
  *isHud 是否需要加载提示
 *complationHandle 完成回调
 */
+(id)GET:(NSString *)url parameters:(NSDictionary *)parameters isHud:(BOOL)isHud complationHandle:(complationHandle)completed;

/**
 *POST请求
 *url 连接
 *parameters 参数
 *isHud 是否需要加载提示
 *complationHandle 完成回调
 */
+(id)POST:(NSString *)url parameters:(NSDictionary *)parameters isHud:(BOOL)isHud complationHandle:(complationHandle)completed;

@end
