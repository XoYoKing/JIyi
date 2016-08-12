//
//  LLLocalImageViewController.m
//  GetLocalPhoto01
//
//  Created by lyc on 15/3/31.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "LLLocalImageViewController.h"
#import "LLLocalImageCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ModelViewController.h"

#define CELL_NAME @"LLLocalImageCollectionViewCell"

@interface LLLocalImageViewController ()
{
    NSMutableArray *photoImages;
    NSMutableArray *photpImagesGaoqing;
}
@property (nonatomic,strong)NSMutableArray *arrayImageSelect;


@end

@implementation LLLocalImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置完成按钮最开始为不可用的
    endBtn.enabled = NO;
    endBtn.backgroundColor = [UIColor clearColor];
    endBtn.layer.cornerRadius = 5;
    countImageView.hidden = YES;
    countLabel.hidden = YES;
    //显示用户点击了多少图片
    countPic.text = [NSString stringWithFormat:@"%ld",self.count];
    
//    AssetsLibrary 的组成比较符合照片库本身的组成，照片库中的完整照片库对象、相册、相片都能在 AssetsLibrary 中找到一一对应的组成，这使到 AssetsLibrary 的使用变得直观而方便。
    
    
//    AssetsLibrary: 代表整个设备中的资源库（照片库），通过 AssetsLibrary 可以获取和包括设备中的照片和视频
    ALAssetsLibrary *_assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    photoImages = [[NSMutableArray alloc] init];
    photpImagesGaoqing = [[NSMutableArray alloc] init];
    
    ///ALAssetsGroupLibrary
//    ALAssetsGroup: 映射照片库中的一个相册，通过 ALAssetsGroup 可以获取某个相册的信息，相册下的资源，同时也可以对某个相册添加资源。
    [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos|ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
//        ALAsset: 映射照片库中的一个照片或视频，通过 ALAsset 可以获取某个照片或视频的详细信息，或者保存照片和视频。
       
        
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if(result){
                UIImage *img = [UIImage imageWithCGImage:result.thumbnail];
                UIImage *img2 = [UIImage imageWithCGImage:result.aspectRatioThumbnail];
                if(img)
                {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    [dic setObject:img forKey:@"img"];
                    //为图片设置标志方便点用户在点击时容易识别
                    [dic setObject:@"0" forKey:@"flag"];
                    [photoImages addObject:dic];
                }
                if (img2) {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    [dic setObject:img2 forKey:@"img"];

                    [photpImagesGaoqing addObject:dic];
                }
                
                
                
                
                if(index + 1 == group.numberOfAssets)
                {
                    ///最后一个刷新界面
                    [self finish];
                }
            }
        }];
        self.block();
    } failureBlock:^(NSError *error) {
        // error
        NSLog(@"error ==> %@",error.localizedDescription);
    }];
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] init];
    activity.frame = CGRectMake(0, 0, 30, 30);
    activity.center = CGPointMake(Width /2 , (Height - 104 )/ 2);
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;

    [activity startAnimating];
    [mCollectionView addSubview:activity];
    self.block = ^()
    {
        
        NSLog(@"222");
        [activity stopAnimating];
    };
    
}

- (void)finish
{
    mCollectionView.delegate = self;
    mCollectionView.dataSource = self;
}

#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [photoImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //注册单元格
    [collectionView registerNib:[UINib nibWithNibName:CELL_NAME bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CELL_NAME];
    
    LLLocalImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_NAME forIndexPath:indexPath];
    
    //设置每个cell的tag值
    cell.tag = indexPath.item + 100;
    
    //把选择栏和相应的cell对应起来
    cell.selectImageView.tag = indexPath.row;
    
    //如果当前的row比从相册中接收所有图片的数组小得时候 为选择栏设置标志
    if (indexPath.row < [photoImages count])
    {
        id dic = [photoImages objectAtIndex:indexPath.row];
        [cell sendValue:dic];
    }
    return cell;
}

#pragma mark - ---UICollectionViewDelegateFlowLayout
// 设置每个Item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWH = [UIScreen mainScreen].bounds.size.width / 4.0f - 16;
    return CGSizeMake(itemWH, itemWH);
}

