//
//  GSTopicModel.h
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/3.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GSComment;
@interface GSTopicModel : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像的URL */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 是否为新浪加V用户 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;

/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;

/** 最热评论 */
@property (nonatomic, strong) GSComment *top_cmt;

/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;

/** 帖子的类型   请求下来就有值 */
@property (nonatomic, assign) GSBaiSiType type;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/** qzone_uid */
//@property (nonatomic, copy) NSString *qzone_uid;


/****** 额外的辅助属性 ******/

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

/** 图片控件的frame */
@property (nonatomic, assign, readonly) CGRect pictureF;

/** 图片是否太大 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;

/** 声音控件的frame */
@property (nonatomic, assign, readonly) CGRect voiceF;

/** 视频控件的frame */
@property (nonatomic, assign, readonly) CGRect videoF;



/** 富文本的内容 */
@property (nonatomic, copy) NSString *attributeText;
@end
