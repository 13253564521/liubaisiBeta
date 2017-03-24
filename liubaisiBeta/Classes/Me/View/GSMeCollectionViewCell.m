//
//  GSMeCollectionViewCell.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/20.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSMeCollectionViewCell.h"

@implementation GSMeCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame] ) {
        if (_icon == nil) {
            _icon = [[UIImageView alloc]init];
            [_icon sizeToFit];
            _icon.clipsToBounds = YES;
            [self.contentView addSubview:_icon];
        }
        if (_title == nil) {
            _title = [[UILabel alloc]init];
            _title.font = [UIFont systemFontOfSize:14];
            _title.textColor = [UIColor blackColor];
            _title.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:_title];
        }
    }

    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    _icon.frame = CGRectMake(10, 10, self.width - 20, self.width - 20);
    
    _title.frame = CGRectMake(0, CGRectGetMaxY(_icon.frame) + 5 , self.width,20);
    
}
@end
