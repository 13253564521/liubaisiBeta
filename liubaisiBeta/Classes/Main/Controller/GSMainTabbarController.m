//
//  GSMainTabbarController.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/2.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSMainTabbarController.h"
#import "GSMainNavigationController.h"
#import "GSADDTabBar.h"

#import "GSEssenceController.h"
#import "GSFollowViewController.h"
#import "GSNewViewController.h"
#import "GSMeViewController.h"
@interface GSMainTabbarController ()

@end

@implementation GSMainTabbarController
+ (void)initialize{
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *nomalAttr = [NSMutableDictionary dictionary];
    nomalAttr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    nomalAttr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    NSMutableDictionary *selectAttr = [NSMutableDictionary dictionary];
    nomalAttr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    [item setTitleTextAttributes:nomalAttr forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttr forState:UIControlStateSelected];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addAllController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addAllController{
    //精华
    [self addChildController:[[GSEssenceController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    
    //新帖
    [self addChildController:[[GSNewViewController alloc]init] title:@"新贴" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    //
    
    //关注
    [self addChildController:[[GSFollowViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    //我
    [self addChildController:[[GSMeViewController alloc]init] title:@"我" 	image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
    //加号按钮
    [self setValue:[[GSADDTabBar alloc]init] forKey:@"tabBar"];



}
- (void)addChildController:(UIViewController *)viewcontroller title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage{
    viewcontroller.title = title;
    viewcontroller.tabBarItem.image = [UIImage imageNamed:image];
    viewcontroller.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    GSMainNavigationController *mainNav = [[GSMainNavigationController alloc]initWithRootViewController:viewcontroller];
    [self addChildViewController:mainNav];

}
@end
