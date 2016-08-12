//
//  WriteDiaryViewController.m
//  team
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "WriteDiaryViewController.h"


#define WIDTH ([UIScreen mainScreen].bounds.size.width-15)/2
CGFloat const kImageCount = 16;

static NSString *identifier = @"collectionView";


@interface WriteDiaryViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionView *collecttionView;
@property (nonatomic,strong)UIImageView *imageView;

//存放图片的数组
@property(nonatomic,strong)NSArray *imageArray;


@end

@implementation WriteDiaryViewController


-(NSArray *)imageArray{
    if (!_imageArray) {
        NSMutableArray *muArr = [NSMutableArray new];
        
        
        
       
        
        
        
        //设置imageView的宽高适应图片宽高
//        UIImage *image1 = [UIImage imageNamed:@"2211"];
//        UIImage *image1 = [UIImage imageNamed:@"1"];
//        UIImageView *imageV1 = [[UIImageView alloc] initWithImage:image1];
//        imageV1.frame = CGRectMake(0, 0, (WIDTH) / 2,((Height - 64 - 15) / 2) * 0.75);
//        
////        UIImage *image2 = [UIImage imageNamed:@"2227"];
//        UIImage *image2 = [UIImage imageNamed:@"2"];
//        UIImageView *imageV2 = [[UIImageView alloc] initWithImage:image2];
//        imageV2.frame = CGRectMake(0, 0, (WIDTH) / 2,((Height - 64 - 25) / 2) * 0.375);
//        
//        
////        UIImage *image3 = [UIImage imageNamed:@"2223"];
//        UIImage *image3 = [UIImage imageNamed:@"3"];
//        UIImageView *imageV3 = [[UIImageView alloc] initWithImage:image3];
//        imageV3.frame = CGRectMake(0, 0, (WIDTH) / 2,((Height - 64 - 25) / 2) * 0.25);
//        
////        UIImage *image4 = [UIImage imageNamed:@"2224"];
//        UIImage *image4 = [UIImage imageNamed:@"4"];
//        UIImageView *imageV4 = [[UIImageView alloc] initWithImage:image4];
//        imageV4.frame = CGRectMake(0, 0, (WIDTH) / 2,((Height - 64 - 25) / 2) * 0.25);
//        
//        
////        UIImage *image5 = [UIImage imageNamed:@"2225"];
//        UIImage *image5 = [UIImage imageNamed:@"5"];
//        UIImageView *imageV5 = [[UIImageView alloc] initWithImage:image5];
//        imageV5.frame = CGRectMake(0, 0, (WIDTH) / 2,((Height - 64 - 15) / 2) * 0.25);
//        
////        UIImage *image6 = [UIImage imageNamed:@"2226"];
//        UIImage *image6 = [UIImage imageNamed:@"6"];
//        UIImageView *imageV6 = [[UIImageView alloc] initWithImage:image6];
//        imageV6.frame = CGRectMake(0, 0, (WIDTH) / 2,((Height - 64 - 25) / 2) * 0.125);
        
        //设置imageView的宽高适应图片宽高
       UIImage *image1 = [UIImage imageNamed:@"1"];
        UIImageView *imageV1 = [[UIImageView alloc] initWithImage:image1];
        imageV1.frame = CGRectMake(0, 0, image1.size.width,image1.size.height);
        
        UIImage *image2 = [UIImage imageNamed:@"4.3;2"];
        UIImageView *imageV2 = [[UIImageView alloc] initWithImage:image2];
        imageV2.frame = CGRectMake(0, 0, image2.size.width,image2.size.height);
        
        
         UIImage *image3 = [UIImage imageNamed:@"4.3;3"];
        UIImageView *imageV3 = [[UIImageView alloc] initWithImage:image3];
        imageV3.frame = CGRectMake(0, 0, image3.size.width, image3.size.height);
        
        UIImage *image4 = [UIImage imageNamed:@"4.3;4"];
        UIImageView *imageV4 = [[UIImageView alloc] initWithImage:image4];
        imageV4.frame = CGRectMake(0, 0, image4.size.width, image4.size.height);

       UIImage *image5 = [UIImage imageNamed:@"5"];
                UIImageView *imageV5 = [[UIImageView alloc] initWithImage:image5];
        imageV5.frame = CGRectMake(0, 0, image5.size.width, image5.size.height);
        
        
                UIImage *image6 = [UIImage imageNamed:@"4.3;6"];
                UIImageView *imageV6 = [[UIImageView alloc] initWithImage:image6];
        imageV6.frame = CGRectMake(0, 0, image6.size.width, image6.size.height);
        

        
        
        
        
        
        
        
        
        
        
        //        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 4, 3)];
        //        [self.view addSubview:self.imageView];
        
        //将图片添加到数组，在给cell赋值是调用
        [muArr addObject:imageV1];
        [muArr addObject:imageV2];
        [muArr addObject:imageV3];
        [muArr addObject:imageV4];
        [muArr addObject:imageV5];
        [muArr addObject:imageV6];
        
        _imageArray = muArr;
    }
    return _imageArray;
}


