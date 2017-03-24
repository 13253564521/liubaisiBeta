//
//  UIView+GSExtension.h
//  LiuBaiSi
//
//  Created by 刘高升 on 17/2/16.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GSExtension)
    @property (nonatomic, assign) CGFloat x;
    @property (nonatomic, assign) CGFloat y;
    @property (nonatomic, assign) CGFloat centerX;
    @property (nonatomic, assign) CGFloat centerY;
    @property (nonatomic, assign) CGFloat width;
    @property (nonatomic, assign) CGFloat height;
    @property (nonatomic, assign) CGSize size;
    
    
    /**
     * 判断一个控件是否真正显示在主窗口
     */
- (BOOL)isShowingOnKeyWindow;
    
    //- (CGFloat)x;
    //- (void)setX:(CGFloat)x;
    /** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/
    
+ (instancetype)viewFromXib;
@end
