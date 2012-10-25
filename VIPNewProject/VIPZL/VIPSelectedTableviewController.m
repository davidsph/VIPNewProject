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
    
    //获取字典中的所有值
    tmpValueArray = [[NSArray alloc] initWithArray:[tmpDictionary allValues]];
    
    
    NSLog(@"接到的数据为 count %d",[tmpDictionary count]);
    NSLog(@"接受到的用户选择的是第%d行",tmpIndexPath.row);
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//dealloc方法
-(void) dealloc{
    //释放对象
    [tmpIndexPath release ];
    self.tmpDictionary = nil;
    
    
    //调用父类dealloc方法
    [super dealloc];
};

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

//简单样式cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    //显示对应选择项目
    cell.textLabel.text=[tmpValueArray objectAtIndex:indexPath.row];
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *selectedItem = [tmpValueArray objectAtIndex:indexPath.row];
    
    
    
    NSLog(@"用户选择的是 %@",selectedItem);
    
    //代理传值 将用户的选择返回到显示列表
    
    [self.delegate VIPSelectedTableviewController:self didSelectItem:selectedItem atSelectIndexPath:tmpIndexPath];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
