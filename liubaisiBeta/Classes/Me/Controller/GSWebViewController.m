//
//  GSWebViewController.m
//  liubaisiBeta
//
//  Created by 刘高升 on 17/3/20.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSWebViewController.h"
#import "NJKWebViewProgress.h"

@interface GSWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;


/**
 进度代理对象
 */
@property(nonatomic,strong) NJKWebViewProgress *progress;
@end

@implementation GSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self.url hasPrefix:@"http"]) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        [self.webView loadRequest:request];
    }else{
        [SVProgressHUD showErrorWithStatus:@"此链接为无效链接"];
        self.progressView.hidden = YES;
    }

    self.progress = [[NJKWebViewProgress alloc]init];
    self.webView.delegate = self.progress;
    WeakSelf;
    self.progress.progressBlock = ^(float progress){
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.hidden =  (progress == 1.0);
    };
}
- (IBAction)gobackClick:(UIBarButtonItem *)sender {
    
    [self.webView goBack];
}
- (IBAction)forwardClick:(UIBarButtonItem *)sender {
    [self.webView goForward];
}
- (IBAction)refreshClick:(id)sender {
    [self.webView reload];
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
