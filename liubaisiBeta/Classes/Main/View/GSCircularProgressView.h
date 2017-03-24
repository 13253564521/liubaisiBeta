//
//  GSCircularProgressView.h
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/17.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSCircularProgressView : UIView
/**
 中间显示视图
 */
@property (nonatomic , strong) UILabel *contentLable;


- (void)drawProgress:(CGFloat)progress;
@end
