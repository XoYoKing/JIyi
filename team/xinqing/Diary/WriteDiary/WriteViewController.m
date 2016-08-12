//
//  WriteViewController.m
//  team
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "WriteViewController.h"
#import "ViewImg1.h"
#define FILEPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
@interface WriteViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>

//存放模板的数组
//@property(nonatomic,strong)NSArray *imageArray;

@property (nonatomic,strong)NSMutableDictionary *allDataDic;
@property (nonatomic,strong)ViewImg1 *ViewImg1;
@property (nonatomic,strong)UIImagePickerController *imagePicker;
@property (nonatomic,assign)NSInteger flag;
@property (nonatomic,strong)NSMutableArray *allImgArray;
//是否保存
@property (nonatomic,assign)BOOL isSaving;

//用于接收textView的frame
@property (nonatomic,assign)CGRect frameTextView;

@end

@implementation WriteViewController

//-(NSArray *)imageArray{
//    if (!_imageArray) {
//        NSMutableArray *muArr = [NSMutableArray new];
//        
//        //设置imageView的宽高适应图片宽高
//        UIImage *image1 = [UIImage imageNamed:@"jian.jpg"];
//        
//        UIImageView *imageV1 = [[UIImageView alloc] initWithImage:image1];
//        imageV1.frame = CGRectMake(0, 69, Width,image1.size.height * (Width/image1.size.width));
//        
//        //        imageV1.frame = Bounds;
//        
//        
//        UIImage *image2 = [UIImage imageNamed:@"tui1"];
//        UIImageView *imageV2 = [[UIImageView alloc] initWithImage:image2];
//        //        imageV2.frame = CGRectMake(0, 0, image2.size.width,image2.size.height);
//        imageV2.frame = CGRectMake(0, 69, Width,image2.size.height * (Width/image1.size.width));
//        
//        
//        //        imageV2.frame = Bounds;
//        
//        
//        UIImage *image3 = [UIImage imageNamed:@"t3"];
//        UIImageView *imageV3 = [[UIImageView alloc] initWithImage:image3];
//        //        imageV3.frame = CGRectMake(0, 0, image3.size.width, image3.size.height);
//        imageV3.frame = CGRectMake(0, 69, Width, image3.size.height * (Width/image1.size.width));
//        
//        //        imageV3.frame = Bounds;
//        
//        
//        
//        UIImage *image4 = [UIImage imageNamed:@"tu3"];
//        UIImageView *imageV4 = [[UIImageView alloc] initWithImage:image4];
//        //        imageV4.frame = CGRectMake(0, 0, image4.size.width, image4.size.height);
//        imageV4.frame = CGRectMake(0, 69, Width, image4.size.height * (Width/image1.size.width));
//        
//        //        imageV4.frame = Bounds;
//        
//        
//        //将图片添加到数组，在给cell赋值是调用
//        [muArr addObject:imageV1];
//        [muArr addObject:imageV2];
//        [muArr addObject:imageV3];
//        [muArr addObject:imageV4];
//        
//        _imageArray = muArr;
//    }
//    return _imageArray;
//}
//

- (void)loadView
{
    if (self.indexPath == 0) {
    
        self.ViewImg1 = [[ViewImg1 alloc] initWithFrame:Bounds];
        self.view = self.ViewImg1;
        
        self.ViewImg1.backgroundColor = [UIColor whiteColor];
     
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.indexPath == 0) {
        //对模型1的控制
        [self loadViewImg1];
        
          self.frameTextView = self.ViewImg1.textView.frame;
        
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgrAction:)];

        tgr.numberOfTapsRequired = 2;
        
        
        [self.view addGestureRecognizer:tgr];
        
    }
 
}

//轻怕手势
- (void)tgrAction:(UIGestureRecognizer *)sender
{
     [self.ViewImg1.textView resignFirstResponder];
 
}


//textViewDelegate
//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    

//    //为了避免输入的时候看不到字,让textView上移
//    CGRect frame = textView.frame;
//    //键盘高度216;
//    
//    //text文字的高度
//    CGFloat height = [self getTextViewTextHeight:nil];
//    
//    
//    if ([UIScreen mainScreen].bounds.size.height - ((self.ViewImg1.textView.frame.origin.y + textView.frame.size.height)) <= 216) {
//        
        CGFloat offset = (Height - ((self.ViewImg1.textView.frame.origin.y + textView.frame.size.height + 64))) - 216;
//        UIImage *image = [UIImage imageNamed:@"jian.jpg"];
        //将试图的Y坐标向上移动offset个单位,以便下面腾出地方用于软键盘的显示
//        self.ViewImg1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//        self.ViewImg1.scrollViewMain.frame = CGRectMake(0, 0, Width, height + offset);
        
       
        CGPoint point = CGPointMake(0,  -offset);

        [self.ViewImg1.scrollViewMain setContentOffset:point animated:YES];

        
//        self.ViewImg1.imageViewMain.frame = CGRectMake(0, offset, Width, Height);
        
//         self.ViewImg1.frame = CGRectMake(0, 0, Width, Height);
        
