//
//  changeImageViewController.m
//  team
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "changeImageViewController.h"
#import "ImageUtil.h"
#import "ColorMatrix.h"
#import "UMSocial.h"
#import "RootViewController.h"
@interface changeImageViewController ()<UMSocialUIDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *filterView;

@property (nonatomic, strong) UILabel *filterLabel;
@property (nonatomic, strong) UIImage *image;
@end

@implementation changeImageViewController
- (UIImageView *)filterView
{
    if (_filterView == nil) {
        _filterView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,0.0f, Width, Width)];
        _filterView.userInteractionEnabled = YES;
        _filterView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _filterView;
}

- (UILabel *)filterLabel
{
    if (_filterLabel == nil) {
        _filterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, Width + 20, self.view.frame.size.width, 25.0f)];
        _filterLabel.backgroundColor = [UIColor clearColor];
        _filterLabel.textColor = [UIColor orangeColor];
        _filterLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _filterLabel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        
        // iOS 7
        
        [self prefersStatusBarHidden];
        
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
#pragma mark 滤镜

    UIImage *image= [UIImage imageWithData:self.data];
    

    self.filterView.image = image;
    
     self.filterView.clipsToBounds = YES;
    
     self.filterView.contentMode = UIViewContentModeScaleAspectFill;

    self.image = image;

    
    [self.view addSubview:self.filterView];
    
    self.filterLabel.text = @"原图";
    [self.view addSubview:self.filterLabel];
    
    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
    [sender setTitle:@"美图" forState:UIControlStateNormal];
    sender.frame = CGRectMake(self.view.frame.size.width/2.0f - 50.0f,Width + 70, 100.0f, 30.0f);
    sender.backgroundColor = [UIColor redColor];
    sender.layer.cornerRadius = 5.0f;
    [sender addTarget:self action:@selector(senderAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender];
    
    UIButton *sender1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [sender1 setTitle:@"菜单" forState:UIControlStateNormal];
    sender1.frame = CGRectMake(self.view.frame.size.width / 2.0f - 50.f, Width + 120, 100.0f, 30.0f);
    sender1.backgroundColor = [UIColor redColor];
    sender1.layer.cornerRadius = 5.0f;
    [sender1 addTarget:self action:@selector(senderAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender1];
    
    
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lpgrAction:)];
    
    lpgr.minimumPressDuration = 1;
    lpgr.allowableMovement = 1;
    
    [self.view addGestureRecognizer:lpgr];
    

    
    
}
- (BOOL)prefersStatusBarHidden
{
    
    return YES;//隐藏为YES，显示为NO
}



- (void)tgrAction:(UITapGestureRecognizer *)sender
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"菜单" message:@"选择吧" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"保存到相册并替换该图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSData *data = UIImagePNGRepresentation(self.filterView.image);
        
        UIImageWriteToSavedPhotosAlbum(self.filterView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
        self.block(data);
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"保存到相册但不替换图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         UIImageWriteToSavedPhotosAlbum(self.filterView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"替换图片但不保存到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSData *data = UIImagePNGRepresentation(self.filterView.image);
        
        
        self.block(data);
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"不替换也不保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"我想看看效果呢" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         NSData *data = UIImagePNGRepresentation(self.filterView.image);
        
        RootViewController *root= [RootViewController new];
        root.data = data;
        root.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self showDetailViewController:root sender:nil];
        
        
    }];
    UIAlertAction *action7 = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"5645a32ce0f55afcea001210"
                                          shareText:@"来自迹忆的分享"
                                         shareImage:self.filterView.image
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,nil]
                                           delegate:self];

    }];
    
    
    
    UIAlertAction *action6 = [UIAlertAction actionWithTitle:@"我还没修好呢" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:action4];
    [alertController addAction:action5];
    [alertController addAction:action6];
    [alertController addAction:action7];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if(error == nil) {
        
        
        [self save:1];
    }else{
        
   
        [self save:0];
        
    }
    
}

