//
//  ShowTable.m
//  testTable
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1ShowTable.h"
#import "A1ShowJob.h"
#import "SearchJob.h"
#import "JobDetails.h"
#import "CollectJob.h"

#import <QuartzCore/QuartzCore.h>
#import "SearchSavedArgument.h"

@implementation A1ShowTable
@synthesize selectArr,pickArr,allJobArr,headV,searchjob,dataSourseSign,jobNumber,loadMoreLa,delegate,actionSheet;

@synthesize recordSearcherName;

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
    self.navigationItem.title = @"搜索结果";
    count=1;
    //数据初始化
    LoadingSign=NO;
    loadingMoreSign=NO;
    
    self.allJobArr =[[NSMutableArray alloc]initWithCapacity:20];
    self.pickArr=[NSArray arrayWithObjects:@"不限",@"500米",@"1000米",@"2000米",@"5000米", nil];
    
    UIView *ActView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    CGPoint po=self.view.center;
    po.y-=80;
    ActView.center=po;
    ActView.backgroundColor=[UIColor clearColor];
    ActView.tag=101;
    
    UIActivityIndicatorView *actInd=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    actInd.color=[UIColor grayColor];
    actInd.tag=102;
    actInd.frame=CGRectMake(32, 20, 37, 37);
    [actInd startAnimating];
    [ActView addSubview:actInd];
    UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(15, 65, 70, 21)];
    la.tag=103;
    la.backgroundColor=[UIColor clearColor];
    la.textColor=[UIColor grayColor];
    la.text=@"载入中...";
    [ActView addSubview:la];
    [self.view  addSubview:ActView];
    [ActView release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"搜索职位结果" object:nil];
    if (self.dataSourseSign==1)//快速搜索 
    {        
        [self.searchjob quickSearchWith:1 Pagesize:20];
    }
    if (self.dataSourseSign==2)//高级搜索
    {
        [self.searchjob advancedSearchWith:1 Pagesize:20];
    }
    if (self.dataSourseSign==3)//相似职位
    {
        [SearchJob alikeJob:self.jobNumber page:1 pageSize:20];
    }
    
    self.selectArr=[[NSMutableArray alloc]initWithCapacity:5];  
    self.navigationItem.title=@"搜索条件";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"申请" style:UIBarButtonItemStyleBordered target:self action:@selector(apply)];
    
    self.headV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //headV.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"locationbg"]];
    headV.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home.jpg"]];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeSearchDistance)];
    [headV addGestureRecognizer:tap];
     
    UILabel *laa=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 320, 20)];
    laa.text=@"当前搜索距离为：不限";
    laa.backgroundColor=[UIColor clearColor];
    laa.textColor=[UIColor whiteColor];
    laa.textAlignment=UITextAlignmentCenter;
    laa.tag=204;
    [headV addSubview:laa];
    [laa release];    

    [super viewDidLoad];
    
   
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(80,20,160, 44)];
    self.navigationItem.titleView=headerView;
    //headerView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_bg.png"]];
    headerView.backgroundColor = [UIColor clearColor];
    //在headerView上加Label
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 80, 24)];
    [lab setTextAlignment:UITextAlignmentCenter];
    [lab setBackgroundColor:[UIColor clearColor]];
    
    NSLog(@"schJobType=%@",self.searchjob.schJobType);
     NSLog(@"industry=%@",self.searchjob.industry);
     NSLog(@"city=%@",self.searchjob.city);
     NSLog(@"keyword=%@",self.searchjob.keyWord);
     NSLog(@"dataRefrsh=%d",self.searchjob.dataRefresh);
     NSLog(@"edulevel=%d",self.searchjob.eduLevel);
     NSLog(@"workingexp=%@",self.searchjob.workingExp);
     NSLog(@"companytype=%@",self.searchjob.companyType);
     NSLog(@"companysize=%@",self.searchjob.companySize);
     NSLog(@"salaryfrom=%d",self.searchjob.salaryFrom);
     NSLog(@"salaryto=%d",self.searchjob.salaryTo);
    
    [lab setText:[SearchSavedArgument SearchSavedWithSchJobType:self.searchjob.schJobType industry:self.searchjob.industry city:self.searchjob.city keyWord:self.searchjob.keyWord dataRefresh:self.searchjob.dataRefresh eduLevel:self.searchjob.eduLevel workingexp:self.searchjob.workingExp companytype:self.searchjob.companyType companysize:self.searchjob.companySize salaryfrom:self.searchjob.salaryFrom salaryto:self.searchjob.salaryTo]];
    [headerView addSubview:lab];
    //在headerView上加UIImageView
    img=[[UIImageView alloc]initWithFrame:CGRectMake(120, 10, 10, 10)];
    img.image=[UIImage imageNamed:@"nav_arrow_highlight.png"];
    [headerView addSubview:img];
    img.userInteractionEnabled=NO;
    //添加一个单击手势
    UITapGestureRecognizer *doATap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap)];
    [headerView addGestureRecognizer:doATap];
    [doATap release];
    
}
//UIalertviewdelegate协议中的方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        NSLog(@"放弃");
    }
    else
    {
        NSLog(@"跳转到登陆界面");
    }
}
//点击保存搜索器按钮触发的方法
-(void)savedSearcher
{
    //先判断是否登陆了 在判断保存器是否重名或是空
    self.recordSearcherName=searchNameTF.text;
    NSLog(@"%@",self.recordSearcherName);
    [searchNameTF resignFirstResponder];
    [viewShow removeFromSuperview];
    //如果已经登陆
    //开始登陆
    //如果输入为空的话
    //如果未登陆
    //
    //    UIAlertView *notLogIn=[[UIAlertView alloc]initWithTitle:@"" message:@"您尚未登陆，不能保存" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"登陆", nil];
    //    [notLogIn show];
    //    [notLogIn release];
    
    //这是在成功登陆时的
//    NSLog(@"self.searchjob=%@",self.searchjob.schJobType);
//    NSLog(@"self.industry=%@",self.searchjob.industry);
//    NSLog(@"self.city=%@",self.searchjob.city);
//    NSLog(@"self.workingexp=%@",self.searchjob.workingExp);
//    NSLog(@"self.companytype=%@",self.searchjob.companyType);
//    NSLog(@"self.companysize=%@",self.searchjob.companySize);
    NSString *ut=@"abDmpoxxMS0FLEVAfeRSx8Et5TFWlImHTpkLLXbvLfy+k8xzMngO9w==";
    [SearchSavedArgument SearchSavedWithUticket:ut schJobType:self.searchjob.schJobType industry:self.searchjob.industry city:self.searchjob.city keyWord:self.searchjob.keyWord dataRefresh:self.searchjob.dataRefresh eduLevel:self.searchjob.eduLevel workingexp:self.searchjob.workingExp companytype:self.searchjob.companyType companysize:self.searchjob.companySize salaryfrom:self.searchjob.salaryFrom salaryto:self.searchjob.salaryTo searchName:self.recordSearcherName];
}
//收回键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [searchNameTF resignFirstResponder];
    return YES;
}
//点击头视图的触发方法
-(void)doTap
{
    if([img.image isEqual:[UIImage imageNamed:@"nav_arrow_highlight.png"]])
    {
        NSLog(@"if");
        viewShow=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 140)];
        //viewShow.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"filterbg.png"]];
        viewShow.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home.jpg"]];
        //添加一个TextView
        textView=[[UITextView alloc]initWithFrame:CGRectMake(15, 40, 280, 60)];
        textView.backgroundColor=[UIColor clearColor];
        [textView setText:[SearchSavedArgument SearchSavedWithSchJobType:self.searchjob.schJobType industry:self.searchjob.industry city:self.searchjob.city keyWord:self.searchjob.keyWord dataRefresh:self.searchjob.dataRefresh eduLevel:self.searchjob.eduLevel workingexp:self.searchjob.workingExp companytype:self.searchjob.companyType companysize:self.searchjob.companySize salaryfrom:self.searchjob.salaryFrom salaryto:self.searchjob.salaryTo]];
        textView.userInteractionEnabled=NO;
        textView.font=[UIFont systemFontOfSize:14];
        [viewShow addSubview:textView];
        //添加一个label
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 80, 15)];
        [label1 setText:@"搜索条件"];
        [label1 setBackgroundColor:[UIColor clearColor]];
        [viewShow addSubview:label1];
        //添加一个输入框
        //输入搜索器用的
        searchNameTF=[[UITextField alloc]initWithFrame:CGRectMake(20, 110, 110, 30)];