//        if (point.y > 0) {
//            
//            CGPoint point1 = CGPointMake(0,  offset);
//            
//            [self.ViewImg1.scrollViewMain setContentOffset:point1 animated:YES];
//            
//        }
//
        
        
        
//    }
    
    if ([self.ViewImg1.textView.text isEqualToString:@"人一生有起有落，起的时候不忘落的时候，落的时候想想起的时候，哪里跌倒，哪里站起。\n相信有自信的生命与没自信的生命会有不一样的天地"]) {
        
        self.ViewImg1.textView.text = @"";
         self.ViewImg1.textView.textColor = [UIColor blackColor];
        self.ViewImg1.textView.backgroundColor = [UIColor whiteColor];
        self.ViewImg1.textView.textAlignment = NSTextAlignmentLeft;
       
        
    }
}


//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView
{
//    self.ViewImg1.frame = self.frameTextView;
    
    if (textView.text) {
        
        textView.textColor = [UIColor grayColor];
        textView.backgroundColor = [UIColor whiteColor];
        [textView resignFirstResponder];
        
    }
}

//对模型1的控制
- (void)loadViewImg1
{
    //UIControl 的相应事件
    [self.ViewImg1.control1 addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
    [self.ViewImg1.control2 addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
    [self.ViewImg1.control3 addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
    [self.ViewImg1.control4 addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
    [self.ViewImg1.control5 addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
    [self.ViewImg1.control6 addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
    
    //imageView1 的响应事件
    [self.ViewImg1.imagView1 addTarget:self action:@selector(changeImageHiddenAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.ViewImg1.imagView2 addTarget:self action:@selector(changeImageHiddenAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.ViewImg1.imagView3 addTarget:self action:@selector(changeImageHiddenAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.ViewImg1.imagView4 addTarget:self action:@selector(changeImageHiddenAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.ViewImg1.imagView5 addTarget:self action:@selector(changeImageHiddenAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.ViewImg1.imagView6 addTarget:self action:@selector(changeImageHiddenAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //对textView的控制
    self.ViewImg1.textView.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    
}

//保存相册
- (void)saveAction:(UINavigationBar *)sender
{
    NSInteger count = 0;
    [self.ViewImg1.textView resignFirstResponder];
    [self.ViewImg1.labelName resignFirstResponder];
    
    
    
    if (![self.allImgArray containsObject:@"1"]&& ![self.ViewImg1.labelName.text isEqualToString:@""]) {
        
        count ++;
       
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"YYYY-MM-dd"];
        
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        
        self.ViewImg1.labelTime.text = locationString;
        
               //把信息存到模型里面
        Diary *diary = [Diary new];
        diary.name = self.ViewImg1.labelName.text;
        diary.textContact  = self.ViewImg1.textView.text;
        diary.time = self.ViewImg1.labelTime.text;
        diary.index = [NSString stringWithFormat:@"%ld",self.indexPath];
         [[DBManager showDBManager] openDBManager];
       NSArray *array = [[DBManager showDBManager] selectTitle:diary.name];
        [[DBManager showDBManager] closeDBmanager];
        
        if (array.count != 0) {
            
         //标题重名了你分不清
            [self save:count];
            return;
        }
        
        [self save:100];
        [self saveData];
        
        
    }else
    {
        
        if ([self.ViewImg1.labelName.text isEqualToString:@""] && [self.allImgArray containsObject:@"1"]) {
            count = count + 3;
            
            [self save:count];
            return;
        }
        
        if ([self.allImgArray containsObject:@"1"]) {
            
            
            [self save:count];
        }
        
        if ([self.ViewImg1.labelName.text isEqualToString:@""] ) {
            
            count --;
            
            
            [self save:count];
            
        }
 
    }
}

- (void)saveData
{
    
    Diary *diary = [Diary new];
    diary.name = self.ViewImg1.labelName.text;
    diary.textContact  = self.ViewImg1.textView.text;
    diary.time = self.ViewImg1.labelTime.text;
    diary.index = [NSString stringWithFormat:@"%ld",self.indexPath];
    

    
    //存到数据库
    
    [[DBManager showDBManager] openDBManager];
    [[DBManager showDBManager] createTable];
    
    [[DBManager showDBManager] deletefromTitle:diary.name];
    [[DBManager showDBManager] insertDiary:diary];
    
    [[DBManager showDBManager] closeDBmanager];
    //图片存储到本地
//    [[ContactData shareWithContactData] contactArchiverWithArray:self.allImgArray Diary:diary];
//    [[dataImageManager  sharedataImageManager] loadDataImageData:diary imageArray:self.allImgArray];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:diary.name]==nil){

        [[NSUserDefaults standardUserDefaults] setObject:self.allImgArray forKey:diary.name];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    
    
    
//    NSMutableArray *array1 = [[ContactData shareWithContactData] contactWithDecodeDiary:diary];
//    
//    NSData *data = array1[5];
//    UIImage *img = [UIImage imageWithData:data];
//    
//    self.ViewImg1.imagView1.image = img;

}


//选择跳转相册还是访问相机
- (void)addPic:(UIControl *)sender
{
    [self.ViewImg1.textView resignFirstResponder];
    [self.ViewImg1.labelName resignFirstResponder];
    
    sender.hidden = YES;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Please" message:@"选择图片来源" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
      //    访问相册
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"访问相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        sender.hidden = YES;
        
        //    访问相册
//        UIImagePickerController *pic = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:self.imagePicker animated:YES completion:^{
            
            
            self.flag = sender.tag;
        }];
        
    }];
    
    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"访问相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceRear];
        if(!isCamera) {
            
            [self save:404];
            
            return;
        }
//        UIImagePickerController *pic = [[UIImagePickerController alloc] init];
        // 摄像头
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 允许编辑
        self.imagePicker.allowsEditing = YES;
        
        [self presentViewController: self.imagePicker animated: YES completion:^{
            self.flag = sender.tag;
        }];
    }];
    
    UIAlertAction *alertAction3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:alertAction1];
    [alertController addAction:alertAction2];
    [alertController addAction:alertAction3];
    [self presentViewController:alertController animated:YES completion:^{
        
        
    }];
}

#pragma mark 对模型1 的控制
- (void)changeImageHiddenAction:(UIImageView *)sender
{
    
    UILabel *label = (UILabel *)[self.ViewImg1 viewWithTag:sender.tag - 90];
    
    [label setText:@"更换图片"];
    
//    UIControl *control = (UIControl *)[self.ViewImg1 viewWithTag:(sender.tag - 100)];
//    control.hidden = NO;
}

#pragma mark 懒加载imagePicker
- (UIImagePickerController *)imagePicker
{
    if(!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    
    return _imagePicker;
}

- (NSMutableArray *)allImgArray
{
    if (!_allImgArray) {
        
        self.allImgArray = [[NSMutableArray alloc] initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1", nil];
        
    }
    return _allImgArray;
}



//相册回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImageView *viewImg = [[UIImageView alloc]init];
    
        viewImg.image = info[UIImagePickerControllerOriginalImage];
        
        NSData *DataImage = UIImageJPEGRepresentation(viewImg.image, 1);

    NSInteger index = self.flag - 1;
        [self.allImgArray replaceObjectAtIndex:index withObject:DataImage];
    
    NSData *data = self.allImgArray[index];
    UIImage *image = [UIImage imageWithData:data];
    
    //根据tag值获取imageView
    UIImageView *imageView = (UIImageView *)[self.ViewImg1 viewWithTag:self.flag + 100];
    imageView.image = image;
    
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}



- (void)save:(NSInteger)sender
{
    
    
    
    if (sender == 1) {
        //保存失败因为重名了
        [self timeAction1:nil];
        
    }else if (sender == -1)
    {
        //保存失败
        [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timeAction0:) userInfo:nil repeats:NO];
    }else if (sender == 3)
    {
        
        //保存失败
        [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timeAction3:) userInfo:nil repeats:NO];

    }else if (sender == 404)
    {
        //相机访问失败
        [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timeAction404:) userInfo:nil repeats:NO];
        
    }else if (sender == 100)
    {
        //保存成功
          [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timeAction100:) userInfo:nil repeats:NO];
        
        
    }
    else
    {
        //保存失败
        [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timeAction:) userInfo:nil repeats:NO];
        
    }
    
    
    
}

//保存失败
- (void)timeAction:(NSTimer *)sender
{
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存失败" message:@"有空位置哦?" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
             [self dismissViewControllerAnimated:YES completion:nil];
            
        });
        
    });
}