- (void)save:(NSInteger)sender
{
if (sender == 1)
{
    //保存成功
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timeAction1:) userInfo:nil repeats:NO];
   
    
}else if (sender == 0)
{
    
    //保存失败
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timeAction0:) userInfo:nil repeats:NO];
    
   
}
}


//标题没有
- (void)timeAction1:(NSTimer *)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"已存入手机相册" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        });
        
    });
    
    
}




//标题没有
- (void)timeAction0:(NSTimer *)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存失败" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        });
        
    });
    
    
}

    
    
    
    
    
    
    
    


- (void)lpgrAction:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        
        
    }
 
}



- (void)senderAction
{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修图" message:@"选择你喜欢的模式吧" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *ActionOriginal1 = [UIAlertAction actionWithTitle:@"原图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.filterView.image = _image;
         self.filterLabel.text = @"原图";
        
    }];
    UIAlertAction *ActionLomo2 = [UIAlertAction actionWithTitle:@"LOMO" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_lomo];
        self.filterLabel.text = @"LOMO";
        
    }];
    UIAlertAction *ActionBlackAndWhite3 = [UIAlertAction actionWithTitle:@"黑白" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_heibai];
        self.filterLabel.text = @"黑白";
        
    }];
    UIAlertAction *ActionAncient4  = [UIAlertAction actionWithTitle:@"复古" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_huajiu];
        self.filterLabel.text = @"复古";
    }];
    UIAlertAction *ActionGothic5 = [UIAlertAction actionWithTitle:@"哥特" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_gete];
        self.filterLabel.text = @"哥特";
        
    }];
    UIAlertAction *Actionsharpen6 = [UIAlertAction actionWithTitle:@"锐化" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_ruise];
        
        self.filterLabel.text = @"锐化";
    }];
    UIAlertAction *ActionQuietly7 = [UIAlertAction actionWithTitle:@"淡雅" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_danya];
        self.filterLabel.text = @"淡雅";
        
    }];
    UIAlertAction *ActionRedwine8 = [UIAlertAction actionWithTitle:@"酒红" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_jiuhong];
        
        self.filterLabel.text = @"酒红";
    }];
    UIAlertAction *Actionlime9 = [UIAlertAction actionWithTitle:@"清宁" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_qingning];
        self.filterLabel.text = @"清宁";
    }];
    UIAlertAction *ActionRomantic10 = [UIAlertAction actionWithTitle:@"浪漫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_langman];
         self.filterLabel.text = @"浪漫";
    }];
    UIAlertAction *ActionHalo11 = [UIAlertAction actionWithTitle:@"光晕" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_guangyun];
         self.filterLabel.text = @"光晕";
    }];
    UIAlertAction *ActionBlues12 = [UIAlertAction actionWithTitle:@"蓝调" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_landiao];
         self.filterLabel.text = @"蓝调";
    }];
    UIAlertAction *ActionDream13 = [UIAlertAction actionWithTitle:@"梦幻" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_menghuan];
        self.filterLabel.text = @"梦幻";
    }];
    UIAlertAction *ActionNight14 = [UIAlertAction actionWithTitle:@"夜色" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_yese];
           self.filterLabel.text = @"夜色";
    }];
    
    UIAlertAction *ActionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    
    [alertController addAction:ActionOriginal1];
    [alertController addAction:ActionLomo2];
    [alertController addAction:ActionBlackAndWhite3];
    [alertController addAction:ActionAncient4];
    [alertController addAction:ActionGothic5];
    [alertController addAction:Actionsharpen6];
    [alertController addAction:ActionQuietly7];
    [alertController addAction:ActionRedwine8];
    [alertController addAction:Actionlime9];
    [alertController addAction:ActionRomantic10];
    [alertController addAction:ActionHalo11];
    [alertController addAction:ActionBlues12];
    [alertController addAction:ActionDream13];
    [alertController addAction:ActionNight14];
    [alertController addAction:ActionCancel];
    
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    
    
}


- (void)senderAction1
{
    [self tgrAction:nil];
}




- (UIImage *)image
{
    if (!_image) {
        
        self.image = [UIImage new];
    }
    return _image;
}





@end