//        searchNameTF.backgroundColor=[UIColor clearColor];
        searchNameTF.borderStyle=UITextBorderStyleRoundedRect;
        searchNameTF.textColor=[UIColor blueColor];
        [searchNameTF setFont:[UIFont systemFontOfSize:18]];
        searchNameTF.placeholder=@"搜索器名";
        searchNameTF.delegate=self;
        [viewShow addSubview:searchNameTF];
        
        //添加一个Button
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius=5;
        [btn setFrame:CGRectMake(140, 100, 170, 40)];
        [btn setBackgroundImage:[UIImage imageNamed:@"searchbtn.png"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:@"保存成职位搜索器" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(savedSearcher) forControlEvents:UIControlEventTouchUpInside];
        [viewShow addSubview:btn];
        img.image=[UIImage imageNamed:@"nav_arrow_normal.png"];
        //img.image = [UIImage imageNamed:@"Home.jpg"];
        [self.view addSubview:viewShow];
        [viewShow release];
    }
    else 
    {
        NSLog(@"else");
        img.image=[UIImage imageNamed:@"nav_arrow_highlight.png"];
        [viewShow removeFromSuperview];
    }
    
}

-(void)receive:(NSNotification *)not//通过通知接收初始数据
{
    
    UIView * view=[self.tableView.superview viewWithTag:101];
    UIActivityIndicatorView *act=(UIActivityIndicatorView *)[view viewWithTag:102];
    [act stopAnimating];
    [view removeFromSuperview];
    
    NSDictionary *dic=[not userInfo];
    NSMutableArray *arr=[dic objectForKey:@"arr"];
    if (arr.count==20) {
        loadingMoreSign=YES;
    }
    self.allJobArr=arr; 
    
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
    
    [self.tableView reloadData];
    
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
}


