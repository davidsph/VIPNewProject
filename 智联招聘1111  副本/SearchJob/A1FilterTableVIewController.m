//
//  A1FilterTableVIewController.m
//  SearchJob
//
//  Created by Ibokan on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1FilterTableVIewController.h"
#import "A1FindJobViewCell.h"
#import "A1LevelViewCell.h"
#import "A1FirstLevelViewController.h"
#import "GDataXMLNode.h"
#import "A1FindJobViewController.h"
#import "SearchJob.h"
#import <QuartzCore/QuartzCore.h>

@implementation A1FilterTableVIewController
@synthesize _tableView;
@synthesize firstArr;
@synthesize secondArr;
@synthesize _tableView1;
@synthesize view1;
@synthesize publishDateArr;
@synthesize workEXPArr;
@synthesize educationArr;
@synthesize compsizeArr;
@synthesize comptypeArr;
@synthesize salaryArr;
@synthesize view2;
@synthesize compareArr;
@synthesize search;
@synthesize showtable;

-(void)initData
{
    self.firstArr=[NSMutableArray arrayWithObjects:@"发布时间",@"工作经验:",@"学历要求:",@"公司性质:",@"公司规模:",@"月薪范围:", nil];
    self.secondArr=[NSMutableArray arrayWithObjects:@"请选择发布时间",@"请选择工作经验",@"请选择学历要求",@"请选择公司性质",@"请选择公司规模",@"不选择", nil];
    self.compareArr=[NSMutableArray arrayWithObjects:@"请选择发布时间",@"请选择工作经验",@"请选择学历要求",@"请选择公司性质",@"请选择公司规模",@"不选择", nil];
}
- (void)viewDidLoad
{
    self.navigationItem.title = @"筛选条件";
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 55, 44);
    [btn setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    [btn setTitle:@"结果" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont fontWithName:@"ArialMT" size:14];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:btn];  
    self.navigationItem.leftBarButtonItem=backBtn;   
    [backBtn release];

    [self initData];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)]; //self.tableView的背景设置
    imageView.image = [UIImage imageNamed:@"纸纹"];

    
   
    self._tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStyleGrouped];
    self._tableView.delegate = self;
    self._tableView.dataSource = self;
    self._tableView.backgroundView = imageView;
    [self.view addSubview:self._tableView];
    
     [super viewDidLoad];
}


-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    
}




#pragma mark - Table view delegate

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch =[touches anyObject];
    CGPoint  point =[touch locationInView:self.view1];
    NSLog(@"%f,%f",point.x,point.y);
    if (point.x>0 && point.x<100) {
        [view1 removeFromSuperview];
    }    
    self._tableView.userInteractionEnabled = YES;
    self._tableView.tableFooterView.userInteractionEnabled = YES;
}


-(void) initNewTable
{
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.view1.backgroundColor = [UIColor blackColor];
    self.view1.alpha = 0.75;
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)]; //self.tableView的背景设置
    imageView.image = [UIImage imageNamed:@"纸纹"];
    
    self._tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(100, 2, 220, 480) style:UITableViewStyleGrouped];
    self._tableView1.delegate = self;
    self._tableView1.dataSource = self;
    self._tableView1.backgroundView = imageView;
    [self.view1 addSubview:self._tableView1];
    
    
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.2f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromRight;
    [self.view1.layer addAnimation:animation forKey:@"animation"];
    
    
    [self.view addSubview:self.view1];
    
    self._tableView.userInteractionEnabled = NO;
    self.view1.userInteractionEnabled = YES;
    self._tableView1.userInteractionEnabled = YES;
    
    [view1 release];
    [_tableView1 release];
    
    [self initNewTableData];
    
}

