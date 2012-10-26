//
//  VIPSalarySearchViewController.m
//  SalarySearch
//
//  Created by david on 12-10-20.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import "VIPSalarySearchViewController.h"

#import "CustomcellForSalary.h"
#import "DealWithNetWorkAndXmlHelper.h"
#import "SaveDataSingleton.h"
#import "VIPSelectedTableviewController.h"
#import "VIPSalaryCompareVontroller.h"
@implementation VIPSalarySearchViewController
@synthesize scrollview;
@synthesize tableview;
@synthesize tmpSaveArray;
@synthesize itemAllkeys;
@synthesize prepareItemsForNetWork;
@synthesize prepareItemsWithNameForSalarySearch;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark textfield 代理
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [prepareItemsForNetWork setObject:textField.text forKey:[itemAllkeys objectAtIndex:7]];
    [textField resignFirstResponder];
    
    return  YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    
    NSLog(@"开始编辑进行的操作");
    return YES;
}


- (BOOL) textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSLog(@"结束编辑");
    return YES;
}


- (void) getSalaryFromNetWork{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);

    //从网络获取 薪酬数据
    tmpSaveSalaryInfo = [[DealWithNetWorkAndXmlHelper getSalaryInfoFromNetWork:prepareItemsForNetWork] retain];
    
NSLog(@"指示图中得到的数据count为：%d",[tmpSaveSalaryInfo count]);
    
}
#pragma mark -
#pragma mark 点击查询按钮，与服务器交互
//点击
-(void) bnClicked:(UIButton *) bn{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    


    //活动指示图

    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.dimBackground = YES;
    HUD.labelText = @"正在查询,请您稍等";
    
    
    //
    [HUD showWhileExecuting:@selector(getSalaryFromNetWork) onTarget:self withObject:nil animated:YES];
    
    NSLog(@"待传递的参数为 count = %d", [prepareItemsForNetWork count]);
        
    NSLog(@"保存按钮");
}


- (void) showAlerInfoWhenErrorHappen:(NSString *) error{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"温馨提示" message:error delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    
    [alert show];
    
    [alert release];

}

#pragma mark -
#pragma mark 通知来到时  进行的操作


- (void) doSalarySearchWhenNotifictionCome:(NSNotification *) notifictionName{
    
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *notiName = [notifictionName name];
    NSString *message = [[notifictionName userInfo] objectForKey:ERRORMessage];
    
    if ([notiName isEqualToString:SUCCESSResultFORSALARYSearch]) {
        
        isNetWorkSuccess =YES;
        NSLog(@"这是用通知的方式 通知数据请求成功");
        
               
    } 
    
    if ([notiName isEqualToString:ERRORRequest]) {
        NSLog(@"这是用通知的方式 通知数据请求失败");
        
        isNetWorkSuccess = NO;
        
      [self showAlerInfoWhenErrorHappen:message];
        
        
    }

       
}
    
    
#pragma mark -
#pragma mark MBProgressHUDDelegate methods

//在代理方法中  执行推送界面
- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
    
    
    //如果成功 则跳转到下一个界面
    if (isNetWorkSuccess) {
        
   
    //创建controller
    VIPSalaryCompareVontroller *controller = [[VIPSalaryCompareVontroller alloc] init];
    
    //查询到的薪水信息
    controller.salaryInfoArray = tmpSaveSalaryInfo;
    
    //用户查询的关键字信息
    controller.salarySearchInfoDictionary = prepareItemsForNetWork;
    //用户显示 用的数据
    controller.salarySearchInfoDictionaryForshow=prepareItemsWithNameForSalarySearch;
    
    //传allKeys
    controller.itemsAllKeys = self.itemAllkeys;
    
    [self.navigationController pushViewController:controller animated:YES];
    //释放
    
    [controller release];
    }

	HUD = nil;
}



#pragma mark -
#pragma mark 表格的尾部视图
- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    UIView *view = nil;
    
    if (section==0) {
        
        view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        
        
        UIButton *bn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        bn.frame=CGRectMake(100, 0, 130, 37);
        [bn setTitle:@"保存" forState:UIControlStateNormal];
        [bn addTarget:self action:@selector(bnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:bn];
        return view;
        
        
    }
    return  view;
    
    
}


- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    if (section==0) {
        return 40;
    }
    return  40;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    
    
    //注册通知 
    
    NSNotificationCenter *center =[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(doSalarySearchWhenNotifictionCome:) name:nil object:nil];
    
    
    self.itemAllkeys = [DealWithNetWorkAndXmlHelper getAllKeys];
    
    self.navigationController.navigationBarHidden = NO;
    
    selextedArrar = [[NSArray alloc] initWithObjects:@"我有工作经验",@"地区:",@"行业:",@"学历:",@"企业性质:",@"职位类别:",@"职位级别:",@"期望月薪:", nil];
    tipArray = [[NSArray alloc] initWithObjects:@" ", @"请选择地区",@"请选择行业",@"请选择学历",@"请选择企业性质",@"请选择职位类别",@"请选择职位级别",@"请点击输入",nil];
    
    SaveDataSingleton *myData = [SaveDataSingleton DefaultSaveData];
    
    NSLog(@"cityItemDictionary = %d",[myData.cityItemDictionary count]);
    NSLog(@"IndustryItemsDictionary = %d",[myData.IndustryItemsDictionary count]);
    NSLog(@"EducationItemsDictionary = %d",[myData.EducationItemsDictionary count]);
    NSLog(@"CompanyTypeItemsDictionary count = %d",[myData.CompanyTypeItemsDictionary count]);
    NSLog(@"JobTypeItemsDictionary count = %d",[myData.JobTypeItemsDictionary count]);
    NSLog(@"JobLevelItemsDictionary count =%d",[myData.JobLevelItemsDictionary count]);
    
    
    //保存字典的数组 各个选择项目
    
    tmpSaveArray =[[NSArray alloc] initWithObjects:myData.cityItemDictionary,myData.IndustryItemsDictionary,myData.EducationItemsDictionary,myData.CompanyTypeItemsDictionary,myData.JobTypeItemsDictionary,myData.JobLevelItemsDictionary, nil];
    
    
    prepareItemsForNetWork = [[NSMutableDictionary alloc] init];
    
    prepareItemsWithNameForSalarySearch =[[NSMutableDictionary alloc] init];
    //默认是有经验
    [prepareItemsForNetWork removeObjectForKey:[itemAllkeys objectAtIndex:0]];
    [prepareItemsForNetWork setObject:[NSNumber numberWithInt:1] forKey:[self.itemAllkeys objectAtIndex:0]];
    
    self.scrollview.contentSize=CGSizeMake(320, 600);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableview:nil];
    [self setScrollview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void) isHaveExperence:(UISegmentedControl *) sender {
    
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    if (sender.selectedSegmentIndex==0) {
        NSLog(@"有经验");
        [prepareItemsForNetWork removeObjectForKey:[itemAllkeys objectAtIndex:0]];
        [prepareItemsForNetWork setObject:[NSNumber numberWithInt:1] forKey:[self.itemAllkeys objectAtIndex:0]];
        
        [prepareItemsWithNameForSalarySearch removeObjectForKey:[itemAllkeys objectAtIndex:0]];
        [prepareItemsWithNameForSalarySearch setObject:@"有经验" forKey:[itemAllkeys objectAtIndex:0]];
        
        
        
        
    } else{
        NSLog(@"没经验");
        [prepareItemsForNetWork removeObjectForKey:[itemAllkeys objectAtIndex:0]];
        [prepareItemsForNetWork setObject:[NSNumber numberWithInt:2] forKey:[self.itemAllkeys objectAtIndex:0]];
        
        [prepareItemsWithNameForSalarySearch removeObjectForKey:[itemAllkeys objectAtIndex:0]];
        [prepareItemsWithNameForSalarySearch setObject:@"无经验" forKey:[itemAllkeys objectAtIndex:0]];

        
        
        
    }
    
    
    
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return [selextedArrar count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=nil;
    
    
    //如果是第一行
    if (indexPath.row==0) {
        
        static NSString *CellIdentifier = @"cell0";
        
        cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CustomCellForRow0" owner:self options:nil];
            cell = [array objectAtIndex:0];
            
        }
        
        UISegmentedControl *segController = (UISegmentedControl *)[cell viewWithTag:100];
        [segController addTarget:self action:@selector(isHaveExperence:) forControlEvents:UIControlEventValueChanged];
        
        
        
        
    }
    
    
    else {
        
        static NSString *CellIdentifier = @"cell";
        
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"VIPCustomCellForSalarySearch" owner:self options:nil];
            cell = [array objectAtIndex:0];
            
            
            
        }
        CustomcellForSalary *thiscell = (CustomcellForSalary *) cell;
        //用户交互默认关闭
        thiscell.tipTextField.userInteractionEnabled = NO;
        
        thiscell.tipTextField.placeholder = [tipArray objectAtIndex:indexPath.row];
        thiscell.selectedLabel.text = [selextedArrar objectAtIndex:indexPath.row];
        
        if (indexPath.row==7) {
            
            
            //用户交互打开
            thiscell.tipTextField.userInteractionEnabled = YES;
            
            thiscell.tipTextField.borderStyle = UITextBorderStyleRoundedRect;
            thiscell.tipTextField.frame = CGRectMake(107, 6, 188, 31);
            thiscell.tipTextField.delegate= self;
            [thiscell.stateImageView removeFromSuperview];
            
            
        }
        
        
    }
    
    
    
    // Configure the cell...
    
    return cell;
}


