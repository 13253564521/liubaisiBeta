//
//  GSNetWorkTools.m
//  Kitchen
//
//  Created by 刘高升 on 17/2/9.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSNetWorkTools.h"
#import <AFNetworking.h>
static AFHTTPSessionManager *manger = nil;
static NSInteger const KReauestTimeOut = 30;
@implementation GSNetWorkTools
+(AFHTTPSessionManager *)shareManger{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [AFHTTPSessionManager manager];
        //设置解析的内容类型
        manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/plain",@"text/javascript",@"application/json", nil];
        manger.requestSerializer.timeoutInterval = KReauestTimeOut;
    });
    return manger;
}

+(id)GET:(NSString *)url parameters:(NSDictionary *)parameters isHud:(BOOL)isHud complationHandle:(complationHandle)completed{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (isHud) {
        [SVProgressHUD showWithStatus:@"请稍后。。。" maskType:SVProgressHUDMaskTypeClear];
    }


    return [[self shareManger] GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        completed(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        NSLog(@"%@",error);
        if (error) {
            completed(nil,error);
        }
    }];

}


+(id)POST:(NSString *)url parameters:(NSDictionary *)parameters isHud:(BOOL)isHud complationHandle:(complationHandle)completed{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (isHud) {
        [SVProgressHUD showWithStatus:@"请稍后。。。" maskType:SVProgressHUDMaskTypeClear];
    }
    return [[self shareManger] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (responseObject) {
            completed(responseObject,nil);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        NSLog(@"%@",error);
        if (error) {
            completed(nil,error);
        }
    }];


}

@end
