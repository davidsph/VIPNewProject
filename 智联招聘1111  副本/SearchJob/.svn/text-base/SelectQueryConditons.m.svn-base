//
//  SelectQueryConditons.m
//  SalarySearch
//
//  Created by Ibokan on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectQueryConditons.h"


@implementation SelectQueryConditons

@synthesize selectedArray ;
@synthesize selectDelegate;

- (void)dealloc
{
    [self.selectedArray release];
    [super dealloc];
}

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
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame =  CGRectMake(0, 0, 44, 34);
    backButton.titleLabel.font =[UIFont systemFontOfSize:15.0];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.adjustsFontSizeToFitWidth =YES;
    [backButton setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
   
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
   
    self.navigationItem.leftBarButtonItem = backBarButton;
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.selectedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
   
    cell.textLabel.text =[self.selectedArray objectAtIndex:indexPath.row];
    cell.textLabel.font =[UIFont systemFontOfSize:17.0];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.selectDelegate &&[self.selectDelegate respondsToSelector:@selector(selectQueryCondition:atIndexPath:)]) {
        [self.selectDelegate selectQueryCondition:self atIndexPath:indexPath];
    }else{
        NSLog(@"无代理实现");
    }
    
    if (self.selectDelegate&&[self.selectDelegate respondsToSelector:@selector(selectedRowIn:)]) {
        [self.selectDelegate selectedRowIn:self];//执行代理方法
    }
    
    UITableViewCell *oneCell = [tableView cellForRowAtIndexPath: indexPath]; 
    //选中的标记效果
    if (oneCell.accessoryType == UITableViewCellAccessoryNone) {  
        oneCell.accessoryType = UITableViewCellAccessoryCheckmark;  
    } else   
        oneCell.accessoryType = UITableViewCellAccessoryNone;  
     
                  
    [self.navigationController popViewControllerAnimated:YES];
       
}

@end
