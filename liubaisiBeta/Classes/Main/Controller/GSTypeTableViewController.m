//
//  GSTypeTableViewController.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/2.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSTypeTableViewController.h"

#import "GSNewViewController.h"
#import "GSTopicCell.h"
#import "GSTopicModel.h"
@interface GSTypeTableViewController ()

/**
 帖子的数据
 */
@property(nonatomic,strong) NSMutableArray *topics;
/**
 当前页码
 */
@property (nonatomic,assign) NSInteger page;
/**
 加载下一页所需要的参数
 */
@property (nonatomic , copy) NSString *maxtime;


/**
 记录上次选中的索引
 */
@property (nonatomic,assign) NSInteger lastSelectIndex;

@end
//重用标识
static NSString *const identifier = @"topiccell";

@implementation GSTypeTableViewController
/**懒加载*/
-(NSMutableArray *)topics{
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = GSGlobalBg;
    //初始化表格
    [self setUpTableView];
    [self setUpRefresh];
}
- (void)setUpTableView{

    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top  = GSTitleViewHeight + GSNav_StateHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GSTopicCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    
    //监听tabbar点击
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabbarClick) name:GSTabBarDidSelectNotification object:nil ];

}

- (void)setUpRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    //自动改变透明度,让header全透明
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];


}

- (NSString *)a{
    //父控制器
    return [self.parentViewController isKindOfClass:[GSNewViewController class]] ? @"newlist" : @"list";

}
//下拉刷新
- (void)loadData{
    WeakSelf;
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    [GSNetWorkTools GET:HomePage parameters:params isHud:YES complationHandle:^(id responseObject, NSError *error) {
        if (!error) {
//            NSLog(@"%@",responseObject);
            //存储maxtime
            weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
            NSArray *tempArray = [GSTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [weakSelf.topics addObjectsFromArray:tempArray];
            weakSelf.page = 0;
            //刷新表格
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }else{
        
            [self.tableView.mj_header endRefreshing];
        }
        
        
    }];
}
//上啦加载更多
- (void)loadMoreData{

    WeakSelf;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    
    
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    
    // 当前时间之前的数据---------
    params[@"maxtime"] = self.maxtime;
    [GSNetWorkTools GET:HomePage parameters:params isHud:NO complationHandle:^(id responseObject, NSError *error) {
        if (!error) {
            //更新最新的maxtime
            weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
            //字典 - 》 模型
            NSArray *tempArray = [GSTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            //添加到自己的数组
            [weakSelf.topics addObjectsFromArray:tempArray];
            //刷新表格
            [weakSelf.tableView reloadData];
            //结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
            weakSelf.page = page;
            
        }else{
            //结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    }];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
 
}

#pragma mark - 事件
- (void)tabbarClick{
    // 如果是连续选中2次(点击的是当前的tabitem), 直接刷新
    if (self.lastSelectIndex == self.tabBarController.selectedIndex && self.view.isShowingOnKeyWindow) {
        [self.tableView.mj_header beginRefreshing];
    }
    //记录选中的索引
    self.lastSelectIndex = self.tabBarController.selectedIndex;

}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

//预估高高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200;


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GSTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.model = self.topics[indexPath.row];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    GSTopicModel *model = self.topics[indexPath.row];
    return model.cellHeight;

}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
