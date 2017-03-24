//
//  GSTopicVoiceView.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/3.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSTopicVoiceView.h"
#import "GSTopicModel.h"
@interface GSTopicVoiceView()
/**图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**播放次数*/
@property (weak, nonatomic) IBOutlet UILabel *playTimesLable;
/**播放时长*/
@property (weak, nonatomic) IBOutlet UILabel *playLength;

@property (weak, nonatomic) IBOutlet UIButton *palyButton;

@end
@implementation GSTopicVoiceView
- (void)awakeFromNib{
    [super awakeFromNib];


}

- (void)setModel:(GSTopicModel *)model{
    _model = model;
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.large_image]];
    
    // 播放次数
    self.playTimesLable.text = [NSString stringWithFormat:@"%zd播放", model.playcount];
    
    // 时长
    NSInteger minute = model.voicetime / 60;
    NSInteger second = model.voicetime % 60;
    self.playLength.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
