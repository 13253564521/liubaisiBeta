//
//  GSConst.h
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/2.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#ifdef __cplusplus
#define GSUIKIT_EXTERN		extern "C" __attribute__((visibility ("default")))
#else
#define GSUIKIT_EXTERN	        extern __attribute__((visibility ("default")))
#endif


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GSBaiSiType) {
    GSBaiSiTypeAll = 1,
    GSBaiSiTypePicture = 10,
    GSBaiSiTypeWord  = 29,
    GSBaiSiTypeVoice   = 31,
    GSBaiSiTypeVideo = 41
};
/**顶部导航栏高度*/
GSUIKIT_EXTERN NSInteger const GSTitleViewHeight;
/**导航栏高度 + 状态栏高度 */
GSUIKIT_EXTERN NSInteger const GSNav_StateHeight;
/** tabBar被选中的通知名字 */
GSUIKIT_EXTERN NSString * const GSTabBarDidSelectNotification;
/** cell 之间的间距*/
GSUIKIT_EXTERN NSInteger const  GSTopicCellMagarin;
/**cell 文字的Y值*/
GSUIKIT_EXTERN NSInteger const GSCellContentY;
/**cell 图片的最大高度*/
GSUIKIT_EXTERN NSInteger const GSCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
GSUIKIT_EXTERN NSInteger const GSCellPictureBreakH;
/** 精华-cell-最热评论标题的高度 */
GSUIKIT_EXTERN NSInteger const GSCellTopCmtTitleH;
/** 精华-cell-底部工具条的高度 */
GSUIKIT_EXTERN NSInteger const GSCellBottomBarH;

/** tabbar的高度 */
GSUIKIT_EXTERN NSInteger const GSTabBarH;