- (void)timeAction0:(NSTimer *)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存失败" message:@"被有标题的心情不可以理解哦!" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        });
        
    });
    
    
}


//标题没有
- (void)timeAction3:(NSTimer *)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存失败" message:@"标题木有,图片也木有的心情不是好心情呢!" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        });
        
    });

    
}



//文件重名替换
- (void)timeAction1:(NSTimer *)sender
{
  
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"你有一个名字与之相同的文件,确认替换吗?" preferredStyle:UIAlertControllerStyleAlert];
        
    
        UIAlertAction *Action1 = [UIAlertAction actionWithTitle:@"确定保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self saveData];
            
        }];
        
        UIAlertAction *Action2 = [UIAlertAction actionWithTitle:@"取消保存" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
    
         [alertController addAction:Action1];
         [alertController addAction:Action2];
    
        [self presentViewController:alertController animated:YES completion:^{
            
        }];

}


//摄像头问题
- (void)timeAction404:(NSTimer *)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"访问失败" message:@"你的摄像头出问题了!" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        });
        
    });

    
}
//保存成功



- (void)timeAction100:(NSTimer *)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存成功" message:@"保存成功了呢!快去""我的心情""里查看吧!" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        });
        
    });

    
}




- (NSMutableDictionary *)allDataDic
{
    if (!_allDataDic) {
        
        self.allDataDic = [NSMutableDictionary dictionary];
        
    }
    return _allDataDic;
}




@end
