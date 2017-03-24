//
//  GSAddPlusViewController.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/20.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSAddPlusViewController.h"

#import "GSTopImageBottomText.h"
#import <pop/POP.h>

@interface GSAddPlusViewController ()

/**
 标题数组
 */
@property(nonatomic,strong) NSArray *titleArray;


/**
 数据
 */
@property(nonatomic,strong) NSArray *images;
@end

static CGFloat const GSAnimationDelay = 0.1;
static CGFloat const GSSpringFactor = 10;

@implementation GSAddPlusViewController

- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    }

    return _titleArray;

}

- (NSArray *)images{

    if (!_images) {
        _images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    }

    return _images;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    //设置内容视图
    [self setUpContenView];
}

- (void)setUpContenView{
    //背景视图
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"shareBottomBackground"];
    [self.view addSubview:bgImageView];
    
    //中间视图
    //九宫格
    int maxcols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStarY = (kSCREENWIDTH - 2 * buttonH) * 0.5;
    CGFloat buttonStarX = 20;
    CGFloat xMargain = (kSCREENWIDTH - 2 * buttonStarX - maxcols * buttonW) / (maxcols - 1);
    for (int i = 0 ; i < self.images.count; i++) {
        GSTopImageBottomText *button = [[GSTopImageBottomText alloc]init];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        //设置内容
        [button  setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
        
        //计算
        int row = i / maxcols;
        int col = i % maxcols;
        CGFloat buttonX = buttonStarX + col * (xMargain + buttonW);
        CGFloat buttonEndY = buttonStarY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - kSCREENHEIGHT;
        
        button.frame = CGRectMake(buttonX, buttonEndY, buttonW, buttonH);
        
        self.view.userInteractionEnabled = YES;
        
        //按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        
        anim.springBounciness = GSSpringFactor;
        
        anim.springSpeed = GSSpringFactor;
        
        // 开始时间 不同
        anim.beginTime = CACurrentMediaTime() + GSAnimationDelay * i;
        [button pop_addAnimation:anim forKey:nil];
        
    }
    
    //添加标语
    UIImageView *soganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:soganView];
    
    CGFloat anmicenterX = kSCREENWIDTH / 2;
    CGFloat centerEndY = kSCREENHEIGHT / 2;
    CGFloat centerBegainY = centerEndY - kSCREENHEIGHT;
    soganView.centerX = anmicenterX;
    soganView.centerY = centerBegainY;
    //标语动画
    POPSpringAnimation *anmi = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anmi.fromValue = [NSValue valueWithCGPoint:CGPointMake(anmicenterX, centerBegainY)];
    anmi.toValue = [NSValue valueWithCGPoint:CGPointMake(anmicenterX, centerEndY)];
    anmi.beginTime = CACurrentMediaTime() + self.images.count * GSAnimationDelay;
    anmi.springBounciness = GSSpringFactor;
    anmi.springSpeed = GSSpringFactor;
    [anmi setCompletionBlock:^(POPAnimation *anmi, BOOL finished) {
        //执行完标语动画 恢复用户交互
        self.view.userInteractionEnabled = YES;
    }];
    [soganView pop_addAnimation:anmi forKey:nil];
    
    

    
    
    
    
    
    
    
    //取消按钮
    CGFloat cancleH = 40;
    UIButton *missButton = [UIButton buttonWithType:UIButtonTypeCustom];
    missButton.frame = CGRectMake(0, kSCREENHEIGHT - 30 - cancleH, kSCREENWIDTH - cancleH * 2, cancleH);
    missButton.centerX = kSCREENWIDTH / 2;
    [missButton setBackgroundImage:[UIImage imageNamed:@"shareButtonCancel"] forState:UIControlStateNormal];
    [missButton addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:missButton];
    



}


#pragma mark - 点击事件
- (void)cancleClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)buttonClick{


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