#pragma mark - 列表视图处理

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath//行高
{
    return 57;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section//分区表首高度
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section//设置分区表首
{
    
    return self.headV;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allJobArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    A1ShowTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[A1ShowTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        [cell.btn addTarget:self action:@selector(selectMore:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //判断是否已被选择
    cell.btn.tag=indexPath.row;
    selectedSign=NO;
    if (selectArr.count!=0) {
        for (NSNumber *thisRow in selectArr) {
            int a=[thisRow intValue];
            if (indexPath.row==a) {
                selectedSign=YES;
                cell.btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"se"]];
                break;
            }
        }
    }
    if (selectedSign==NO) {
        cell.btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"un_se"]]; 
    }
    A1Job *job=[self.allJobArr objectAtIndex:indexPath.row];
    cell.titleLa.text=job.jobTitle;
    cell.companyLa.text=job.companyName;
    cell.detaLa.text=job.openingDate;
    cell.addressLa.text=job.jobCity;
    return cell;
}





#pragma mark - 上拉加载更多

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
    count++;
    self.loadMoreLa.text=@"加载中...";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMore:) name:@"更多搜索职位结果" object:nil];
    if (self.dataSourseSign==1)//快速搜索 
    {
        [self.searchjob quickSearchWith:count Pagesize:20];
    }
    if (self.dataSourseSign==2)//高级搜索
    {
        
        [self.searchjob advancedSearchWith:count Pagesize:20];
    }
    if (self.dataSourseSign==3)//相似职位
    {
        [SearchJob alikeJob:self.jobNumber page:count pageSize:20];        
    }
    
    
    
}

