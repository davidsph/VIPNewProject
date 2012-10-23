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
@implementation VIPSalarySearchViewController
@synthesize scrollview;
@synthesize tableview;
@synthesize tmpSaveArray;
@synthesize itemAllkeys;
@synthesize prepareItemsForNetWork;
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


-(void) bnClicked:(UIButton *) bn{
    
   
    NSLog(@"待传递的参数为 count = %d", [prepareItemsForNetWork count]);
    
    
    [DealWithNetWorkAndXmlHelper getSalaryInfoFromNetWork:prepareItemsForNetWork];
    
    
    NSLog(@"保存按钮");
    
    
}

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
    
    
    //保存字典的数组
    
    tmpSaveArray =[[NSArray alloc] initWithObjects:myData.cityItemDictionary,myData.IndustryItemsDictionary,myData.EducationItemsDictionary,myData.CompanyTypeItemsDictionary,myData.JobTypeItemsDictionary,myData.JobLevelItemsDictionary, nil];
    
    
    prepareItemsForNetWork = [[NSMutableDictionary alloc] init];
    
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
        
     
        
    } else{
        NSLog(@"没经验");
        [prepareItemsForNetWork removeObjectForKey:[itemAllkeys objectAtIndex:0]];
       [prepareItemsForNetWork setObject:[NSNumber numberWithInt:2] forKey:[self.itemAllkeys objectAtIndex:0]];
        
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
    
    controller.tmpDictionary= [tmpSaveArray objectAtIndex:indexPath.row-1];
    controller.tmpIndexPath=indexPath;
    controller.delegate = self;
    
    [self.navigationController pushViewController:controller animated:YES];
    
    }

- (void) VIPSelectedTableviewController:(VIPSelectedTableviewController *)controller didSelectItem:(NSString *)itemName atSelectIndexPath:(NSIndexPath *)path{
    
    //执行与服务器传值前的数据封装
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    NSLog(@"执行与服务器传值前的数据封装");
    
    CustomcellForSalary *cell = (CustomcellForSalary *)[self.tableview cellForRowAtIndexPath:path];
    
    cell.tipTextField.text = itemName;
    
    NSDictionary *tmp = [tmpSaveArray objectAtIndex:path.row-1];
    NSString *keyValue = [[tmp allKeysForObject:itemName] objectAtIndex:0];
    NSLog(@"Object value = %@",keyValue);
    NSLog(@"key value =%@",[self.itemAllkeys objectAtIndex:path.row]);
    
    [prepareItemsForNetWork removeObjectForKey:[self.itemAllkeys objectAtIndex:path.row]];
    
    [prepareItemsForNetWork setObject:keyValue forKey:[self.itemAllkeys objectAtIndex:path.row]];
    
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