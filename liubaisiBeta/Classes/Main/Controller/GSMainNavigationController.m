//
//  GSMainNavigationController.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/2.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSMainNavigationController.h"

@interface GSMainNavigationController ()

@end

@implementation GSMainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
+ (void)initialize{

    UINavigationBar *navBar = [UINavigationBar appearance];
    //设置背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    //设置文字
    UIBarButtonItem *item  = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttr = [NSMutableDictionary dictionary];
    itemAttr[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    itemAttr[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:itemAttr forState:UIControlStateNormal];
    
    NSMutableDictionary *itemDisableAttr = [NSMutableDictionary dictionary];
    itemAttr[NSForegroundColorAttributeName] = [UIColor redColor];
    [item setTitleTextAttributes:itemDisableAttr forState:UIControlStateDisabled];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.viewControllers.count > 0) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 35, 20);
        backButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        //按钮内部的内容左对齐
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //让按钮向左移动10；
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        //文字颜色
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        //事件
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:YES];
}

- (void)back{

    [self popViewControllerAnimated:YES];

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
