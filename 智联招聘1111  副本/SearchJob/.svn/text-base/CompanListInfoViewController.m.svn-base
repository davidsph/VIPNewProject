//
//  CompanListInfoViewController.m
//  LookAtMyJLi
//
//  Created by david on 12-10-17.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import "CompanListInfoViewController.h"
#import "MycustomerCellForJianli.h"
#import "LIistItemsForCompany.h"
#import "Resume.h"
#import "DealWithNetworkAndXMLHelper.h"

@implementation CompanListInfoViewController
@synthesize resumeItemsOfCompany;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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


- (void) initCompanyData:(Resume *) resume{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    //得到公司列表 count作为tableview的行数
    
    companyArray = [[DealWithNetworkAndXMLHelper getCompanyList:resume] retain];
    
    NSLog(@"传值过来的count =%d",[companyArray count]);
    
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    companyArray =[[NSArray alloc] init];
    selectedCompany = [[NSMutableArray alloc] initWithCapacity:10];
    selectedBns =[[NSMutableSet alloc]initWithCapacity:5];
    
    
    [self initCompanyData:self.resumeItemsOfCompany];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [companyArray count];
}

//改变按钮 背景图片
-(void) bnClicked:(UIButton *) bn{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    
    
    
    if ([selectedBns member:[NSNumber numberWithInt:bn.tag]]==nil) {
        
        [bn setBackgroundImage:[UIImage imageNamed:@"resume_selected@2x.png"] forState:UIControlStateNormal];
        [selectedBns addObject:[NSNumber numberWithInt:bn.tag]];
        
        
    } else{
        
        [bn setBackgroundImage:[UIImage imageNamed:@"resume_unselected@2x.png"] forState:UIControlStateNormal];
        [selectedBns removeObject:[NSNumber numberWithInt:bn.tag]];
    }
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    
    
    MycustomerCellForJianli *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        
        //        UINib *nib = [UINib nibWithNibName:@"MycustomerCellForJianli" bundle:nil];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MycustomerCellForJianli" owner:self options:nil] objectAtIndex:0];
        
        
        //        [self.tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
        
    }
    
    
    cell.selectionStyle= UITableViewCellSelectionStyleGray;
    

    LIistItemsForCompany *listCompanyItem =[companyArray objectAtIndex:indexPath.row];
    
    cell.companyName.text = listCompanyItem.companyName;
    cell.companySize.text = listCompanyItem.companySize;
    cell.companyLocation.text= listCompanyItem.company_location;
    cell.date_show.text = listCompanyItem.date_show;
    
    
    
    cell.selectedButtonState.tag=indexPath.row;
    [cell.selectedButtonState setBackgroundImage:[UIImage imageNamed:@"resume_unselected@2x.png"] forState:UIControlStateNormal];
    [cell.selectedButtonState addTarget:self action:@selector(bnClicked:) forControlEvents:UIControlEventTouchUpInside];

    
    if ([selectedBns member:[NSNumber numberWithInt:cell.selectedButtonState.tag]]!=nil) {
        
        [cell.selectedButtonState setBackgroundImage:[UIImage imageNamed:@"resume_selected@2x.png"] forState:UIControlStateNormal];
        
        
    }
    
    
    
    return cell;
}

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
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 60;
    
}

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

@end
