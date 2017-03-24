//
//  GSCircularProgressView.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/17.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSCircularProgressView.h"
@interface GSCircularProgressView()
{
    CGFloat _progress;
    CAShapeLayer *_progressLayer;
}
@end

@implementation GSCircularProgressView
- (UILabel *)contentLable{
    if (_contentLable == nil) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        lable.textColor = [UIColor whiteColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.center = CGPointMake(self.width / 2, self.height / 2);
        [self addSubview:lable];
        _contentLable = lable;
        
    }

    return _contentLable;
}


- (void)drawProgress:(CGFloat)progress{
    _progress = progress;
    _progressLayer.opacity = 0;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{

}

- (void)drawCycleProgress{

    CGPoint center = CGPointMake(100, 100);
    CGFloat radius = 90;
    CGFloat startA = - M_PI_2; //进度条的起点位置
    CGFloat endA = -M_PI_2 + M_PI * 2 * _progress; //进度条的终点位置；
    
    //获取环形路径
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;// 填充色为无色
    _progressLayer.strokeColor = [UIColor redColor].CGColor;//指定path的渲染颜色，这里可以设置任意不透明的颜色
    
    _progressLayer.opacity = 1; // 北背景颜色的透明度
    _progressLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _progressLayer.lineWidth = 10; //线的宽度
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];//上面用来构建圆形
    _progressLayer.path = [path CGPath];
    [self.layer addSublayer:_progressLayer];
    //生成渐变色
    CALayer *gradientLayer = [CALayer layer];
    
    //左侧渐变色
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(0, 0, self.width / 2, self.height);
    leftLayer.locations = @[@0.3,@0.9,@1];
    leftLayer.colors = @[(id)[UIColor yellowColor].CGColor,(id)[UIColor greenColor].CGColor];
    [gradientLayer addSublayer:leftLayer];
    
    //右侧渐变色
    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    rightLayer.frame = CGRectMake(self.width / 2, 0, self.width / 2, self.height);
    rightLayer.locations = @[@0.3,@0.9,@1];
    rightLayer.colors = @[(id)[UIColor yellowColor].CGColor,(id)[UIColor redColor].CGColor];
    [gradientLayer addSublayer:rightLayer];
    
    //来截取渐变色
    [self.layer  addSublayer:gradientLayer];
    

}
@end
