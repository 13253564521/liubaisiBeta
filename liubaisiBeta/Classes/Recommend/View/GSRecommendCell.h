//
//  GSRecommendCell.h
//  LiuBaiSi
//
//  Created by 刘高升 on 17/2/27.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GSRecomendModel;
@interface GSRecommendCell : UITableViewCell
/**
 数据模型
 */
@property(nonatomic,strong) GSRecomendModel *model;
+ (GSRecommendCell *)initRecommendCellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath;
@end
