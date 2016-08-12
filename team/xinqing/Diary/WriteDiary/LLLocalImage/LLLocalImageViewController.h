//
//  LLLocalImageViewController.h
//  GetLocalPhoto01
//
//  Created by lyc on 15/3/31.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Block) ();
@protocol LLLocalImageViewControllerDelegate <NSObject>

- (void)getSelectImage:(NSArray *)imageArr;

@end

@interface LLLocalImageViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    IBOutlet UICollectionView *mCollectionView;
    
    IBOutlet UIButton *endBtn;
    IBOutlet UIImageView *countImageView;
    IBOutlet UILabel *countLabel;
    
    __weak IBOutlet UILabel *countPic;
}
//判断传过来的是那一个,再根据者个参数选图片
@property(nonatomic,assign)NSInteger count;
@property (assign, nonatomic)id<LLLocalImageViewControllerDelegate> delegate;
@property(nonatomic,copy)Block block;
@end
