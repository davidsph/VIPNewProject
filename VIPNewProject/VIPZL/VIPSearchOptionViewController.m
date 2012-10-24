//
//  VIPSearchOptionViewController.m
//  VIPZL
//
//  Created by Ibokan on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VIPSearchOptionViewController.h"
#import "XMLAnalysis.h"
#import "VIPDetailViewController.h"

@implementation VIPSearchOptionViewController
@synthesize delegate,tag;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"controolers = %@",self.navigationController.viewControllers);
    switch (tag) {
        case 0:
        {
            break;
        }
        case 1:
        {
            array = [[NSArray alloc] initWithArray:[XMLAnalysis XMLAnalysisJob]];
            break;
        }
        case 2:
        {
            array = [[NSArray alloc] initWithArray:[XMLAnalysis XMLAnalysisIndustry]];
            break;
        }
        case 3:
        {
            array = [[NSArray alloc] initWithArray:[XMLAnalysis XMLAnalysisProvince]];
            break;
        }
        case 5:
        {
            array = [[NSArray alloc] initWithObjects:@"不限",@"1公里",@"3公里",@"5公里", nil];
            break;
        }
        default:
            break;
    }
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
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"" size:16];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tag==1||tag==3) {
        VIPDetailViewController *dtVC = [[VIPDetailViewController alloc] init];
        dtVC.tag = tag;
        dtVC.theRow = indexPath.row;
        dtVC.delegate = self;
        [self.navigationController pushViewController:dtVC animated:YES];
        [dtVC release];
    }
    else{
        if (delegate!= nil && [delegate respondsToSelector:@selector(sentOption:tag:)]) {
            [delegate sentOption:[array objectAtIndex:indexPath.row] tag:tag];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}
#pragma mark -- 实现detailprotocol的方法
-(void)sent:(NSString *)message tag:(int)tag1
{
    NSLog(@"message = %@,tag = %d",message,tag1);
    
    if (delegate!= nil && [delegate respondsToSelector:@selector(sentOption:tag:)]) {
        [delegate sentOption:message tag:tag1];
    }
    
}
@end
