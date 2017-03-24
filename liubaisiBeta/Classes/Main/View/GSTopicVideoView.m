//
//  GSTopicVideoView.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/3.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSTopicVideoView.h"
#import "GSTopicModel.h"
@interface GSTopicVideoView()
/**图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**播放次数*/
@property (weak, nonatomic) IBOutlet UILabel *playTimes;
/**播放时长*/
@property (weak, nonatomic) IBOutlet UILabel *playLenth;
/**播放按钮*/
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end
@implementation GSTopicVideoView

- (void)awakeFromNib{
    [super awakeFromNib];
    

}

- (void)setModel:(GSTopicModel *)model{
    _model = model;
    
    
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.large_image]];
    
    // 播放次数
    self.playTimes.text = [NSString stringWithFormat:@"%zd播放", model.playcount];
    
    // 时长
    NSInteger minute = model.videotime / 60;
    NSInteger second = model.videotime % 60;
    
    self.playLenth.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
