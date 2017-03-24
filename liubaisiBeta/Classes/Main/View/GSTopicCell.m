//
//  GSTopicCell.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/2.
//  Copyright © 2017年 刘高升. All rights reserved.
//topiccell

#import "GSTopicCell.h"

#import "GSTopicModel.h"
#import "GSTopicPictureView.h"
#import "GSTopicVoiceView.h"
#import "GSTopicVideoView.h"

#import "GSComment.h"
#import "GSUser.h"
@interface GSTopicCell()<UIActionSheetDelegate>
//用户头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//新浪标识
@property (weak, nonatomic) IBOutlet UIImageView *sinaImageView;
//用户名称
@property (weak, nonatomic) IBOutlet UILabel *userName;
//时间标签
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
//内容标签
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
//最热评论View
@property (weak, nonatomic) IBOutlet UIView *hottestReview;
//最热评论 lable
@property (weak, nonatomic) IBOutlet UILabel *hottestCommentLable;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconWidthConstraint;

//顶
@property (weak, nonatomic) IBOutlet UIButton *theTopButton;
//踩
@property (weak, nonatomic) IBOutlet UIButton *stepOnButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardingButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;


/**
 中间内容 - picture
 */
@property(nonatomic,strong) GSTopicPictureView *pictureView;

/**
 中间视图 - voice
 */
@property(nonatomic,strong) GSTopicVoiceView *voiceView;

/**
 中间视图 - video
 */
@property(nonatomic,strong) GSTopicVideoView *videoView;

@end
@implementation GSTopicCell
/**懒加载三种视图*/
- (GSTopicPictureView *)pictureView{
    if (!_pictureView) {
        _pictureView = [GSTopicPictureView viewFromXib];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}

- (GSTopicVoiceView *)voiceView{
    if (!_voiceView) {
        _voiceView = [GSTopicVoiceView viewFromXib];
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}

- (GSTopicVideoView *)videoView{
    if (!_videoView) {
        _videoView = [GSTopicVideoView viewFromXib];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.iconImageView sizeToFit];
    self.iconImageView.layer.cornerRadius = self.iconWidthConstraint.constant / 2;
    self.iconImageView.clipsToBounds = YES;
    
    //背景
    UIImageView *backImageView = [[UIImageView alloc]init];
    backImageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = backImageView;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    switch (self.model.type) {
        case GSBaiSiTypePicture:
            self.pictureView.frame = self.model.pictureF;
            break;
        case GSBaiSiTypeVoice:
            self.voiceView.frame = self.model.voiceF;
            break;
        case GSBaiSiTypeVideo:
            self.videoView.frame = self.model.videoF;
            break;
            
        default:
            break;
    }


}

//关注点击
- (IBAction)followClick:(UIButton *)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"举报",@"收藏",nil];
    [sheet showInView:kWindow];
    
    
}
//顶
- (IBAction)topClick:(UIButton *)sender {
}
//踩
- (IBAction)steponClick:(UIButton *)sender {
}
//转发
- (IBAction)forwardClick:(UIButton *)sender {
}
//评论
- (IBAction)commentClick:(UIButton *)sender {
}


#pragma mark - 重写set方法
//- (void)setFrame:(CGRect)frame{
//    frame.size.height = self.model.cellHeight - GSTopicCellMagarin;
//    frame.origin.y += GSTopicCellMagarin;
//    [super setFrame:frame];
//
//}




- (void)setModel:(GSTopicModel *)model{
    _model = model;
    //新浪加V
    self.sinaImageView.hidden = !model.isSina_v;
    //设置头像
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置姓名
    self.userName.text = model.name;
    //设置帖子创建时间
    self.timeLable.text  = model.create_time;
    
    //设置按钮文字
    //顶
    [self setupButtonTitle:self.theTopButton count:model.ding placeholder:@"顶"];
    //踩
    [self setupButtonTitle:self.stepOnButton count:model.cai placeholder:@"踩"];
    //转发
    [self setupButtonTitle:self.forwardingButton count:model.repost placeholder:@"分享"];
    //评论
    [self setupButtonTitle:self.commentsButton count:model.comment placeholder:@"评论"];
    
    
    //设置帖子文字内容 富文本内容
    self.contentLable.text = model.text;
    //根据帖子内容加载不同视图
    if (model.type == GSBaiSiTypePicture) {//图片
        self.pictureView.hidden = NO;
        self.pictureView.model = model;
        
        //隐藏
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
 
        
    }else if (model.type == GSBaiSiTypeVoice){//声音
        self.voiceView.hidden = NO;
        self.voiceView.model = model;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    
    
    }else if (model.type == GSBaiSiTypeVideo){//视频
        self.videoView.hidden = NO;
        self.videoView.model = model;
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    
    
    }else{//段子
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
    
    }

    //最热评论
    if (model.top_cmt) {
        
        self.hottestReview.hidden = NO;
        self.hottestCommentLable.text = [NSString stringWithFormat:@"%@:%@",model.top_cmt.user.username,model.top_cmt.content];
        
    }else{
        self.hottestReview.hidden = YES;
        
    }



}

/**
 * 设置底部按钮文字   2.0万没处理
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{
    if (count > 10000) {
        placeholder  = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }else if (count > 0){
        placeholder = [NSString stringWithFormat:@"%zd",count];
    
    }
    
    [button setTitle:placeholder forState:UIControlStateNormal];

}


#pragma mark - <UIActionSheetDelegate>

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        [SVProgressHUD showSuccessWithStatus:@"已举报"];
    }else{
    
        [SVProgressHUD showSuccessWithStatus:@"已收藏"];
    }


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
