//
//  GSMeViewController.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/2.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSMeViewController.h"
#import "GSWebViewController.h"

#import "GSSquarelistModel.h"



#import "GSMeCollectionViewCell.h"
@interface GSMeViewController ()<UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource>
{
    UITableView *_tableView;
    
    UICollectionView *_collectionView;


}


/**
 我的模型数组
 */
@property(nonatomic,strong) NSMutableArray *squarelist;


@end
static NSString *const collectionIdtentifier = @"collectionCell";

@implementation GSMeViewController
-(NSMutableArray *)squarelist{
    if (!_squarelist) {
        _squarelist = [NSMutableArray array];
    }
    return _squarelist;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self loadData];
    [self setUpTableView];
}

- (void)setUpNav{
    
    //设置右边按钮
    UIButton *rightButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton1.frame = CGRectMake(0, 0, 40, 30);
    [rightButton1 setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [rightButton1 setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    [rightButton1 addTarget:self action:@selector(moonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightButton1];
    
    UIButton *rightButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton2.frame = CGRectMake(0, 0, 40, 30);
    [rightButton2 setImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [rightButton2 setImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    [rightButton2 addTarget:self action:@selector(moonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc]initWithCustomView:rightButton2];
    
    self.navigationItem.rightBarButtonItems = @[right,right2];


}

- (void)loadData{
    WeakSelf;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    [GSNetWorkTools GET:HomePage parameters:params isHud:YES complationHandle:^(id responseObject, NSError *error) {
//        NSLog(@"我的：%@",responseObject);
        weakSelf.squarelist = [GSSquarelistModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        [weakSelf setUpcollectionViewWithItemCount:weakSelf.squarelist];
        [_collectionView reloadData];
        
    }];



}


//初始化tabbleView
- (void)setUpTableView{

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT - GSTabBarH) style:UITableViewStylePlain];
    _tableView.backgroundColor = GSGlobalBg;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 200)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    [self.view addSubview:_tableView];


}
//初始化collectionView
- (void)setUpcollectionViewWithItemCount:(NSArray *)itemCount{
    NSInteger const count = 4;
    NSInteger const minMargin = 1;
    
    
    //创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kSCREENWIDTH  - minMargin * (count - 1))/ count, (kSCREENWIDTH  - minMargin * (count - 1))/ count + 20);
    layout.minimumLineSpacing = minMargin;
    layout.minimumInteritemSpacing = minMargin;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, layout.itemSize.height * (itemCount.count / 4)) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = GSGlobalBg;
    //注册cell
    [_collectionView registerClass:[GSMeCollectionViewCell class] forCellWithReuseIdentifier:collectionIdtentifier];
    
    
    _tableView.tableFooterView = _collectionView;

}


- (void)moonClick{

    NSLog(@"%s",__func__);

}


#pragma mark - UITableViewDelegate , UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.textColor = [UIColor grayColor];
    }
    if (indexPath.section == 0) {
        
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.imageView.layer.cornerRadius = cell.imageView.width / 2;
        cell.imageView.clipsToBounds = YES;
        cell.textLabel.text = @"登录/注册";
    }else if (indexPath.section == 1){
        
        cell.textLabel.text = @"本地视频";
    }else{
    
        cell.textLabel.text = @"离线下载";
    
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        
        return 20;
    }

    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}



#pragma  mark - UICollectionViewDelegate , UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.squarelist.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GSMeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdtentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    GSSquarelistModel *model = self.squarelist[indexPath.row];
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"header_cry_icon"]];
    cell.title.text = model.name;

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    GSSquarelistModel *model = self.squarelist[indexPath.row];
    GSWebViewController *webVc = [[GSWebViewController alloc]init];
    webVc.url = model.url;
    webVc.title = model.name;
    [self.navigationController pushViewController:webVc animated:YES];


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
