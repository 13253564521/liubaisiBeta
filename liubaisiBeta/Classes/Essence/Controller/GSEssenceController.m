//
//  GSEssenceController.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/2.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSEssenceController.h"
#import "GSTypeTableViewController.h"
#import "GSRecommendController.h"
@interface GSEssenceController ()<UIScrollViewDelegate>
{
    /**内部控件*/
    UIView *_topTitleView;
    //下划线
    UIView *_lineView;
    //按钮
    UIButton *_selectButton;
    
    //基础视图
    UIScrollView *_scrollView;


}
@end

@implementation GSEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self addChildCntroller];
    [self setContentView];
    [self setTopTitleView];
    
}
//设置导航栏
- (void)setUpNav{
    //导航栏左侧按钮
    UIButton *leftButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 20);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    //中间标题
    UIImageView *titleView = [[UIImageView alloc]init];
    titleView.frame = CGRectMake(0, 0, 100, 20);
    titleView.image = [UIImage imageNamed:@"MainTitle"];
    self.navigationItem.titleView = titleView;

}
//添加子控制器
- (void)addChildCntroller{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //全部
    GSTypeTableViewController *all = [[GSTypeTableViewController alloc]init];
    all.title = @"全部";
    all.type = GSBaiSiTypeAll;
    [self addChildViewController:all];
    
    //视频
    GSTypeTableViewController *video = [[GSTypeTableViewController alloc]init];
    video.title = @"视频";
    video.type = GSBaiSiTypeVideo;
    [self addChildViewController:video];
    
    //声音
    GSTypeTableViewController *voice = [[GSTypeTableViewController alloc]init];
    voice.title = @"声音";
    voice.type = GSBaiSiTypeVoice;
    [self addChildViewController:voice];
    
    //图片
    GSTypeTableViewController *picture = [[GSTypeTableViewController alloc]init];
    picture.title = @"图片";
    picture.type = GSBaiSiTypePicture;
    [self addChildViewController:picture];
    
    //文字
    GSTypeTableViewController *word = [[GSTypeTableViewController alloc]init];
    word.title = @"段子";
    word.type = GSBaiSiTypeWord;
    [self addChildViewController:word];

}
//设置顶部的titleView
- (void)setTopTitleView{
    //背景View
    _topTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, GSNav_StateHeight, kSCREENWIDTH, GSTitleViewHeight)];
    _topTitleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    [self.view addSubview:_topTitleView];
    
    //下划线
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor redColor];
    _lineView.y = GSTitleViewHeight - 1;
    _lineView.height = 1;
   
    
    //按钮
    NSInteger x = 0;
    CGFloat y = 0;
    CGFloat w = kSCREENWIDTH / self.childViewControllers.count;
    CGFloat h = GSTitleViewHeight - 1;
    for (UIViewController *subVc in self.childViewControllers) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = 1000 + x;
        titleButton.frame = CGRectMake(x * w, y, w, h);
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleButton setTitle:subVc.title forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        //点击事件
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topTitleView addSubview:titleButton];
        if (x == 0) {
            titleButton.enabled = NO;
            _selectButton = titleButton;
            [titleButton.titleLabel sizeToFit];
            _lineView.width = titleButton.titleLabel.width;
            _lineView.centerX = titleButton.centerX;
        }
        x++;
    }

    [_topTitleView addSubview:_lineView];

}
//设置内容视图
- (void)setContentView{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(_scrollView.width * self.childViewControllers.count, _scrollView.height);
    [self.view addSubview:_scrollView];
    [self scrollViewDidEndScrollingAnimation:_scrollView];
}

#pragma  mark - UIScrollViewDelegate
//动画结束后调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //索引
    NSInteger i = scrollView.contentOffset.x / scrollView.width;
    //拿出对应控制器的View
    UIViewController *subVc = self.childViewControllers[i];
    subVc.view.x = scrollView.contentOffset.x;
    subVc.view.y = 0; //设置控制器view的y值为0(默认是20
    subVc.view.height = scrollView.height;
    [_scrollView addSubview:subVc.view];
    


}
//减速后调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //索引
    NSInteger i = scrollView.contentOffset.x / scrollView.width;
    //调用此方法加载没个控制器的View
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击按钮
    [self titleButtonClick:_topTitleView.subviews[i]];


}
#pragma mark - 点击事件
- (void)leftButtonClick{

    GSRecommendController *recommendVc = [[GSRecommendController alloc]init];
    [self.navigationController pushViewController:recommendVc animated:YES];
}

- (void)titleButtonClick:(UIButton *)sender{
    _selectButton.enabled = YES;
    sender.enabled = NO;
    _selectButton = sender;
    
    //下划线动画
    [UIView animateWithDuration:0.25 animations:^{
        _lineView.width = sender.titleLabel.width;
        _lineView.centerX = sender.centerX;
    }];
    //scrollView
    _scrollView.contentOffset = CGPointMake((sender.tag - 1000) * _scrollView.width, 0);
    [self scrollViewDidEndScrollingAnimation:_scrollView];


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
