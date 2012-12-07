//
//  A1ShowOtherJob.m
//  SearchJob
//
//  Created by Ibokan on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1ShowOtherJob.h"
#import "A1ShowJob.h"

@implementation A1ShowOtherJob

@synthesize jd,allArr,loadMoreLa,dataSourceSign,cd;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
       
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.navigationItem.title=@"其他职位";
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 55, 44);
    [btn setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    [btn setTitle:@"详情" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont fontWithName:@"ArialMT" size:14];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:btn];  
    self.navigationItem.leftBarButtonItem=backBtn; 
    [backBtn release];

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

- (void)viewWillAppear:(BOOL)animated
{
    
    newCount=1;
    loadingMoreSign=NO;

    self.allArr=[[NSMutableArray alloc]init];
    if (dataSourceSign==1) {
        self.allArr=self.jd.otherJobList;
    }
    else if(dataSourceSign==2)
    {
        self.allArr=self.cd.otherJobList;
    }
    
    if (allArr.count==20) {
        loadingMoreSign=YES;
    }
    if (loadingMoreSign==YES) {
        
        UIView *footerV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        footerV.backgroundColor=[UIColor whiteColor];
        
        UIActivityIndicatorView *actInd=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        actInd.frame=CGRectMake(113, 5, 20, 20);
        actInd.tag=1002;
        [actInd startAnimating];
        [footerV addSubview:actInd];
        
        self.loadMoreLa=[[UILabel alloc]initWithFrame:CGRectMake(141, 5, 71, 20)];
        self.loadMoreLa.text=@"加载中...";
        self.loadMoreLa.backgroundColor=[UIColor clearColor];
        self.loadMoreLa.textAlignment=UITextAlignmentCenter;
        [footerV addSubview:self.loadMoreLa];
        [self.loadMoreLa release];
        
        self.tableView.tableFooterView=footerV;
        [footerV release];

    }

    
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    A1Job *job=[self.allArr objectAtIndex:indexPath.row];
    cell.textLabel.text=job.jobTitle;
    cell.textLabel.font=[UIFont fontWithName:@"ArialMT" size:16];
    cell.accessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"accessoryArrow"]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    A1Job *job=[self.allArr objectAtIndex:indexPath.row];
    A1ShowJob *showJobVC=[[[A1ShowJob alloc]init]autorelease];
    showJobVC.job=job;
    [self.navigationController pushViewController:showJobVC animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y >0) {
        //判断拖动距离 是否已经到达指定要求
        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
        if ((scrollPosition < 25)&&loadingMoreSign&&!LoadingSign)
        {
            [self loadMore];
        }
    }
    
}

-(void)loadMore
{
    LoadingSign=YES;
    newCount++;
    self.loadMoreLa.text=@"加载中...";
    
    if (dataSourceSign==1) {
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveMore:) name:@"更多职位详情" object:nil];
      [JobDetails GetJobDetailWithJobNumber:self.jd.jobNumber Page:newCount PageSize:20];
    }
    else if(dataSourceSign==2)
    {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveMore:) name:@"更多公司详情" object:nil];
        [CompanyDetail GetCompanyDetailWithCompanyNumber:self.cd.companyNumber Page:newCount PageSize:20]; 
    }
    
}

-(void)receiveMore:(NSNotification *)not
{
    
    int row=self.allArr.count;
    NSDictionary *dic=[not userInfo];
    int nu;
    if (dataSourceSign==1) {
        self.jd=[dic objectForKey:@"jd"];
        nu=self.jd.otherJobList.count;
        [self.allArr addObjectsFromArray:self.jd.otherJobList];
    }
    else if(dataSourceSign==2)
    {
        self.cd=[dic objectForKey:@"cd"];
        nu=self.cd.otherJobList.count;
        [self.allArr addObjectsFromArray:self.cd.otherJobList];
    }

    if (nu==20) {
        loadingMoreSign=YES;
    }
    else
    {
        loadingMoreSign=NO;
        self.loadMoreLa.text=@"";
        UIActivityIndicatorView *actv =(UIActivityIndicatorView *)[self.loadMoreLa.superview viewWithTag:1002];
        [actv stopAnimating];
    
    }
    
    
    [self.tableView beginUpdates];
    NSMutableArray *rowArr=[[NSMutableArray alloc]initWithCapacity:20];
    for (NSUInteger i=row; i<row+nu; i++) {//将要操作的行的坐标存进数组
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:0];
		[rowArr addObject:indexPathToInsert];
	}
    [self.tableView insertRowsAtIndexPaths:rowArr withRowAnimation:UITableViewRowAnimationTop];    
    
    [self.tableView endUpdates];
    
    LoadingSign=NO;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


















@end