-(void)initNewTableData
{
    NSString * str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"basedata" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];//本地的
    // NSLog(@"%@",str);
    //解析XML,把结果放在document里边.
    GDataXMLDocument * document = [[GDataXMLDocument alloc] initWithXMLString:str options:0 error:nil];
    GDataXMLElement * root = [document rootElement];//获得根节点
    switch (selectRow) {
        case 0:
        {
            self.publishDateArr = [[NSMutableArray alloc] init];
            
            NSArray * arr = [root nodesForXPath:@"//publishDate/item" error:nil];
            for(GDataXMLElement * item in arr)
            {            
                [self.publishDateArr addObject:[item stringValue]];
            }
            
            break;
        }
        case 1:
        {
            self.workEXPArr = [[NSMutableArray alloc] init];
            
            NSArray * arr = [root nodesForXPath:@"//workEXP/item" error:nil];
            for(GDataXMLElement * item in arr)
            {            
                [self.workEXPArr addObject:[item stringValue]];
            }
            break;
        }
        case 2:
        {
            self.educationArr = [[NSMutableArray alloc] init];
            
            NSArray * arr = [root nodesForXPath:@"//education/item" error:nil];
            for(GDataXMLElement * item in arr)
            {            
                [self.educationArr addObject:[item stringValue]];
            }
            break;
        }
        case 3:
        {
            self.comptypeArr = [[NSMutableArray alloc] init];
            
            NSArray * arr = [root nodesForXPath:@"//comptype/item" error:nil];
            for(GDataXMLElement * item in arr)
            {            
                [self.comptypeArr addObject:[item stringValue]];
            }           
            break;
        }
        case 4:
        {
            self.compsizeArr = [[NSMutableArray alloc] init];
            NSArray * arr = [root nodesForXPath:@"//compsize/item" error:nil];
            for(GDataXMLElement * item in arr)
            {            
                [self.compsizeArr addObject:[item stringValue]];
            }
            break;
        }
        case 5:
        {
            self.salaryArr = [[NSMutableArray alloc] init];
            
            NSArray * arr = [root nodesForXPath:@"//salary/item" error:nil];
            for(GDataXMLElement * item in arr)
            {            
                [self.salaryArr addObject:[item stringValue]];
            }
            break;
        }
            
        default:
            break;
    }
}

-(void)changeCenter
{
    CGPoint p=self.view1.center;
    p.x+=320;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.35];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view1 cache:NO];
    
    self.view1.center=p;
    [UIView commitAnimations];
    
    self._tableView.userInteractionEnabled = YES;
    
    
}

