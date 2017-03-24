//
//  GSADDTabBar.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/2.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSADDTabBar.h"
#import "GSAddPlusViewController.h"

@interface GSADDTabBar()
{   //➕按钮
    UIButton *_addPlusButton;

}
@end
@implementation GSADDTabBar
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //背景
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-ligh"]];
        //按钮初始化
        _addPlusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addPlusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_addPlusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        //事件
        [_addPlusButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        [_addPlusButton sizeToFit];
        [self addSubview:_addPlusButton];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //尺寸
   NSInteger itemCount = self.items.count + 1;
    CGFloat itemX;
    CGFloat itemY = 0;
    CGFloat itemW = self.width / itemCount;
    CGFloat itemH = self.height;
    
    NSInteger i = 0;
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            itemX = i * itemW;
            subView.frame = CGRectMake(itemX, itemY, itemW, itemH);
            i++;
            if (i == 2) {
                i++;
            }
        }
   
    }
    //设置加号按钮尺寸
    _addPlusButton.center = CGPointMake(self.width / 2, self.height / 2);

}
- (void)addClick{
    
    GSAddPlusViewController *addVc = [[GSAddPlusViewController alloc]init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:addVc animated:NO completion:nil];
}

- (void)addPlusClick{

    
    //发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:GSTabBarDidSelectNotification object:nil userInfo:nil];
}
@end
