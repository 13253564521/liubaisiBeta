//
//  GSTopicPictureView.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/3.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSTopicPictureView.h"
#import "GSTopicModel.h"
#import "GSCircularProgressView.h"

#import "GSShowBigImageViewController.h"
@interface GSTopicPictureView()
/**显示图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**是否是动态图*/
@property (weak, nonatomic) IBOutlet UIImageView *isGifImageView;
/**查看全图按钮*/
@property (weak, nonatomic) IBOutlet UIButton *showBigButton;
@property (weak, nonatomic) IBOutlet GSCircularProgressView *progressView;

@end
@implementation GSTopicPictureView


- (void)awakeFromNib{
    [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
   
    //给图片添加点击事件
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigImageClick)];
    [self.imageView addGestureRecognizer:tapGesture];


}

//大图点击
- (void)bigImageClick{
    GSShowBigImageViewController *bigVc = [[GSShowBigImageViewController alloc]init];
    bigVc.model = self.model;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:bigVc animated:YES completion:nil];
}
- (void)setModel:(GSTopicModel *)model{
    _model = model;
    
    //立马显示进度值
//    [self.progressView setProgress:model.pictureProgress animated:NO];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        //正在下载显示进度条
        //显示进度跳
        self.progressView.hidden = NO;
        
        //计算进度值
        model.pictureProgress = 1.0 * receivedSize / expectedSize;
        
        self.progressView.contentLable.text = [NSString stringWithFormat:@"%.2f%%",model.pictureProgress * 100];
        //显示进度值
        [self.progressView drawProgress:model.pictureProgress];
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.progressView.hidden = YES;
        // 如果是大图片, 才需要进行绘图处理
        if (model.isBigPicture == NO) return;
        
        // 开启图形上下文 UIGraphicsBegin 传一个大小（任意大小）给上下文
        UIGraphicsBeginImageContextWithOptions(model.pictureF.size, YES, 0.0);
        
        // 将下载完的image对象绘制到图形上下文    拿到下载下来的图片的宽高比，计算出要显示的宽高
        CGFloat width = model.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        
        
        
        // 将下载下来的图片画到计算出的宽高范围上（范围可能很大，所有图片不会变形）
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        
        // 获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束图形上下文
        UIGraphicsEndImageContext();

    }];
    
    //是否是gif
    NSString *extension = model.large_image.pathExtension;
    self.isGifImageView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    

    //判断是否显示大图
    if (model.isBigPicture) {
        
        self.showBigButton.hidden = NO;
        
    }else{
        
        self.showBigButton.hidden = YES;
    
    }

}
- (IBAction)showBigImageClick:(UIButton *)sender {
    GSShowBigImageViewController *bigVc = [[GSShowBigImageViewController alloc]init];
    bigVc.model = self.model;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:bigVc animated:YES completion:nil];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
