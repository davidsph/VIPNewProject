//
//  CityViewController.m
//  xiangmu
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1FirstLevelViewController.h"

#import "A1LevelViewCell.h"
#import "A1SecondLevelViewController.h"
#import "GDataXMLNode.h"

@implementation A1FirstLevelViewController

@synthesize selectRow;
@synthesize provienceID;
@synthesize provienceArr;
@synthesize jobArr;
@synthesize jobIDArr;
@synthesize industryArr;
@synthesize publishDateArr;
@synthesize workEXPArr;
@synthesize educationArr;
@synthesize compsizeArr;
@synthesize comptypeArr;
@synthesize delegate;
@synthesize string;


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

-(void)initData
{
    
    NSString * str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"basedata" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];//本地的
    // NSLog(@"%@",str);
    //解析XML,把结果放在document里边.
    GDataXMLDocument * document = [[GDataXMLDocument alloc] initWithXMLString:str options:0 error:nil];
    GDataXMLElement * root = [document rootElement];//获得根节点


    if (self.selectRow == 3)
    {
        provienceArr = [[NSMutableArray alloc] init];
        provienceID = [[NSMutableArray alloc] init];
        
        NSArray *rootChildren=[root children];//获得根节点的各个子节点
        GDataXMLElement *basedata =[rootChildren objectAtIndex:0];
        GDataXMLElement *city=[[basedata children]objectAtIndex:0];
        GDataXMLElement *firstLevel=[[city children]objectAtIndex:0];
        
        
        for (int i=0;i<[firstLevel childCount];i++) 
        {
            GDataXMLElement *firstCity=[[firstLevel children]objectAtIndex:i];
            NSString *firstCityName=[firstCity stringValue];
            NSString *firstCityId=[[firstCity attributeForName:@"code"]stringValue];
            [provienceArr addObject:firstCityName];
            
            [provienceID addObject:firstCityId];
            
        }

    }
    else if (self.selectRow == 1)
    {
        
        self.jobArr = [[NSMutableArray alloc] init];
        self.jobIDArr = [[NSMutableArray alloc] init];
                
        NSArray * arr = [root nodesForXPath:@"//jobtype/item" error:nil];
        for(GDataXMLElement * item in arr)
        {
            NSString *firstCityId=[[item attributeForName:@"code"]stringValue];
            
            [self.jobArr addObject:[item stringValue]];
            [self.jobIDArr addObject:firstCityId];
            
        }

    }
    else if (self.selectRow == 2)
    {
        
        self.industryArr = [[NSMutableArray alloc] init];

        NSArray * arr = [root nodesForXPath:@"//industry/item" error:nil];
        for(GDataXMLElement * item in arr)
        {            
            [self.industryArr addObject:[item stringValue]];            
        }

    }
    else if (self.selectRow == 4)
    {
        self.publishDateArr = [[NSMutableArray alloc] init];
        
        NSArray * arr = [root nodesForXPath:@"//publishDate/item" error:nil];
        for(GDataXMLElement * item in arr)
        {            
            [self.publishDateArr addObject:[item stringValue]];
        }

    }
    else if (self.selectRow == 5)
    {
        self.workEXPArr = [[NSMutableArray alloc] init];
        
        NSArray * arr = [root nodesForXPath:@"//workEXP/item" error:nil];
        for(GDataXMLElement * item in arr)
        {            
            [self.workEXPArr addObject:[item stringValue]];
        }
        
    }
    else if (self.selectRow == 6)
    {
        self.educationArr = [[NSMutableArray alloc] init];
        
        NSArray * arr = [root nodesForXPath:@"//education/item" error:nil];
        for(GDataXMLElement * item in arr)
        {            
            [self.educationArr addObject:[item stringValue]];
        }
        
    }
    else if (self.selectRow == 7)
    {
        self.comptypeArr = [[NSMutableArray alloc] init];
        
        NSArray * arr = [root nodesForXPath:@"//comptype/item" error:nil];
        for(GDataXMLElement * item in arr)
        {            
            [self.comptypeArr addObject:[item stringValue]];
        }
        
    }
    else if (self.selectRow == 8)
    {
        self.compsizeArr = [[NSMutableArray alloc] init];
        
        NSArray * arr = [root nodesForXPath:@"//compsize/item" error:nil];
        for(GDataXMLElement * item in arr)
        {            
            [self.compsizeArr addObject:[item stringValue]];
        }
        
    }
}

