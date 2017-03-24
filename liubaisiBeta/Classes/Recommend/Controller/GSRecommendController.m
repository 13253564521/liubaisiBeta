//
//  GSRecommendController.m
//  LiuBaiSi
//
//  Created by 刘高升 on 17/2/27.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSRecommendController.h"
#import "GSRecomendModel.h"
#import "GSRecommendCell.h"
@interface GSRecommendController ()<UITableViewDelegate , UITableViewDataSource>

/**
 推荐标签数组
 */
@property(nonatomic,strong) NSMutableArray *recommnendArray;
@end

@implementation GSRecommendController
-(NSMutableArray *)recommnendArray{
    if (_recommnendArray == nil) {
        _recommnendArray = [[NSMutableArray alloc]init];
    }
    return _recommnendArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
}
- (void)initTableView{
    self.title = @"推荐标签";
    self.tableView.backgroundColor = GSGlobalBg;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(laodData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)laodData{
    WeakSelf;
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [GSNetWorkTools GET:Subscribe parameters:params isHud:YES complationHandle:^(id responseObject, NSError *error) {
//        NSLog(@"%@",responseObject);
        if (!error) {
            weakSelf.recommnendArray = responseObject;
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView reloadData];
        }else{
            NSLog(@"%@",error);
        }
        
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommnendArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GSRecommendCell *cell = [GSRecommendCell initRecommendCellWithTableView:tableView indexPath:indexPath];
    cell.model = [GSRecomendModel mj_objectWithKeyValues:self.recommnendArray[indexPath.row]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

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

@end