#pragma mark - Table view delegate

//劫持用户选择
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *path = indexPath;
    if (indexPath.row==0||indexPath.row==7) {
        path = nil;
    }
    return path;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"用户选择的是第%d行",indexPath.row);
    
    VIPSelectedTableviewController *controller =[[VIPSelectedTableviewController alloc] init];
    
    //返回正确的字典 传进去正确的
    controller.tmpDictionary= [tmpSaveArray objectAtIndex:indexPath.row-1];
    //选取的是哪一行
    controller.tmpIndexPath=indexPath;
    //设置代理
    controller.delegate = self;
    //推出选择界面
    [self.navigationController pushViewController:controller animated:YES];
    
}


#pragma mark -
#pragma mark 选择界面返回时的代理


//在这个方法中主要处理用户选择的项目  封装成字典形式
- (void) VIPSelectedTableviewController:(VIPSelectedTableviewController *)controller didSelectItem:(NSString *)itemName atSelectIndexPath:(NSIndexPath *)path{
    
    //执行与服务器传值前的数据封装
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    NSLog(@"执行与服务器传值前的数据封装");
    
    //取得用户开始选择的是哪一个tablecell
    CustomcellForSalary *cell = (CustomcellForSalary *)[self.tableview cellForRowAtIndexPath:path];
    //获取用户的选择
    cell.tipTextField.text = itemName;
    
    
    
    
    //获得的是选择的那个字典数据
    NSDictionary *tmp = [tmpSaveArray objectAtIndex:path.row-1];
    
    //获取数据的key 
    NSString *keyValue = [[tmp allKeysForObject:itemName] objectAtIndex:0];
    
    NSLog(@"Object value = %@",keyValue);
    NSLog(@"key value =%@",[self.itemAllkeys objectAtIndex:path.row]);
    
    //删除 指定key的数据
    [prepareItemsForNetWork removeObjectForKey:[self.itemAllkeys objectAtIndex:path.row]];
    
    //插入 指定key的value
    
    [prepareItemsForNetWork setObject:keyValue forKey:[self.itemAllkeys objectAtIndex:path.row]];
    
    
    
    //为后面的controller 显示数据   封装
    [prepareItemsWithNameForSalarySearch removeObjectForKey:[itemAllkeys objectAtIndex:path.row]];
    
    [prepareItemsWithNameForSalarySearch setObject:itemName forKey:[itemAllkeys objectAtIndex:path.row]];

    
    
    
    
    
}
- (void)dealloc {
    [tableview release];
    [scrollview release];
    [super dealloc];
}
- (IBAction)getSalaryInfo:(id)sender {
    
    
    NSLog(@"字典中存的参数为：%d",[prepareItemsForNetWork count]);
    
    
}
@end
