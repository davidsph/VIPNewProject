//
//  VIPSelectedTableviewController.m
//  VIPZL
//
//  Created by david on 12-10-22.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import "VIPSelectedTableviewController.h"

@implementation VIPSelectedTableviewController
@synthesize tmpDictionary;
@synthesize tmpIndexPath;
@synthesize delegate;
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

    tmpValueArray = [[NSArray alloc] initWithArray:[tmpDictionary allValues]];
   
    
    NSLog(@"接ushoudao的 数据为 count %d",[tmpDictionary count]);
    NSLog(@"接受到的用户选择的是第%d行",tmpIndexPath.row);
    
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

    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [tmpDictionary count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text=[tmpValueArray objectAtIndex:indexPath.row];
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"在第二季菜单中，用户选择的是第%d行",indexPath.row);
    NSString *selectedItem = [tmpValueArray objectAtIndex:indexPath.row];
    NSLog(@"用户选择的是 %@",selectedItem);
    
    [self.delegate VIPSelectedTableviewController:self didSelectItem:selectedItem atSelectIndexPath:tmpIndexPath];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
