//
//  WebViewController.m
//  team
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
   self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //加载webView
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    self.webView.backgroundColor = [UIColor whiteColor];
    
    self.webView.delegate = self;
        
    
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- ( void )webView:( UIWebView *)webView didFailLoadWithError:( NSError *)error{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"访问失败" message:@"请求发生错误" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        });
        
    });

}





@end