-(void)receiveMore:(NSNotification *)not
{
    
    int row=self.allJobArr.count;
    NSDictionary *dic=[not userInfo];
    NSMutableArray * arr=[dic objectForKey:@"arr"];
    int nu=arr.count;
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
    
    [self.allJobArr addObjectsFromArray:arr];
    [self.tableView beginUpdates];
    NSMutableArray *rowArr=[[NSMutableArray alloc]initWithCapacity:20];
    for (NSUInteger i=row; i<row+nu; i++) {//将要操作的行的坐标存进数组
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:0];
		[rowArr addObject:indexPathToInsert];
	}
    [self.tableView insertRowsAtIndexPaths:rowArr withRowAnimation:UITableViewRowAnimationTop];    
    
    [self.tableView endUpdates];
    
    LoadingSign=NO;
}


#pragma mark - 点选table行

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    A1ShowJob *showJobVC=[[[A1ShowJob alloc]init]autorelease];
    showJobVC.job=[self.allJobArr objectAtIndex:indexPath.row];
    showJobVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:showJobVC animated:YES];
    //showJobVC.hidesBottomBarWhenPushed=NO;
}


#pragma mark - 批量选择点选时的操作

-(void)selectMore:(UIButton *)btn
{
    if (selectArr.count!=0) {
        for (NSNumber *thisRow in selectArr) {
            int a=[thisRow intValue];
            if (btn.tag==a) {
                [self.selectArr removeObject:thisRow];
                btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"un_se"]];
                return;
            }
        }
    }
    [self.selectArr addObject: [NSNumber numberWithInt:btn.tag]];
    btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"se"]];
}

-(void)apply//申请职位
{
    NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:10];
    for (NSNumber *n in self.selectArr) {
        int i=[n intValue];
        A1Job *job=[self.allJobArr objectAtIndex:i];
        [arr addObject:job.jobNumber];
    }
    ApplyProcess *aApply=[ApplyProcess Apply];
    self.delegate=aApply;
    if([arr count]==0)
    {
        UIAlertView *zView=[[UIAlertView alloc]initWithTitle:@"" message:@"您没有选择公司" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [zView show];
    }
    else if([arr count]==1)
    {
        NSLog(@"单个申请");
        [self.delegate singleApply:arr];//触发单个申请的方法
    }
    else
    {
        NSLog(@"批量申请");
        [self.delegate moreApply:arr];//触发批量申请的方法
    }
    
    
}

#pragma mark - 调整搜索距离

-(void)changeSearchDistance
{
    self.headV.userInteractionEnabled=NO;
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
                                              delegate:nil
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    [actionSheet addSubview:pickerView];
    [pickerView release];
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"完成"]];
    closeButton.momentary = YES; 
    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.backgroundColor = [UIColor clearColor];
    closeButton.tintColor = [UIColor blackColor];
    [closeButton addTarget:self action:@selector(doneChangeDistance) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:closeButton];
    [closeButton release];
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickArr.count ;     
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickArr objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    pickSelectNumber=row;
}
-(void)doneChangeDistance
{   
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    UILabel *laa=(UILabel *)[self.headV viewWithTag:204];
    laa.text=[NSString stringWithFormat:@"当前搜索距离为：%@",[self.pickArr objectAtIndex: pickSelectNumber]];
    self.headV.userInteractionEnabled=YES;
    if (![[self.pickArr objectAtIndex: pickSelectNumber]isEqual:@"不限"]) {
        int a=[[self.pickArr objectAtIndex:pickSelectNumber] intValue];
        self.searchjob.pointRanger=[NSString stringWithFormat:@"%d",a];
    }
    count=1;
    if (self.dataSourseSign==1)//快速搜索 
    {        
        [self.searchjob quickSearchWith:1 Pagesize:20];
    }
    if (self.dataSourseSign==2)//高级搜索
    {
        [self.searchjob advancedSearchWith:1 Pagesize:20];
    }
    if (self.dataSourseSign==3)//相似职位
    {
        [SearchJob alikeJob:self.jobNumber page:1 pageSize:20];
    }

    
    
}


@end
