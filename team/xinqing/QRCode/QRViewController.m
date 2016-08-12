//
//  QRViewController.m
//  team
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "QRViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "WebViewController.h"
@interface QRViewController ()<AVCaptureMetadataOutputObjectsDelegate>





@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property (strong, nonatomic) UIView *boxView;
@property (nonatomic) BOOL isReading;
@property (strong, nonatomic) CALayer *scanLayer;
//捕捉会话
@property (nonatomic, strong) AVCaptureSession *captureSession;
//展示layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;


@property(nonatomic,strong)NSString *url;
@end

@implementation QRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _captureSession = nil;
    _isReading = NO;
    
    self.title = @"扫一扫";
    
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startReading];
}

- (BOOL)startReading {
    NSError *error;
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2.用captureDevice创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
 
        return NO;
    }
    //3.创建媒体数据输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    //4.实例化捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    //4.1.将输入流添加到会话
    [_captureSession addInput:input];
    //4.2.将媒体输出流添加到会话中
    [_captureSession addOutput:captureMetadataOutput];
    //5.创建串行队列，并加媒体输出流添加到队列当中
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    //5.1.设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //5.2.设置输出媒体数据类型为QRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    //6.实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    //7.设置预览图层填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //8.设置图层的frame
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    //9.将图层添加到预览view的图层上
    _videoPreviewLayer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    //10.设置扫描范围 默认值是（0，0，1，1）
    captureMetadataOutput.rectOfInterest = CGRectMake(0.1f, 0.1f, 0.8f, 0.8f);
    //10.1.扫描框
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(_viewPreview.bounds.size.width * 0.1f, _viewPreview.bounds.size.height * 0.1f, _viewPreview.bounds.size.width - _viewPreview.bounds.size.width * 0.2f, _viewPreview.bounds.size.height - _viewPreview.bounds.size.height * 0.2f)];

    _boxView.layer.borderColor = [UIColor greenColor].CGColor;
    _boxView.layer.borderWidth = 1.0f;
    [_viewPreview addSubview:_boxView];
    //10.2.扫描线
    _scanLayer = [[CALayer alloc] init];
    _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, 1);
    _scanLayer.backgroundColor = [UIColor brownColor].CGColor;
    [_boxView.layer addSublayer:_scanLayer];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    [timer fire];
    
    //10.开始扫描
    [_captureSession startRunning];
    return YES;
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        
 
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            [_lblStatus performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            _lblStatus.numberOfLines = 0;
            
            //[self performSelector:@selector(stopReading) withObject:nil];
            
            _isReading = NO;
            
            if ([metadataObj.stringValue hasPrefix:@"http"]) {
                
                self.url = metadataObj.stringValue;

                                        }
            
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            
           
        }
    }
}
#pragma mark - 实现计时器方法
- (void)moveScanLayer:(NSTimer *)timer
{
    CGRect frame = _scanLayer.frame;
    if (_boxView.frame.size.height <= _scanLayer.frame.origin.y) {
        frame.origin.y = 0;
        _scanLayer.frame = frame;
    }else{
        frame.origin.y += 5;
        [UIView animateWithDuration:0.1 animations:^{
            _scanLayer.frame = frame;
        }];
    }
}
#pragma mark -
- (IBAction)startStopReading:(id)sender {
    if (!_isReading) {
        if ([self startReading]) {
            [_startBtn setTitle:@"再扫一次" forState:UIControlStateNormal];
            [_lblStatus setText:@""];
        }
    }
//    else{
//        [self stopReading];
//        [_startBtn setTitle:@"扫描完成" forState:UIControlStateNormal];
//    }
//    _isReading = !_isReading;
}

-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_scanLayer removeFromSuperlayer];
    [_videoPreviewLayer removeFromSuperlayer];
    
    
    if ([self.url hasPrefix:@"http"]) {
        
    
    WebViewController *webVC = [[UIStoryboard storyboardWithName:@"NIU" bundle:nil] instantiateViewControllerWithIdentifier:@"webView"];

    webVC.url = self.url;
        
        self.url = @"";
    [self.navigationController showViewController:webVC sender:nil];
    }
    
//    WebViewController *webVC = [WebViewController new];
//    //webVC.url = metadataObj.stringValue;
//    [self.navigationController showViewController:webVC sender:nil];

    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
