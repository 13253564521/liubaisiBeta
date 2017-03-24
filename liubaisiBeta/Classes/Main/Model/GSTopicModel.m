//
//  GSTopicModel.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/3.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSTopicModel.h"
#import "NSDate+GSExtension.h"
#import "GSComment.h"
#import "GSUser.h"
@implementation GSTopicModel
{

    CGFloat _cellHeight;
}


+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             
             };
}

- (NSString *)create_time{

    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }


}

- (CGFloat)cellHeight{
    //判断cellHeight是否为0
    if (!_cellHeight){
        
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake(kSCREENWIDTH - 2 * GSTopicCellMagarin, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        
        //cell 的高度
        //文字部分的高度
        _cellHeight = GSCellContentY + textH + GSTopicCellMagarin - 10;
        
        //根据段子类型计算视图View的尺寸 和 cell的高度
        if (self.type == GSBaiSiTypePicture) {
            if (self.width != 0 && self.height != 0) {
                //图片显示出来的宽度
                CGFloat pictureW = maxSize.width;
                CGFloat pictureH = pictureW * (self.height / self.width);
            
                //如果给图片的高度不大于1000就全部显示
                if (pictureH > GSCellPictureMaxH) {//图片过长
                    pictureH = GSCellPictureBreakH;
                    self.bigPicture = YES;//大图
                }
                //计算图片的的frame
                CGFloat pictureX = GSTopicCellMagarin;
                CGFloat pictureY = GSCellContentY + textH + GSTopicCellMagarin - 10;
                
                _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
                
                _cellHeight += pictureH + GSTopicCellMagarin;
                
            }
        }else if (self.type == GSBaiSiTypeVoice){//声音帖子的尺寸和高度
            CGFloat vioceX = GSTopicCellMagarin;
            CGFloat vioceY = GSCellContentY + textH + GSTopicCellMagarin;
            CGFloat vioceW = maxSize.width;
            CGFloat vioceH = vioceW * self.height / self.width;
            
            _voiceF = CGRectMake(vioceX, vioceY, vioceW, vioceH);
            
            _cellHeight += vioceH + GSTopicCellMagarin;
            
        }else if (self.type == GSBaiSiTypeVideo){
            
            CGFloat videoX = GSTopicCellMagarin;
            CGFloat videoY = GSCellContentY + textH + GSTopicCellMagarin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + GSTopicCellMagarin;
            
        }
        
        //如果有最热评论
        if (self.top_cmt) {
            
            NSString *content = [NSString  stringWithFormat:@"%@:%@",self.top_cmt.user.username,self.top_cmt.content];
            CGFloat contentH  = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            
            _cellHeight += GSCellTopCmtTitleH + contentH + GSTopicCellMagarin;
        }
        
        //底部工具栏栏
        _cellHeight += GSCellBottomBarH;
        
        
    }
    return _cellHeight;
}


@end