-(void) viewDidLoad
{
    [self initData];
    
    
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
  //  UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    

  //  self.navigationItem.leftBarButtonItem = left;
    
    self.navigationItem.title = self.string;

}

-(void)back
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(self.selectRow == 3)
    {
        return [self.provienceArr count];
    }
    else if (self.selectRow == 1)
    {
        return [self.jobArr count];
    }
    else if (self.selectRow == 2)
    {
        return [self.industryArr count];
    }
    else if (self.selectRow == 4)
    {
        return [self.publishDateArr count];
    }
    else if (self.selectRow == 5)
    {
        return [self.workEXPArr count];
    }
    else if (self.selectRow == 6)
    {
        return [self.educationArr count];
    }

    else if (self.selectRow == 7)
    {
        return [self.comptypeArr count];
    }

    else if (self.selectRow == 8)
    {
        return [self.compsizeArr count];
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    A1LevelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[A1LevelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (self.selectRow == 1) 
    { 
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"11.png"];
        }
        cell.nameLabel.text = [self.jobArr objectAtIndex:indexPath.row];
        
    }
    else if (self.selectRow == 3)
    {
        cell.nameLabel.text = [self.provienceArr objectAtIndex:indexPath.row];
    }
    else if (self.selectRow == 2)
    {
        cell.nameLabel.text = [self.industryArr objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"11.png"];
    }
    else if (self.selectRow == 4)
    {
        cell.nameLabel.text = [self.publishDateArr objectAtIndex:indexPath.row];
         cell.imageView.image = [UIImage imageNamed:@"11.png"];
    }
    else if (self.selectRow == 5)
    {
        cell.nameLabel.text = [self.workEXPArr objectAtIndex:indexPath.row];
         cell.imageView.image = [UIImage imageNamed:@"11.png"];
    }
    else if (self.selectRow == 6)
    {
        cell.nameLabel.text = [self.educationArr objectAtIndex:indexPath.row];
         cell.imageView.image = [UIImage imageNamed:@"11.png"];
    }
    else if (self.selectRow == 7)
    {
        cell.nameLabel.text = [self.comptypeArr objectAtIndex:indexPath.row];
         cell.imageView.image = [UIImage imageNamed:@"11.png"];
    }
    else if (self.selectRow == 8)
    {
        cell.nameLabel.text = [self.compsizeArr objectAtIndex:indexPath.row];
         cell.imageView.image = [UIImage imageNamed:@"11.png"];
    }
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((self.selectRow == 1 && indexPath.row != 0)|| self.selectRow== 3) {
        
        A1SecondLevelViewController * detalied = [[A1SecondLevelViewController alloc] init];
        detalied.delegate =(id) self.delegate;
        
        if (self.selectRow == 1) {
            detalied.string = [self.jobArr objectAtIndex:indexPath.row];
        }
        else
        {
            detalied.string = [self.provienceArr objectAtIndex:indexPath.row];
        }
        
        detalied.sendID = indexPath.row;
        detalied.proArr = provienceID;
        
        detalied.jobIDArr = self.jobIDArr;
        detalied.sendPreviousID = self.selectRow;
        
        detalied.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detalied animated:YES];
       // detalied.hidesBottomBarWhenPushed = NO;
        [detalied release];
        
    }
    else
    {
        if (self.selectRow == 1 && indexPath.row == 0) {
            self.string = (NSMutableString *)@"不限";
        }
        if (self.selectRow == 2) {
           self.string = [industryArr objectAtIndex:indexPath.row];
        }
        else if (self.selectRow == 4){
            self.string = [publishDateArr objectAtIndex:indexPath.row];
        }
        else if (self.selectRow == 5){
            self.string = [workEXPArr objectAtIndex:indexPath.row];
        }
        else if (self.selectRow == 6){
            self.string = [educationArr objectAtIndex:indexPath.row];
        }
        else if (self.selectRow == 7){
            self.string = [comptypeArr objectAtIndex:indexPath.row];
        }
        else if (self.selectRow == 8){
            self.string = [compsizeArr objectAtIndex:indexPath.row];
        }
        
        [self.delegate A1FirstLevelViewController:self didSelectItem:self.string];
        //[self.navigationController popToRootViewControllerAnimated:YES];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1 ]animated:YES];
        
    }
}


@end
