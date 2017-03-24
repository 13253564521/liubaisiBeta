//
//  GSUser.h
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/3.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
@end
