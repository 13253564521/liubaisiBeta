//
//  GSADViewController.m
//  LiuBaiSi
//
//  Created by 刘高升 on 17/2/17.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSADViewController.h"
#import "GSMainTabbarController.h"
#import "NSString+GSExtension.h"

#define LGS_code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam";
@interface GSADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *adImage;
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
    
    /**
    时间
     */
@property(nonatomic,strong) NSTimer *timer;
@end

@implementation GSADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpbackGroundImage];
    [self setUpJumpButton];
    // Do any additional setup after loading the view from its nib.
    [self loadADData];
    
    
    
}
- (void)setUpbackGroundImage{

    NSString *iphone = [NSString iphoneType];
    
    
    if ([iphone isEqualToString:@"iPhone 4"]) {
        self.backgroundImage.image = [UIImage imageNamed:@"LaunchImage"];
    }else if ([iphone isEqualToString:@"iPhone 5"] || [iphone isEqualToString:@"iPhone SE"]){
        self.backgroundImage.image = [UIImage imageNamed:@"LaunchImage-568h"];
    }else if ([iphone isEqualToString:@"iPhone 6"] || [iphone isEqualToString:@"iPhone 7"]){
        self.backgroundImage.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }else if ([iphone isEqualToString:@"iPhone 6 Plus"] || [iphone isEqualToString:@"iPhone 7 Plus"]){
        self.backgroundImage.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }

}
- (void)setUpJumpButton{
    self.jumpButton.hidden = YES;
    self.jumpButton.layer.cornerRadius = 5;
    self.jumpButton.alpha = 0.8;
    self.jumpButton.backgroundColor = [UIColor lightGrayColor];
    [self.jumpButton addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];

}
//加载广告数据
- (void)loadADData{
    //没有 广告数据 暂时用本地数据模拟化
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"code2"] = LGS_code2;
    
    [GSNetWorkTools GET:ADUrl parameters:params isHud:NO complationHandle:^(id responseObject, NSError *error) {

        NSDictionary *dict = [responseObject[@"ad"] firstObject];
        NSString *adurl = [dict objectForKey:@"w_picurl"];
        [self.adImage sd_setImageWithURL:[NSURL URLWithString:adurl]];
        self.jumpButton.hidden = NO;
        //加载跳过
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:NSInvalidArgumentException repeats:YES];
        [self timeChange];
        
    }];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//
//    });

}
    
- (void)timeChange{
    static NSInteger time = 3;
    //更新跳过按钮标题
    [self.jumpButton setTitle:[NSString stringWithFormat:@"跳过%ld",time] forState:UIControlStateNormal];
    
    if (time-- < 0) {
        [self.timer invalidate];
        [self jump];
    }



}
    
- (void)jump{
    [self.timer invalidate];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[GSMainTabbarController alloc]init];

    
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
