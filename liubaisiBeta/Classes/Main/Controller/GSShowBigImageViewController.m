//
//  GSShowBigImageViewController.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/15.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSShowBigImageViewController.h"

#import "GSTopicModel.h"

#import <AssetsLibrary/AssetsLibrary.h>

static NSString * const GSGroupNameKey = @"GSGroupNameKey";
static NSString * const GSDefaultGroupName = @"百思不得姐3";

@interface GSShowBigImageViewController ()
{
    /**基类滑动视图 */
    UIScrollView *_baseScrollView;
    /**基类滑动视图 */
    UIImageView *_imageView;
    /**返回按钮 */
    UIButton *_backButton;
    /**保存按钮 */
    UIButton *_savaButton;
    /**转发按钮*/
    UIButton *_forwardingButton;

}
/** 相册库 */
@property (nonatomic, strong) ALAssetsLibrary *library;
/**
 imageSaved
 */
@property (nonatomic,assign) BOOL imageSaved;
@end

@implementation GSShowBigImageViewController

- (ALAssetsLibrary *)library{
    if (!_library) {
        _library = [[ALAssetsLibrary alloc]init];
    }
    return _library;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initContentView];
}

- (void)initContentView{

    //scrollView
    _baseScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _baseScrollView.userInteractionEnabled = YES;
    
    
    [self.view addSubview:_baseScrollView];
    
    //图片
    _imageView = [[UIImageView alloc]init];
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self loadImageView:_imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backClick)];
    [_imageView addGestureRecognizer:tap];
    [_baseScrollView addSubview:_imageView];
  
    //返回按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(15, 40, 35, 35);
    [_backButton setBackgroundImage:[UIImage imageNamed:@"show_image_back_icon"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
    //保存按钮
    _savaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _savaButton.frame = CGRectMake(kSCREENWIDTH - 20 - 70 * 2, kSCREENHEIGHT - 25 - 20, 70, 25);
    [_savaButton setTitle:@"保存" forState:UIControlStateNormal];
    [_savaButton setBackgroundColor:[UIColor lightGrayColor]];
    _savaButton.titleLabel.textColor = [UIColor whiteColor];
    
    [_savaButton addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_savaButton];
    //转发按钮
    _forwardingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _forwardingButton.frame = CGRectMake(kSCREENWIDTH - 10 - 70 , kSCREENHEIGHT - 25 - 20, 70, 25);
    [_forwardingButton setTitle:@"转发" forState:UIControlStateNormal];
    [_forwardingButton setBackgroundColor:[UIColor lightGrayColor]];
    _forwardingButton.titleLabel.textColor = [UIColor whiteColor];
    
    [_forwardingButton addTarget:self action:@selector(forwardClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forwardingButton];

}

- (void)loadImageView:(UIImageView *)imageView{

    //图片尺寸
    CGFloat picW = kSCREENWIDTH;
    CGFloat picH = picW * self.model.height / self.model.width;
    if (picH > kSCREENHEIGHT) {
        imageView.frame = CGRectMake(0, 0, picW, picH);
        _baseScrollView.contentSize = CGSizeMake(0, picH);
    }else{
    
        imageView.size = CGSizeMake(picW, picH);
        
        //图片在中间的位置
        imageView.centerY = kSCREENHEIGHT * 0.5;
    
    
    }
    //下载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.large_image]];



}

#pragma mark - 点击事件
- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//保存操作
- (void)saveClick{
    
    
    [self saveImage];


}

- (NSString *)groupName{
    //从沙盒中获取名称
    NSString *name = [[NSUserDefaults standardUserDefaults]objectForKey:GSGroupNameKey];
    if (name == nil) {
        name = GSDefaultGroupName;
        
        //把名字存到沙盒中
        [[NSUserDefaults standardUserDefaults]setObject:name forKey:GSGroupNameKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    return name;
}


- (void)saveImage{
    
    if (_imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片没有下载完毕！"];
        return;
    }
    
    
    //获取文件夹名字
    __block NSString *groupName = self.groupName;
    
    WeakSelf;
    
    //图片库
    __weak ALAssetsLibrary *library = self.library;
    
    //在相册中创建文件夹
    // 在相册中创建文件夹(百思不得姐3)
    [library addAssetsGroupAlbumWithName:groupName resultBlock:^(ALAssetsGroup *group) {
        
        if (group) { // 新创建的文件夹
            
            // 添加图片到文件夹中
            
            [weakSelf addImageToGroup:group];
        } else {
            
            [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                // QQ  百思不得姐3
                NSString *name = [group valueForProperty:ALAssetsGroupPropertyName];
                
                if ([name isEqualToString:groupName]) { // 是自己创建的文件夹
                    // 添加图片到文件夹中
                    [weakSelf addImageToGroup:group];
                    
                    *stop = YES; // 停止遍历
                } else if ([name isEqualToString:@"Camera Roll"]) {
                    

                    // 文件夹被用户强制删除了
                    groupName = [groupName stringByAppendingString:@" "];
                    // 存储新的名字
                    [[NSUserDefaults standardUserDefaults] setObject:groupName forKey:GSGroupNameKey];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    
                    
                    // 创建新的文件夹
                    [library addAssetsGroupAlbumWithName:groupName resultBlock:^(ALAssetsGroup *group) {
                        // 添加图片到文件夹中
                        [weakSelf addImageToGroup:group];
                    } failureBlock:nil];
                }
            } failureBlock:nil];
        }
    } failureBlock:nil];


}

/**
 * 添加一张图片到某个文件夹中
 */
- (void)addImageToGroup:(ALAssetsGroup *)group
{
    __weak ALAssetsLibrary *weakLibrary = self.library;
    // 需要保存的图片 CGImage  强制保存到手机上，可能会被压缩
    CGImageRef image = _imageView.image.CGImage;
    
    // 添加图片到【相机胶卷】Camera Roll
    [weakLibrary writeImageToSavedPhotosAlbum:image metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        
        // 通过Camera Roll里面的图片的本地地址得到这张图片--
        [weakLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
#warning 给自定义的组当中添加图片addAsset
            
            
            
            
            //            // 避免重复保存
            //            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            //
            //
            //                if (result != asset) {
            //                    // 添加一张图片到自定义的文件夹中,自动避免重复添加当前图片
            //                    [group addAsset:asset];
            //
            //                    [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
            //                }
            //            }];
            
            
            
            // 添加一张图片到自定义的文件夹中,自动避免重复添加当前图片
            self.imageSaved = [group addAsset:asset];
            
            if (self.imageSaved) {
                
                [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
            }
            
        } failureBlock:nil];
    }];
}


//转发操作
- (void)forwardClick{
    [SVProgressHUD showErrorWithStatus:@"转发功能正在开发中。。。"];

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
