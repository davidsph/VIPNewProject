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
@implementation VIPSalarySearchViewController
@synthesize tableview;

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
    
    [textField resignFirstResponder];
    return  YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    NSLog(@"结束编辑进行的操作");
    return YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
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
    
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableview:nil];
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
    
    NSLog(@"值变化了");
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
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

- (void)bnClicked:(id) sender{
    
    NSLog(@"保存操作");
    
}

/*
- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    UIView *view = nil;
            
        view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        
        
        UIButton *bn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        bn.frame=CGRectMake(100, 0, 130, 37);
        [bn setTitle:@"保存" forState:UIControlStateNormal];
        [bn addTarget:self action:@selector(bnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:bn];
        
return  view;
    
    
}
*/


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)dealloc {
    [tableview release];
    [super dealloc];
}
@end
