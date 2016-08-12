//
//  LookDiaryTableViewController.m
//  team
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "LookDiaryTableViewController.h"
#import "UIView_extra.h"
#import "LookCell.h"
#import "LookCell2.h"
#import "LookCell3.h"
#import "LookCell4.h"
#import "LookCell5.h"
#import "LookCell6.h"
@interface LookDiaryTableViewController ()
@property (nonatomic,strong)NSMutableDictionary *allDic;
@property (nonatomic,strong)NSMutableArray *ArrayHead;
@property (nonatomic,strong)NSIndexPath *currentPath5;
@property (nonatomic,strong)NSIndexPath *currentPath6;
@end

@implementation LookDiaryTableViewController


static NSString *const cellID = @"LookCell";
static NSString *const cellID2 = @"LookCell2";
static NSString *const cellID3 = @"LookCell3";
static NSString *const cellID4 = @"LookCell4";
static NSString *const cellID5 = @"LookCell5";
static NSString *const cellID6 = @"LookCell6";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LookCell" bundle:nil] forCellReuseIdentifier:cellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LookCell2" bundle:nil] forCellReuseIdentifier:cellID2];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LookCell3" bundle:nil] forCellReuseIdentifier:cellID3];
    [self.tableView registerNib:[UINib nibWithNibName:@"LookCell4" bundle:nil] forCellReuseIdentifier:cellID4];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LookCell5" bundle:nil] forCellReuseIdentifier:cellID5];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LookCell6" bundle:nil] forCellReuseIdentifier:cellID6];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(Editer:)];
     
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beijingshuiyin"]];
    
    self.tableView.bounces = NO;
    self.title = @"查看我的日记";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.m_opened = YES;
    
    [self loadData];
}



- (void)loadData
{
    [[DBManager showDBManager] openDBManager];
    
    NSArray *allArray = [[DBManager showDBManager] selectAll];
    NSMutableArray *array = [NSMutableArray arrayWithArray:allArray];
    
    //对数组进行倒序排列

    array = (NSMutableArray *)[[array reverseObjectEnumerator] allObjects];
    //用模型取出数组元素
    for (Diary *diary in array) {
        
        //用字符串接收key

        NSArray *arrayTime = [diary.time componentsSeparatedByString:@"-"];
        
        NSString *strYear = arrayTime[0];
        NSString *strMonth = arrayTime[1];
        
        NSString *strTime = [strYear stringByAppendingFormat:@"-%@",strMonth];
        
        NSLog(@"%@",diary.index);
        NSLog(@"%@",diary.name);
        NSLog(@"%@",diary.textContact);
//         NSArray *strDayByTime = [arrayTime[2] componentsSeparatedByString:@"&"];
//        NSString *strText = strDayByTime[1];
//        NSArray *arrayTIME = [strText componentsSeparatedByString:@":"];
//        
//        NSString *Miao = arrayTIME[2];

        // 获取字典所有的key
        NSArray *array1 = [self.allDic allKeys];
        //判断数组是否包含这个key
//        ![array1 containsObject:strTime
        if (![array1 containsObject:strTime]) {
            //创建一个接收模型的数组
            NSMutableArray *arrayForDiaryWithTime = [NSMutableArray new];
            //添加元素
            [arrayForDiaryWithTime addObject:diary];
            //添加到字典
            [self.allDic setObject:arrayForDiaryWithTime forKey:strTime];
            //当字典中有对应的key的时候
        }else{
            //直接添加元素到字典
            [self.allDic[strTime] addObject:diary];
        }
    }
    
    [[DBManager showDBManager] closeDBmanager];
    
    
    //设置值实现点击头标题收揽row
    
    
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];

    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSArray * tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:path error:nil]];
    
    NSString *str = [NSString stringWithFormat:@"%%Array#&*(#Head%%"];
    
    if ([tempFileList containsObject:str]) {
          path = [path stringByAppendingFormat:@"/%%Array#&*(#Head%%"];

        NSData *data = [NSData dataWithContentsOfFile:path];
        
        NSKeyedUnarchiver *Keyed = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSArray *array = [Keyed decodeObject];
        [Keyed finishDecoding];
        
        self.ArrayHead = [NSMutableArray arrayWithArray:array];
        if (array.count <self.allDic.count) {
            
            for (int i = 0;  i < self.allDic.count - array.count; i ++) {
                [self.ArrayHead addObject:@"0"];
                
            }
        }

        
    }else
    {
        for (int i = 0; i < self.allDic.count; i ++) {
            
            [self.ArrayHead addObject:@"0"];
            
        }
        
    }

}

- (void)backAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    NSMutableData *data = [NSMutableData new];
    NSKeyedArchiver *key = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [key encodeObject:self.ArrayHead];
    [key finishEncoding];
    
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingFormat:@"/%%Array#&*(#Head%%"];
    [data writeToFile:path atomically:YES];
}