// 设置每个图片的Margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LLLocalImageCollectionViewCell *cell = (LLLocalImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //获取自定义相册数组中的单个图片
    id dic = [photoImages objectAtIndex:indexPath.row];
    //判断每个图片是否被选中
    BOOL flag = [[dic objectForKey:@"flag"] boolValue];
    //获取被选中的图片的位置
    NSString *Obj = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    if (!flag)
    {
        
        //判断被选择图片与要求的个数的比较如果小于则设置标志,如果超出范围则把数组中最开始的元素移除再添加新的元素(一切为了用户体验)
        if ([self getSelectImageCount] < self.count) {
            
      
            NSLog(@"###%ld",self.arrayImageSelect.count);
            NSLog(@"***%ld",self.count);
            
            //设置图片选中的标志
              [dic setObject:@"1" forKey:@"flag"];
            
        }else
        {
            
            //获取用于接收的数组中最开始添加的图片的位置然后把他的标志设置为取消状态
            NSString* lastStr = [self.arrayImageSelect objectAtIndex:0];
            
            NSInteger INTEGER = [lastStr integerValue];
            

            id dicOr = [photoImages objectAtIndex:INTEGER];
            [dicOr setObject:@"0" forKey:@"flag"];
            
        //根据tag值获取当前点击的cell到底是哪一个
            LLLocalImageCollectionViewCell *cell1 = (LLLocalImageCollectionViewCell *)[mCollectionView viewWithTag:INTEGER +100];
            
            NSLog(@"%ld",INTEGER);
            
//        然后再把他的标志设置为取消状态
            [cell1 setSelectFlag:NO];
            
//            在把图片设置为选中状态
            [dic setObject:@"1" forKey:@"flag"];
            [self.arrayImageSelect removeObjectAtIndex:0];

        }
        
        //将图片的位置加入数组中
        [self.arrayImageSelect addObject:Obj];
        NSLog(@"ImageSelect图片 %ld",self.arrayImageSelect.count);
        NSLog(@"getSelectImage方法 %ld",[self getSelectImageCount]);
        
    } else {
        //把图片设置为取消选中状态
        [dic setObject:@"0" forKey:@"flag"];
        [self.arrayImageSelect removeObject:Obj];
    }
    
    //设置提示的标志图片
    [cell setSelectFlag:!flag];
    
    NSInteger selectCount = [self getSelectImageCount];
    //如果当前选中的图片与用户要求的个数(传进来的参数)相等的时候则一切可选可编辑可进入下一界面的按钮处于点亮状态,否则呵呵哒接着点吧
    if (selectCount == self.count)
    {
        endBtn.enabled = YES;
        endBtn.backgroundColor = [UIColor colorWithRed:134/255.0f green:208/255.0f blue:0/255.0f alpha:1];
        countImageView.hidden = NO;
        countLabel.hidden = NO;
        countLabel.text = [NSString stringWithFormat:@"%ld", selectCount];
    } else {
        endBtn.enabled = NO;
        endBtn.backgroundColor = [UIColor clearColor];
        countImageView.hidden = YES;
        countLabel.hidden = YES;
    }
}

/**
 *  获取列表中有多少Image被选中
 *
 *  @return 选中个数
 */
- (NSInteger)getSelectImageCount
{
    NSInteger count = 0;
    for (NSInteger i = 0; i < [photoImages count]; i++)
    {
        id dic = [photoImages objectAtIndex:i];
        BOOL flag = [[dic objectForKey:@"flag"] boolValue];
        if (flag)
        {
            count++;
        }
    }
    return count;
}

/**
 *  完成按钮点击
 */
- (IBAction)endBtnClick:(id)sender
{
    NSLog(@"完成按钮点击");
    

        NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    //获取高清图
//    NSString* lastStr = [self.arrayImageSelect objectAtIndex:0];
//    
//    NSInteger INTEGER = [lastStr integerValue];
    
    for (NSString *strInt in self.arrayImageSelect) {
        
        NSInteger inter = [strInt integerValue];
        
        id dicO = [photpImagesGaoqing objectAtIndex:inter];
        [imageArr addObject:[dicO objectForKey:@"img"]];
    }
    
    
//    id dicOr = [photoImages objectAtIndex:INTEGER];
//    [dicOr setObject:@"0" forKey:@"flag"];
    
    //
    
    
    
//        for (NSDictionary *dic in photoImages)
//        {
//            if ([[dic objectForKey:@"flag"] boolValue])
//            {
//                [imageArr addObject:[dic objectForKey:@"img"]];
//            }
//        }

    
    NSInteger index = 0;
    
    if ([imageArr count] == 1) {
        index = 1;
        
    }
    
    if ([imageArr count] > 1)
    {
        index = 2;
        
    }
    if ([imageArr count] > 2)
    {
        index = 3;
    }
    if ([imageArr count] > 3)
    {
        index = 4;
    }
    if ([imageArr count] > 4)
    {
        index = 5;
    }
    if ([imageArr count] > 5)
    {
        index = 6;
    }
    
    //根据indexPath获取cell
    //    WaterFallUICollectionViewCell *cell = (WaterFallUICollectionViewCell *)[self.collecttionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    
    //跳转到编辑界面  并且传入indexPath.row的值
    
    ModelViewController *writeVC = [ModelViewController shareModelVC];
    
    writeVC.indexPath = index;
    NSLog(@"%ld",index);
    
    
    NSMutableData *data = [[NSMutableData alloc] initWithCapacity:20];
    NSKeyedArchiver *key = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [key encodeObject:imageArr];
    [key finishEncoding];
    
    writeVC.data = data;
    writeVC.str = @"1";
    
    NSLog(@"%@",writeVC.str);
    
    [self.navigationController showViewController:writeVC sender:nil];

//    [self showDetailViewController:writeVC sender:nil];
    
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}


/**
 *  获取选中图片的位置懒加载
 */

- (NSMutableArray *)arrayImageSelect
{
    if (!_arrayImageSelect) {
        
        self.arrayImageSelect = [NSMutableArray array];
        
    }
    return _arrayImageSelect;
}






@end
