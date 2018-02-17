//
//  TZCDetaillViewController.m
//  ZSLIB-ERequest
//
//  Created by chaozi on 16/3/12.
//  Copyright © 2016年 chaozi. All rights reserved.
//

#import "TZCDetaillViewController.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface TZCDetaillViewController ()

@end

@implementation TZCDetaillViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  //  [self.navigationController  setToolbarHidden:YES animated:YES];
    [self loaddata];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) loaddata{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGRect frame = CGRectMake(0, 1, rect.size.width - 1.0, rect.size.height);
    UIWebView* webView = [[UIWebView alloc]initWithFrame:frame];
    
    [webView loadRequest:_request];
    
    webView.backgroundColor=[UIColor clearColor];
    webView.hidden = NO;
    webView.scalesPageToFit = NO;//自动对页面进行缩放以适应屏幕
    
    [UIView beginAnimations:nil context:(__bridge void * _Nullable)(self)];
    [UIView setAnimationDuration:0.2];
    webView.transform=CGAffineTransformMakeScale(1,1);
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
    [self.view addSubview:webView];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - WebView
- (void)webViewDidStartLoad:(UIWebView *)webView {
    kApplication.networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    kApplication.networkActivityIndicatorVisible = NO;
}
@end