- (NSMutableArray *)ArrayHead
{
    if (!_ArrayHead) {
        
        self.ArrayHead = [NSMutableArray array];
        
    }
    return _ArrayHead;
}




//Lazzy
- (NSMutableDictionary *)allDic
{
    if (!_allDic) {
        
        self.allDic = [NSMutableDictionary dictionary];
        
    }
    return _allDic;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return  self.allDic.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([[self.ArrayHead objectAtIndex:section] intValue]== 0) {
//        return [self.allDic[self.allDic.allKeys[section]] count];
        NSString *key = self.allDic.allKeys[section];
        NSArray *array = self.allDic[key];
        return array.count;

    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

            //取消选中效果
        //        cell.selectionStyle = (const int)UITableViewSelectionDidChangeNotification;
        //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        //取消table的线条
    
    
    Diary *diary = self.allDic[self.allDic.allKeys[indexPath.section]][indexPath.row];
    
    NSArray *arrayTime = [diary.time componentsSeparatedByString:@"-"];
    
  
    
    NSArray *strDayByTime = [arrayTime[2] componentsSeparatedByString:@"&"];
  
    NSString *stringTime = [strDayByTime[0] stringByAppendingFormat:@"日%@",strDayByTime[1]];

#pragma mark 从本地读取文件为cell附图片
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    path = [path stringByAppendingPathComponent:diary.name];

    path = [path stringByAppendingFormat:@"/%@",diary.name];
    NSLog(@"%@",path);
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSKeyedUnarchiver *kedUN = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    NSArray *array = [kedUN decodeObject];
    [kedUN finishDecoding];
    
    if (array.count == 1) {
        LookCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        
              cell.labelName.text = diary.name;
        
       
        
        //    NSString *strYear = arrayTime[0];
        //    NSString *strMonth = arrayTime[1];
        //
        //    NSString *strTime = [strYear stringByAppendingFormat:@"-%@",strMonth];
        cell.labelTime.text = stringTime;

        
        UIImage *image = array[0];
        [cell.imgView setImage:image];
        cell.imgView.layer.cornerRadius = (Width -10)/ 8;
        cell.imgView.layer.masksToBounds = YES;
       return cell;
        
    }else if(array.count == 2)
    {
        LookCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellID2 forIndexPath:indexPath];
        cell.labelName.text = diary.name;
        cell.labelTime.text = stringTime;
        cell.imgView1.image = array[0];
        cell.imgView2.image = array[1];
        cell.imgView1.layer.cornerRadius = (Width -10)/ 8;
        cell.imgView1.layer.masksToBounds = YES;
        cell.imgView2.layer.cornerRadius = (Width -10)/ 10;
        cell.imgView2.layer.masksToBounds = YES;
        
        return cell;
    }else if(array.count == 3)
    {
        LookCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellID3 forIndexPath:indexPath];
        cell.labelName.text = diary.name;
        cell.labelTime.text= stringTime;
        cell.imgView1.image = array[0];
        cell.imgView2.image = array[1];
        cell.imgView3.image = array[2];
        cell.imgView1.layer.cornerRadius = (Width -10)/ 8;
        cell.imgView1.layer.masksToBounds = YES;
        cell.imgView2.layer.cornerRadius = (Width -10)/ 10;
        cell.imgView2.layer.masksToBounds = YES;
        cell.imgView3.layer.cornerRadius = (Width - 10) * 0.075;
        cell.imgView3.layer.masksToBounds = YES;
        return cell;
        
        
    }else if (array.count == 4)
    {
        LookCell4 *cell = [tableView dequeueReusableCellWithIdentifier:cellID4 forIndexPath:indexPath];
        cell.labelName.text = diary.name;
        cell.labelTime.text= stringTime;
        cell.imgView1.image = array[0];
        cell.imgView2.image = array[1];
        cell.imgView3.image = array[2];
        cell.imgView4.image = array[3];
        
        cell.imgView1.layer.cornerRadius = (Width -10)/ 10;
        cell.imgView1.layer.masksToBounds = YES;
        cell.imgView2.layer.cornerRadius = (Width -10)/ 20;
        cell.imgView2.layer.masksToBounds = YES;
        cell.imgView3.layer.cornerRadius = (Width - 10) * 0.025;
        cell.imgView3.layer.masksToBounds = YES;
        cell.imgView4.layer.cornerRadius = (Width - 10) * 0.075;
        cell.imgView4.layer.masksToBounds = YES;

        
        return cell;
        
    }else if (array.count == 5)
    {
        LookCell5 *cell = [tableView dequeueReusableCellWithIdentifier:cellID5 forIndexPath:indexPath];
        
        self.currentPath5 = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        
        
        
        cell.tag = 666;
        cell.labelName.text = diary.name;
        cell.labelTime.text= stringTime;
        cell.imgView1.image = array[0];
        cell.imgVIew2.image = array[1];
        cell.imgView3.image = array[2];
        cell.imgView4.image = array[3];
        cell.imgView5.image = array[4];
        
        cell.imgView1.layer.cornerRadius = (Width -10)/ 8;
        cell.imgView1.layer.masksToBounds = YES;
        cell.imgVIew2.layer.cornerRadius = (Width -10)/ 20;
        cell.imgVIew2.layer.masksToBounds = YES;
        cell.imgView3.layer.cornerRadius = (Width - 10) * 0.025;
        cell.imgView3.layer.masksToBounds = YES;
        
        cell.imgView4.layer.cornerRadius = (Width - 10) / 10;
        cell.imgView4.layer.masksToBounds = YES;
        cell.imgView5.layer.cornerRadius = (Width - 10)/ 20;
        cell.imgView5.layer.masksToBounds = YES;
        
        return cell;
    }else
    {
        
        LookCell6 *cell = [tableView dequeueReusableCellWithIdentifier:cellID6 forIndexPath:indexPath];
        
        self.currentPath6 = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        
        cell.tag = 666;
        cell.labelName.text = diary.name;
        cell.labelTime.text= stringTime;
        cell.imgView1.image = array[0];
        cell.imgView2.image = array[1];
        cell.imgView3.image = array[2];
        cell.imgView4.image = array[3];
        cell.imgView5.image = array[4];
        cell.imgView6.image = array[5];
        
        
//        cell.imgView1.layer.cornerRadius = (Width -10)/ 8;
//        cell.imgView1.layer.masksToBounds = YES;
//        cell.imgView2.layer.cornerRadius = (Width -10)/ 20;
//        cell.imgView2.layer.masksToBounds = YES;
//        cell.imgView3.layer.cornerRadius = (Width - 10) * 0.025;
//        cell.imgView3.layer.masksToBounds = YES;
//        
//        cell.imgView4.layer.cornerRadius = (Width - 10) / 10;
//        cell.imgView4.layer.masksToBounds = YES;
//        cell.imgView5.layer.cornerRadius = (Width - 10)/ 20;
//        cell.imgView5.layer.masksToBounds = YES;
        
        
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == self.currentPath5.row && indexPath.section == self.currentPath5.section) {
        
        return ((Width - 10) /  4) + 80;
        
    }else if (indexPath.row == self.currentPath6.row && indexPath.section == self.currentPath6.section)
    {
    
        return ((Width - 10) /  4) + 80;
    }
    else
    {
      return  ((Width - 10) /  4) + 40;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

//设置tableView的头标题以及点击事件
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewMain = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 40)];
    viewMain.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 5,self.tableView.frame.size.width - 10, 30)];
    
    UIButton *btnTgr = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnTgr.size = CGSizeMake(view.frame.size.width, view.frame.size.height);
    [btnTgr setTitle:self.allDic.allKeys[section] forState:UIControlStateNormal];
    [btnTgr setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnTgr.tag = 100 + section;
    [btnTgr addTarget:self action:@selector(btnTgrAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnTgr];
    UIColor *color = [UIColor colorWithRed:248.0/255.0 green:176.0/255.0 blue:89.0/255.0 alpha:1];
    
    view.backgroundColor = color;
    
    
    [viewMain addSubview:view];
    return viewMain;
}
//以及点击事件
- (void)btnTgrAction:(UIButton *)btnTgr
{
    
    if ([[self.ArrayHead objectAtIndex:btnTgr.tag - 100] intValue]== 0 ) {
        
        [self.ArrayHead replaceObjectAtIndex:btnTgr.tag - 100 withObject:@"1"];
        [self.tableView reloadData];
    }else
    {
        [self.ArrayHead replaceObjectAtIndex:btnTgr.tag - 100 withObject:@"0"];
        [self.tableView reloadData];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LookDiaryViewController *lookVC = [LookDiaryViewController new];
    
    Diary *diary = self.allDic[self.allDic.allKeys[indexPath.section]][indexPath.row];
    
    lookVC.index = diary.index;
    NSLog(@"%@",diary.index);
    NSLog(@"%@",diary.name);
    lookVC.name = diary.name;
    
    //    [self showViewController:lookVC sender:nil];
    
    [self.navigationController showViewController:lookVC sender:nil];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//编辑按钮
- (void)Editer:(UIBarButtonItem *)sender
{
    if (self.tableView.editing == YES) {
        
        sender.title = @"编辑";
        
    }
    else
    {
        sender.title = @"完成";
        
    }
    
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//3设置
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
       
        NSMutableArray *array = self.allDic[self.allDic.allKeys[indexPath.section]];
        
        
        //删除数据库
        Diary *diary = array[indexPath.row];
        [[DBManager showDBManager] openDBManager];
        [[DBManager showDBManager] deletefromTitle:diary.name];
        [[DBManager showDBManager] closeDBmanager];
        
       //        删除本地数据库数据
        
            //获取本地所有文件名称数组
         NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        path = [path stringByAppendingFormat:@"/%@",diary.name];
        NSFileManager * fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:path error:nil];
        
//        NSArray * tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:path error:nil]];
        
        // //删除页面数据
        [array removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
