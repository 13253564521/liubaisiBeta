//
//  GSConst.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/2.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSConst.h"
/**顶部导航栏高度*/
NSInteger const GSTitleViewHeight = 35;
/**导航栏高度 + 状态栏高度 */
NSInteger const GSNav_StateHeight = 64;

/** tabBar被选中的通知名字 */
NSString * const GSTabBarDidSelectNotification = @"JWTabBarDidSelectNotification";
/** cell 之间的间距*/
NSInteger const  GSTopicCellMagarin = 20;
/**cell 文字的Y值*/
NSInteger const GSCellContentY = 55;
/**cell 图片的最大高度*/
NSInteger const GSCellPictureMaxH = 1000;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
NSInteger const GSCellPictureBreakH = 250;
/** 精华-cell-最热评论标题的高度 */
NSInteger const GSCellTopCmtTitleH = 20;
/** 精华-cell-底部工具条的高度 */
NSInteger const GSCellBottomBarH = 35;
/** tabbar的高度 */
NSInteger const GSTabBarH = 49;
