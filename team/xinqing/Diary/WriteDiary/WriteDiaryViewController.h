//
//  WriteDiaryViewController.h
//  team
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLLocalImageViewController.h"
@interface WriteDiaryViewController : UIViewController<LLLocalImageViewControllerDelegate>

{
    LLLocalImageViewController *localImageCtrl;
}


+ (instancetype)shareWriteDiaryVC;
@end
