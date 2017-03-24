//
//  GSTopImageBottomText.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/20.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSTopImageBottomText.h"

@implementation GSTopImageBottomText
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self.imageView sizeToFit];
        self.imageView.clipsToBounds = YES;
        
        self.tintColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat margain = 3;
    self.imageView.frame = CGRectMake(0, 0, self.width , self.height - 20 - margain);
    self.imageView.layer.cornerRadius  = self.width / 2;
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + margain, self.width, 20);



}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