-(void)searchJob
{
    
    [SearchJob addSearchJobINDataBaseofschJobType:self.search.schJobType industry:self.search.industry city:self.search.city keyWord:self.search.keyWord dataRefresh:[NSString stringWithFormat:@"%d",self.search.dataRefresh] pointRanger:self.search.pointRanger workingExp:self.search.workingExp companyType:self.search.companyType companySize:self.search.companySize salaryFrom:[NSString stringWithFormat:@"%d",self.search.salaryFrom] salaryTo:[NSString stringWithFormat:@"%d",self.search.salaryTo] sort:self.search.sort date:self.search.date];
    
    
    SearchJob * seachJob = [[SearchJob alloc] initWithType:1 schJobType:self.search.schJobType subJobType:005 industry:self.search.industry city:self.search.city keyWord:self.search.keyWord dataRefresh:self.search.dataRefresh eduLevel:2 jobLocation:nil pointRanger:self.search.pointRanger workingExp:self.search.workingExp companyType:self.search.companyType companySize:self.search.companySize emplType:nil salaryFrom:self.search.salaryFrom salaryTo:self.search.salaryTo sort:self.search.sort date:self.search.date];
    
//    NSLog(@"schJobType=%@",self.search.schJobType);
//    NSLog(@"industry=%@",self.search.industry);
//    NSLog(@"city=%@",self.search.city);
//    NSLog(@"keyword=%@",self.search.keyWord);
//    NSLog(@"dataRefrsh=%d",self.search.dataRefresh);
//    NSLog(@"edulevel=%d",self.search.eduLevel);
//    NSLog(@"workingexp=%@",self.search.workingExp);
//    NSLog(@"companytype=%@",self.search.companyType);
//    NSLog(@"companysize=%@",self.search.companySize);
//    NSLog(@"salaryfrom=%d",self.search.salaryFrom);
//    NSLog(@"salaryto=%d",self.search.salaryTo);
//    NSLog(@"date=%@",self.search.date);
    
    
    self.showtable.searchjob=seachJob;
    [self.showtable.searchjob advancedSearchWith:1 Pagesize:20];
    self.showtable.count=1;

    CATransition *animation = [CATransition animation];
    animation.duration = 0.25f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];    

    [self.navigationController popViewControllerAnimated:NO];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self._tableView) {
        return 6;
    }
    else
    {
        switch (selectRow) {
            case 0:
                return [self.publishDateArr count];
            case 1:
                return [self.workEXPArr count];
            case 2:
                return [self.educationArr count];
            case 3:
                return [self.comptypeArr count];
            case 4:
                return [self.compsizeArr count];
            case 5:
                return [self.salaryArr count];
            default:
                break;
        }
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{  
    return 70.0f;  
}  


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (tableView == self._tableView) {
        UIView * myView =[[[UIView alloc] init] autorelease];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(70, 15, 185, 42);
        
        [button setTitle:@"查找" forState:UIControlStateNormal];  
        [button setBackgroundImage:[UIImage imageNamed:@"button_bg_normal.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(searchJob) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:button];
        
        return myView; 
    }
    else
    {
        return nil;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self._tableView) {
        static NSString *CellIdentifier = @"Cell";
        
        A1FindJobViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[A1FindJobViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        if (!([[self.secondArr objectAtIndex:indexPath.row] isEqualToString:[self.compareArr objectAtIndex:indexPath.row]])) {
            cell.grayName.textColor = [UIColor blackColor];
        }
        cell.advancedName.text = [firstArr objectAtIndex:indexPath.row];
        cell.grayName.text = [secondArr objectAtIndex:indexPath.row];
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"Cell1";
        
        A1LevelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[A1LevelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        switch (selectRow) {
            case 0:{
                cell.nameLabel.text = [self.publishDateArr objectAtIndex:indexPath.row];
                break;}
            case 1:{
                cell.nameLabel.text = [self.workEXPArr objectAtIndex:indexPath.row];
                break;}
            case 2:{
                cell.nameLabel.text = [self.educationArr objectAtIndex:indexPath.row];
                break;}
            case 3:{
                cell.nameLabel.text = [self.comptypeArr objectAtIndex:indexPath.row];
                break;}
            case 4:{
                cell.nameLabel.text = [self.compsizeArr objectAtIndex:indexPath.row];
                break;}
            case 5:{
                cell.nameLabel.text = [self.salaryArr objectAtIndex:indexPath.row];
                break;}
            default:
                
                break;
        }
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self._tableView) {
        selectRow = indexPath.row;
        [self initNewTable];
    }
    else{
        
        self._tableView.userInteractionEnabled = YES;
        
        [self changeCenter];
        
        switch (selectRow) {
            case 0:{
                [self.secondArr replaceObjectAtIndex:0 withObject:[self.publishDateArr objectAtIndex:indexPath.row]];
                self.search.dataRefresh = 5;
                if ([[self.publishDateArr objectAtIndex:indexPath.row] isEqualToString:@"今天"]) {
                    self.search.dataRefresh = 1;
                } else if ([[self.publishDateArr objectAtIndex:indexPath.row] isEqualToString:@"最近三天"]){
                    self.search.dataRefresh = 3;
                } else if ([[self.publishDateArr objectAtIndex:indexPath.row] isEqualToString:@"最近一周"]){
                    self.search.dataRefresh = 7;
                } else if ([[self.publishDateArr objectAtIndex:indexPath.row] isEqualToString:@"最近一个月"]){
                    self.search.dataRefresh = 30;
                } else if ([[self.publishDateArr objectAtIndex:indexPath.row] isEqualToString:@"不限"]){
                    self.search.dataRefresh = 0;
                }
                
                [self._tableView reloadData];
                break;
            }
            case 1:{
                [self.secondArr replaceObjectAtIndex:1 withObject:[self.workEXPArr objectAtIndex:indexPath.row]];
                self.search.workingExp = [self.workEXPArr objectAtIndex:indexPath.row];
                [self._tableView reloadData];
                break;
            }
            case 2:{
                [self.secondArr replaceObjectAtIndex:2 withObject:[self.educationArr objectAtIndex:indexPath.row]];
                self.search.eduLevel = 2;
                [self._tableView reloadData];
                break;
            }
            case 3:{
                [self.secondArr replaceObjectAtIndex:3 withObject:[self.comptypeArr objectAtIndex:indexPath.row]];
                self.search.companyType = [self.comptypeArr objectAtIndex:indexPath.row];
                [self._tableView reloadData];
                break;
            }
            case 4:{
                [self.secondArr replaceObjectAtIndex:4 withObject:[self.compsizeArr objectAtIndex:indexPath.row]];
                self.search.companySize = [self.compsizeArr objectAtIndex:indexPath.row];
                [self._tableView reloadData];
                break;
            }
            case 5:{
                [self.secondArr replaceObjectAtIndex:5 withObject:[self.salaryArr objectAtIndex:indexPath.row]];
                self.search.salaryFrom = 1000;
                self.search.salaryTo = 1000000;
                [self._tableView reloadData];
                break;
            }
                
            default:
                break;
        }
        
        
        
    }
    
}

@end