+ (instancetype)shareWriteDiaryVC
{
    static WriteDiaryViewController *diary = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        diary = [[UIStoryboard storyboardWithName:@"NIU" bundle:nil] instantiateViewControllerWithIdentifier:@"WriteDiaryView"];
    });
    return diary;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"迹忆模板";
    
    
    //初始化collertionView
    WaterFallFlowLayout *flowLayout = [[WaterFallFlowLayout alloc] init];
    self.collecttionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout]; //64是因为有navigation的高度
    
    
    self.collecttionView.bounces=  NO;
    //设置self.collecttionView的背景色
    self.collecttionView.backgroundColor = [UIColor magentaColor];
    
    
    [self.view addSubview:self.collecttionView];
    
    
    //设置代理并且遵循代理协议
    self.collecttionView.delegate = self;
    self.collecttionView.dataSource = self;
    
    //注册cell
    [self.collecttionView registerClass:[WaterFallUICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(BackAction:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的心情" style:UIBarButtonItemStylePlain target:self action:@selector(myMood:)];
    
    

    
   

  
    
}

- (void)BackAction:(UIBarButtonItem *)sender
{
   [self.navigationController popToRootViewControllerAnimated:YES];    
}


- (void)myMood:(UIBarButtonItem *)mood
{
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    
    if(app.m_opened){

        if([[NSUserDefaults standardUserDefaults] objectForKey:@"404MI911MA404"]==nil){
            NSLog(@"第一次启动");
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"输入密码" message:@"第一次启动哦,输入个密码吧,千万不要忘记密码呦!" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"输入完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                LookDiaryTableViewController *lookVC = [LookDiaryTableViewController new];
                
                [self.navigationController pushViewController:lookVC animated:YES];
            }];
            
            okAction.enabled = NO;
            
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我在想想" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.secureTextEntry = YES;
                textField.placeholder = @"请输入密码";
                
                
            }];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.secureTextEntry = YES;
                textField.placeholder = @"请确认密码";
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            
            
            [self presentViewController:alertController animated:YES completion:^{
                
            }];
            
        }else
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"输入密码" message:@"输入密码,才能进入哦" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"输入完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                
                NSString *Str = [[NSUserDefaults standardUserDefaults] objectForKey:@"404MI911MA404"];
                
                if ([alertController.textFields.firstObject.text isEqualToString:Str]) {
                    LookDiaryTableViewController *lookVC = [LookDiaryTableViewController new];
                    
                    [self.navigationController pushViewController:lookVC animated:YES];
                    
                }else
                {
                    
                    
                    [self timeAction404:nil];
                }
                
            }];
            
            
            
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我在想想" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.placeholder = @"请输入密码";
                textField.secureTextEntry = YES;
                
                
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            
            
            [self presentViewController:alertController animated:YES completion:^{
                
            }];

            
        }

    }else {
        
        NSLog(@"第一次启动");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"输入密码" message:@"第一次启动哦,输入个密码吧" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"输入完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            LookDiaryTableViewController *lookVC = [LookDiaryTableViewController new];
            
            [self.navigationController pushViewController:lookVC animated:YES];
        }];
        
        okAction.enabled = NO;
      
        
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我在想想" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.secureTextEntry = YES;
            textField.placeholder = @"请输入密码";
           
        
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.secureTextEntry = YES;
             textField.placeholder = @"请确认密码";
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];

}

}

//- (void)alertTextFieldshure:(NSNotification *)notification
//{
//    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
//      UIAlertAction *okAction = alertController.actions.lastObject;
//    NSString *Str = [[NSUserDefaults standardUserDefaults] objectForKey:@"404MI911MA404"];
//    
//    if ([alertController.textFields.firstObject.text isEqualToString:Str]) {
//        
//      
////        okAction.enabled = YES;
//    }else
//    {
//        
////        okAction.enabled = NO;
//    }
//    
//}


- (void)timeAction404:(NSTimer *)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"进入失败" message:@"你的密码不对哦!" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        });
        
    });
    
    
}













- (void)alertTextFieldDidChange:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
   
    
    if (![alertController.textFields.lastObject.text isEqualToString:@""] && [alertController.textFields.lastObject.text isEqualToString:alertController.textFields.firstObject.text]) {
        
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"404MI911MA404"]==nil){
            
            [[NSUserDefaults standardUserDefaults] setObject:alertController.textFields.lastObject.text forKey:@"404MI911MA404"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = YES;
        
    }else
    {
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = NO;
    }
}








//设置cell的数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}


//cell的内容
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterFallUICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    cell.viewColorful = self.imageArray[indexPath.row];
    cell.viewColorful.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    //cell.backgroundColor = [UIColor redColor];
    
    return cell;
    
}


//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    localImageCtrl = [LLLocalImageViewController new];
    
    localImageCtrl.count = indexPath.item +1;
    
    [self.navigationController pushViewController:localImageCtrl animated:YES];
}


#pragma mark - 计算图片高度
-(float)imageHeight:(float)height width:(float)width{
    /*
     高度/宽度 = 压缩后高度/压缩后宽度
     */
    float newHeight = height/width*(WIDTH);
    return newHeight;
    
}

#pragma mark - cell大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取没个imag新的高度和固定的Size
    UIImageView *view = [self.imageArray objectAtIndex:indexPath.row];
    float height = [self imageHeight:view.frame.size.height width:view.frame.size.width];
    return CGSizeMake(WIDTH, height);
}

#pragma mark - 边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets edgeInsets = {5,5,5,5};
   
    return edgeInsets;
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
