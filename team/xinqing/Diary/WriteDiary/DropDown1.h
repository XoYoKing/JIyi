//
//  DropDown1.h
//  DropDown
//
//  Created by clyd on 13-9-24.
//  Copyright (c) 2013年 clyd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "labelUse.h"

@protocol DropDownDelegate <NSObject>
//获取字体
- (void)getLabelText:(NSString *)text;
@end

@interface DropDown1 : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* tv;//下拉列表
    NSArray* tableArray;//下拉列表数据
//    UITextField* textField;//文本输入框
//    UILabel *textField;
    labelUse *label;
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table下拉列表的高度
    CGFloat frameHeight;//frame的高度
}
@property(nonatomic,strong) UITableView* tv;
@property(nonatomic,strong) NSArray* tableArray;
//@property(nonatomic,strong) UITextField* textField;
@property(nonatomic,strong) labelUse *label;


@property(nonatomic,assign)id <DropDownDelegate> delegate;

@end
