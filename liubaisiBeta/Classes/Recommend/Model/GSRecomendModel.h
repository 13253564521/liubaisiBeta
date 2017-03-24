//
//  GSRecomendModel.h
//  LiuBaiSi
//
//  Created by 刘高升 on 17/2/27.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSRecomendModel : NSObject
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;
@end
