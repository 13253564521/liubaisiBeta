//
//  GSTopicCell.h
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/2.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GSTopicModel;
@interface GSTopicCell : UITableViewCell

/**
 帖子数据
 */
@property(nonatomic,strong) GSTopicModel *model;
@end
