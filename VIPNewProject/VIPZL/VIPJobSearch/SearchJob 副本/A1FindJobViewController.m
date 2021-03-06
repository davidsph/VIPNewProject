//
//  Asvanced.m
//  xiangmu
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1FindJobViewController.h"
#import "A1FindJobViewCell.h"
#import "A1FirstLevelViewController.h"
#import "A1SecondLevelViewController.h"
#import "A1ShowTable.h"
#import "SearchJob.h"
#import "A1historyCell.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 20.0f

@implementation A1FindJobViewController
@synthesize contents,grayArr,advancedArr,textField_,allDataDic,locationManager,checkinLocation,databaseStr,historyArrList,historyArr,historyMark;

  //  static int selectTownIndex = 3;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)didReceiveMemoryWarning
//{
//    // Releases the view if it doesn't have a superview.
//    [super didReceiveeMemoryWarning];
//    
//    // Release any cached data, images, etc that aren't in use.
//}

-(void)dealloc
{
    [super dealloc];
        
    [grayArr release];
    [advancedArr release];
    [historyArr release];

    [pickerValues release];
}

#pragma mark - View lifecycle

-(void)dataInit   //数据的初始化
{
    
    self.historyMark=NO;   //历史列表是否展开的标志
    self.allDataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil,@"1",nil,@"2",nil,@"3",nil,@"4",nil,@"5",nil,@"6",nil,@"7",nil,@"8",nil,@"9",nil,@"10",nil,@"11",nil,@"12",nil,@"13",nil,@"14",nil,@"15",nil,@"16",nil,@"17", nil]; //存放搜索的条件
    
    self.historyArr = [SearchJob findAllJobInDataBase]; //打开存放历史的数据库
    
    self.historyArrList=[[NSMutableArray alloc]init]; 
    
    self.grayArr=[[NSMutableArray alloc]initWithCapacity:5];
       
       
    self.advancedArr=[NSMutableArray arrayWithObjects:@"当前位置:",@"职位名称:",@"行业类别:",@"工作地点:",@"定位范围:", nil];
    self.grayArr=[NSMutableArray arrayWithObjects:@"点击刷新获取当前位置",@"请选择职位名称",@"请选择行业",@"请选择工作地点",@"不选择", nil];
    originAdvancedGrayArr=[[NSMutableArray alloc] initWithObjects:@"点击刷新获取当前位置",@"请选择职位名称",@"请选择行业",@"请选择工作地点",@"请选择发布时间",@"请选择工作经验",@"请选择学历要求",@"请选择公司性质",@"请选择公司规模",@"不选择",@"不选择", nil];
    originQuickGrayArr = [[NSMutableArray alloc] initWithObjects:@"点击刷新获取当前位置",@"请选择职位名称",@"请选择行业",@"请选择工作地点",@"不选择", nil];    //存放原始数据
}

- (void)viewDidLoad
{
    
    self.navigationItem.title = @"快速搜索";
    self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"setting-button-click.png"];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"高级搜索" style:UIBarButtonItemStylePlain target:self action:@selector(highSearch)]; // 设置rightBarButtonItem  ，， 在此处调用highSearch方法，进行高级搜索和快速搜索的界面切换
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    } //设置navigationBar的背景图片
    
    
    [self dataInit]; // 调用初始化数据的方法；
    
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"centerBackground.png"]];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    imageView.image = [UIImage imageNamed:@"Home.jpg"];
    [self.view addSubview:imageView];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(2, 0, 316, 416) style:UITableViewStyleGrouped];
    self.tableView.backgroundView = imageView;    //设置tableView的背景图片
    
    [super viewDidLoad];

}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

}
-(void)highSearch  //  进行高级搜索和快速搜索的界面切换
{
    if (self.navigationItem.rightBarButtonItem.title==@"快速搜索") {

        self.navigationItem.title=@"快速搜索";
        self.navigationItem.rightBarButtonItem.title=@"高级搜索";
        
        [self.tableView beginUpdates];  // Begin a series of method calls that insert, delete
        NSIndexPath * path2 = [NSIndexPath indexPathForRow:5 inSection:0];
        [self.advancedArr  removeObject:@"工作经验"];   // 删除数组元素
 


        //[self.grayArr removeObjectAtIndex:5];

        NSIndexPath * path3 = [NSIndexPath indexPathForRow:6 inSection:0];
        [self.advancedArr  removeObject:@"学历要求"];
        //[self.grayArr removeObjectAtIndex:6];

        NSIndexPath * path4 = [NSIndexPath indexPathForRow:7 inSection:0];
        [self.advancedArr  removeObject:@"公司性质"];
        //[self.grayArr removeObjectAtIndex:7];

        NSIndexPath * path5 = [NSIndexPath indexPathForRow:8 inSection:0];
        [self.advancedArr  removeObject:@"公司规模"];
        //[self.grayArr removeObjectAtIndex:8];

        NSIndexPath * path6 = [NSIndexPath indexPathForRow:9 inSection:0];
        [self.advancedArr  removeObject:@"月薪范围"];
        //[self.grayArr removeObjectAtIndex:9];

        NSIndexPath * path7 = [NSIndexPath indexPathForRow:10 inSection:0];
        [self.advancedArr  removeObject:@"定位范围"];
        //[self.grayArr removeObjectAtIndex:10];

        [self.allDataDic removeObjectForKey:@"5"];
        [self.allDataDic removeObjectForKey:@"6"];
        [self.allDataDic removeObjectForKey:@"7"];
        [self.allDataDic removeObjectForKey:@"8"];
        [self.allDataDic removeObjectForKey:@"9"];
        [self.allDataDic removeObjectForKey:@"10"];
        [self.allDataDic removeObjectForKey:@"11"];
        
        NSMutableArray *arr1=[NSMutableArray arrayWithCapacity:5];
        for (int i=0 ;i<5;i++) {
        
            [arr1 addObject:[self.grayArr objectAtIndex:i]];
        }
        self.grayArr=arr1;
        
        
        [self.advancedArr replaceObjectAtIndex:4 withObject:@"定位范围"];
        [self.grayArr replaceObjectAtIndex:4 withObject:@"不选择"];
        
        NSMutableArray * arr = [[NSMutableArray alloc]init];
        [arr addObject:path2];
        [arr addObject:path3];
        [arr addObject:path4];
        [arr addObject:path5];
        [arr addObject:path6];
        [arr addObject:path7];
        
        [self.tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];

    }
    
    else
    {
        [self.advancedArr replaceObjectAtIndex:4 withObject:@"发布时间"];
        [self.grayArr replaceObjectAtIndex:4 withObject:@"请选择发布时间"];
        self.navigationItem.title=@"高级搜索";
        self.navigationItem.rightBarButtonItem.title=@"快速搜索";


        [self.tableView beginUpdates];
        [self.allDataDic removeObjectForKey:@"4"];

        
        NSIndexPath * path2 = [NSIndexPath indexPathForRow:5 inSection:0];
        [self.advancedArr  addObject:@"工作经验"];
        [self.grayArr addObject:@"请选择工作经验"];  //             
        NSIndexPath * path3 = [NSIndexPath indexPathForRow:6 inSection:0];
        [self.advancedArr  addObject:@"学历要求"];
        [self.grayArr addObject:@"请选择学历要求"];
        NSIndexPath * path4 = [NSIndexPath indexPathForRow:7 inSection:0];
        [self.advancedArr  addObject:@"公司性质"];
        [self.grayArr addObject:@"请选择公司性质"];
        NSIndexPath * path5 = [NSIndexPath indexPathForRow:8 inSection:0];
        [self.advancedArr  addObject:@"公司规模"];
        [self.grayArr addObject:@"请选择公司规模"];
        NSIndexPath * path6 = [NSIndexPath indexPathForRow:9 inSection:0];
        [self.advancedArr  addObject:@"月薪范围"];
        [self.grayArr addObject:@"不选择"];
        NSIndexPath * path7 = [NSIndexPath indexPathForRow:10 inSection:0];
        [self.advancedArr  addObject:@"定位范围"];
        [self.grayArr addObject:@"不选择"];
        
        
        NSMutableArray * arr = [[NSMutableArray alloc]init];
    
        [arr addObject:path2];
        [arr addObject:path3];
        [arr addObject:path4];
        [arr addObject:path5];
        [arr addObject:path6];
        [arr addObject:path7];
        
        [self.tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];

    }
    [textField_ removeFromSuperview];
    [self.tableView reloadData];
}


#pragma mark - Table view delegate
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (tableView == self.tableView) {
//        if (section == 0) {
//            return @"选择职位搜索条件";
//        }
//        else if (section == 1 )
//        {
//            return @"我的历史搜索";
//        }
//    }
//    else
//    {
//        return nil;
//    }
//    return nil;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  
{  
    if (section ==0)  
        return 80.0f;  
    else  
        return 50.0f;  
}  

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
 
        UIView * myView =[[[UIView alloc] init] autorelease];
        UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 320, 50)];
        view.image = [UIImage imageNamed:@"111.png"];
        [myView addSubview:view];
        
        
        searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(3, 5, 314, 40)];
        searchBar.placeholder = @"请输入关键字";
        searchBar.delegate = self;
        searchBar.backgroundColor = [UIColor clearColor];
        [[searchBar.subviews objectAtIndex:0]removeFromSuperview];
        searchBar.barStyle = UIBarStyleDefault;
        [myView addSubview:searchBar];
        
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
        return myView;
    }
    else
    {
        UIView * myView =[[[UIView alloc] init] autorelease];
        
        UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        view.image = [UIImage imageNamed:@"222.png"];
        [myView addSubview:view];
        
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(245, 12, 100, 40)];
        label.tag=2137;
        label.backgroundColor = [UIColor clearColor];        
        int count = [self.historyArr count]; 
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(historyStretch)];
        [myView addGestureRecognizer:tap]; 
        
        NSString * str = [NSString stringWithFormat:@"%d条",count];        
        label.text = str; 
        [myView addSubview:label];
        
        viewsort = [[UIImageView alloc] initWithFrame:CGRectMake(280, 19, 24, 24)];
        
   
        viewsort.image = [UIImage imageNamed:@"shang.png"];

        [myView addSubview:viewsort];

        
        
        return myView;

         return nil;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section 
{
    if (section == 0) {
        
        UIView * myView =[[[UIView alloc] init] autorelease];
        
        UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 65, 320, 2)];
        view.image = [UIImage imageNamed:@"grayline.png"];
        [myView addSubview:view];
        
        
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(70, 15, 185, 42);
    
        [button setTitle:@"查找" forState:UIControlStateNormal];       
        [button setBackgroundImage:[UIImage imageNamed:@"button_bg_normal.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:button];
        
        return myView;
    }
    else
    {
        UIView * myView =[[[UIView alloc] init] autorelease];
        
        UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 65, 320, 2)];
        view.image = [UIImage imageNamed:@"grayline.png"];
        [myView addSubview:view];
        
        
        
        delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        delButton.frame = CGRectMake(260, 10, 50, 50);
        
        [delButton setBackgroundImage:[UIImage imageNamed:@"delnew.png"] forState:UIControlStateNormal];
        
        [delButton addTarget:self action:@selector(deleteHistory) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:delButton];

        
        return myView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{  
    if (section ==0)  
        return 70.0f;  
    else  
        
        return 50.0f;  
}  


- (void) search
{
    if ( searchBar.text !=nil ) {
        [self.allDataDic setObject:searchBar.text forKey:@"4"]; //把关键字加入数据库
    }
    
//    NSLog(@"%@",self.allDataDic);
    
//    [delButton setBackgroundImage:[UIImage imageNamed:@"delnew.png"] forState:UIControlStateNormal];
     
    NSString * schJobType = [self.allDataDic objectForKey:@"1"];
    NSString * industry = [self.allDataDic objectForKey:@"2"];
    NSString * city = [self.allDataDic objectForKey:@"3"];
    NSString * keyword = [self.allDataDic objectForKey:@"4"];
    NSString * dataRefresh = [self.allDataDic objectForKey:@"5"];
    NSString * workingExp = [self.allDataDic objectForKey:@"6"];
 //   NSString * eduLevel = [self.allDataDic objectForKey:@"7"];   /////////这个地方还没有加入
    NSString * companyType = [self.allDataDic objectForKey:@"8"];
    NSString * companySize = [self.allDataDic objectForKey:@"9"];
    NSString * salaryForm = [self.allDataDic objectForKey:@"10"];
    NSString * salaryTo = [self.allDataDic objectForKey:@"11"];
    
    NSString * sort = [self.allDataDic objectForKey:@"16"];
    
    NSString * pointRange;
    if ([self.navigationItem.title isEqualToString:@"快速搜索"]) {
        pointRange = [self.allDataDic objectForKey:@"5"];
    }
    else
    {
         pointRange = [self.allDataDic objectForKey:@"12"];
    }
    
    
    
    int dataTime = 5;
    if ([dataRefresh isEqualToString:@"今天"]) {
        dataTime = 1;
    } else if ([dataRefresh isEqualToString:@"最近三天"]){
        dataTime = 3;
    } else if ([dataRefresh isEqualToString:@"最近一周"]){
        dataTime = 7;
    } else if ([dataRefresh isEqualToString:@"最近一个月"]){
        dataTime = 30;
    } else if ([dataRefresh isEqualToString:@"不限"]){
        dataTime = 0;
    }
    
    [SearchJob addSearchJobINDataBaseofschJobType:schJobType industry:industry city:city keyWord:keyword dataRefresh:[NSString stringWithFormat:@"%d",dataTime] pointRanger:pointRange workingExp:workingExp companyType:companyType companySize:companySize salaryFrom:salaryForm salaryTo:salaryTo sort:sort];
    int salForm = [salaryForm intValue];
    int salTo = [salaryTo intValue];
    
    A1ShowTable *vc=[[A1ShowTable alloc]init];
    if ([self.navigationItem.title isEqualToString:@"快速搜索"]) {

        SearchJob * seachJob = [[SearchJob alloc] initWithschJobType:schJobType industry:industry city:city keyWord:keyword pointRanger:pointRange sort:sort ];
        vc.searchjob=seachJob;
        vc.dataSourseSign=2;
        
    }
    else
    {
        SearchJob * seachJob = [[SearchJob alloc] initWithType:1 schJobType:schJobType subJobType:005 industry:industry city:city keyWord:keyword dataRefresh:dataTime eduLevel:2 jobLocation:nil pointRanger:pointRange workingExp:workingExp companyType:companyType companySize:companySize emplType:nil salaryFrom:salForm salaryTo:salTo sort:sort];
        
        
        vc.searchjob=seachJob;
        vc.dataSourseSign=2;
    }
    
    
    vc.hidesBottomBarWhenPushed=YES;
    
    if (self.historyMark) 
    {
        [self historyStretch];
    }
    self.historyArr=[SearchJob findAllJobInDataBase];
    UILabel * alabel=(UILabel*)[self.tableView viewWithTag:2137];
    alabel.text=[NSString stringWithFormat:@"%d 条",self.historyArr.count] ;
    
    [self.navigationController pushViewController:vc animated:YES];
    //vc.hidesBottomBarWhenPushed=NO;
    
}
-(void)historyStretch
{
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
	for (NSUInteger i=0; i<self.historyArr.count; i++) {//将要操作的行的坐标存进数组
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:1];
		[rowToInsert addObject:indexPathToInsert];
	}
    [self.tableView beginUpdates];
    if (self.historyMark) 
    {

        viewsort.image = [UIImage imageNamed:@"shang.png"];

    
        self.historyMark=NO;
        self.historyArrList=nil;

        [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationNone];
        
    }
    else
    {
    
        viewsort.image = [UIImage imageNamed:@"xia.png"];
        
        viewsort.image = [UIImage imageNamed:@"xia.png"];

        self.historyArrList=[[NSMutableArray alloc]init];
        [self changeHistoryArrList];
        [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationNone];
        
        self.historyMark=YES;
    }
    [self.tableView endUpdates];
}
-(void)changeHistoryArrList
{
    for (int i=0; i<historyArr.count; i++) {
        int count = [self.historyArr count];
        NSString * dataRefreshString = [[NSString alloc]init];
        SearchJob * ajob=[self.historyArr objectAtIndex:count-i-1];
        if (ajob.dataRefresh==1) {
            dataRefreshString=@"今天";
        }else if(ajob.dataRefresh==3) {
            dataRefreshString=@"最近三天";
        }else if(ajob.dataRefresh==7) {
            dataRefreshString=@"最近一周";
        } else if(ajob.dataRefresh==30) {
            dataRefreshString=@"最近一个月";
        } else if(ajob.dataRefresh==0) {
            dataRefreshString=@"";
        }
        
        
        NSMutableString *returnStr=[NSMutableString stringWithString:@""];
        if(ajob.schJobType!=nil)
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"+"];
            }
            [returnStr appendString:ajob.schJobType];
        }
        if(ajob.industry!=@"")
        {
            NSLog(@"%s,%d",__FUNCTION__,__LINE__);
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"+"];
            }        
            [returnStr appendString:ajob.industry];
        }
        if(ajob.city!=@"")
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"+"];
            }
            [returnStr appendString:ajob.city];
        }
        if(ajob.keyWord!=@"")
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"+"];
            }
            [returnStr appendString:ajob.keyWord];
        }
        if(ajob.dataRefresh!=0 && ajob.dataRefresh!=5)
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"+"];
            }
            [returnStr appendFormat:@"%d",ajob.dataRefresh];

        }
        if(ajob.pointRanger!=@"")
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"+"];
            }
            [returnStr appendString:ajob.pointRanger];
        }
        if(ajob.eduLevel!=0 && ajob.eduLevel!=2)
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"+"];
                [returnStr appendFormat:@"%d",ajob.eduLevel];

            }
        }
        if(ajob.workingExp!=@"")
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"+"];
            }
            [returnStr appendFormat:@"经验:%@",ajob.workingExp];
        }
        if(ajob.companyType!=@"")
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"+"];
            }
            [returnStr appendString:ajob.companyType];
        }
        if(ajob.companySize!=@"")
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"+"];
            }
            [returnStr appendFormat:@"%@",ajob.companySize];
        }
        if(ajob.salaryFrom!=0)
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"+"];
            }
            [returnStr appendFormat:@"%d",ajob.salaryFrom];
            
            if(ajob.salaryTo!=0)
            {
                [returnStr appendFormat:@"%d",ajob.salaryTo   ];
            }
        }
        else
        {
            if(ajob.salaryTo!=0)
            {
                [returnStr appendFormat:@"%d",ajob.salaryTo  ];
            }
        }
        
        [self.historyArrList addObject:returnStr];
    }
}
-(void)deleteHistory
{    
    sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消删除" destructiveButtonTitle:@"确定删除" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
    sheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [sheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (self.historyMark) 
        {
            [self historyStretch];
        }
        
        [SearchJob deleteAllINDatabase];
        self.historyArr=[SearchJob findAllJobInDataBase];
        [self.tableView reloadData];
        UILabel * alabel=(UILabel*)[self.tableView viewWithTag:2137];
        alabel.text=[NSString stringWithFormat:@"%d 条",self.historyArr.count];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [advancedArr count];
    }
    else if (section ==1)
    {
        return self.historyArrList.count;
    }
   return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)//每个分区第0行都是100了。。
    {
        return 40;
    }
    else
    {
        
        NSMutableString * astring=[[NSMutableString alloc]init];
        astring=[self.historyArrList objectAtIndex:indexPath.row];
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f);//可接受的最大大小的字符串
        
        CGSize size = [astring sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat height = MAX(size.height, 44.0f);
    
        return height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        NSString * str = [advancedArr objectAtIndex:indexPath.row];
        NSString * str1 = [self.grayArr objectAtIndex:indexPath.row];
                
        if (indexPath.row == 0) {
            static NSString *CellIdentifier2 = @"Cell2";
            A1FindJobViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            if (cell == nil) 
            {
                cell = [[[A1FindJobViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2] autorelease];
            }
            
            cell.imageView.frame = CGRectMake(270, 5, 25, 27);
            cell.imageView.image = [UIImage imageNamed:@"queryFlag.png"];
            cell.advancedName.text = str;
            cell.grayName.text = str1;
            
            return cell;
        }
        if (indexPath.row == 4) {
            static NSString *CellIdentifier3 = @"Cell3";
            A1FindJobViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
            if (cell == nil) 
            {
                cell = [[[A1FindJobViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3] autorelease];
            }
            cell.imageView.frame = CGRectMake(280, 12, 10, 14);
            cell.imageView.image = [UIImage imageNamed:@"accessoryArrow.png"];
            if ([self.navigationItem.title isEqualToString:@"快速搜索"]) {
                cell.imageView.frame = CGRectMake(275, 12, 15, 11);
                cell.imageView.image = [UIImage imageNamed:@"arrowDown.png"];
                
            }
            
            cell.advancedName.text = str;
            cell.grayName.text = str1;
            
            return cell;
            
        }
        if (indexPath.row == 9 || indexPath.row == 10) 
        {
            static NSString *CellIdentifier4 = @"Cell4";
            A1FindJobViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
            if (cell == nil) 
            {
                cell = [[[A1FindJobViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier4] autorelease];
            }
            cell.imageView.frame = CGRectMake(275, 12, 15, 11);
            cell.imageView.image = [UIImage imageNamed:@"arrowDown.png"];
            
            cell.advancedName.text = str;
            cell.grayName.text = str1;
            
            return cell;
        }
        
        else
        {
            static NSString *CellIdentifier5 = @"Cell5";
            A1FindJobViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier5];
            if (cell == nil) 
            {
                cell = [[[A1FindJobViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier5] autorelease];
            }
            cell.advancedName.text = str;
            
            cell.grayName.textColor = [UIColor grayColor];
            cell.grayName.text = str1;
            if ([self.navigationItem.title isEqualToString:@"快速搜索"]) {
                if (str1 !=[originQuickGrayArr objectAtIndex:indexPath.row]) {
                    cell.grayName.textColor = [UIColor blackColor];
                }
            }
            else  if ([self.navigationItem.title isEqualToString:@"高级搜索"]) 
            {
                if (str1!=[originAdvancedGrayArr objectAtIndex:indexPath.row])
                {
                    cell.grayName.textColor=[UIColor blackColor];
                }
                
            }
            return cell;
            
            
        }
        return 0;
    }
    
    else //对历史列表进行分析
    {
        static NSString *CellIdentifier = @"Cell6";
        A1historyCell *  cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell1 == nil) {
            cell1 = [[[A1historyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        NSMutableString * astring=[[NSMutableString alloc]init];
        astring=[self.historyArrList objectAtIndex:indexPath.row];
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f);
        
        CGSize size = [astring sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];        
        
        
        cell1.firstLabel.text = astring;
        [cell1.firstLabel setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN-20, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];//确定firstLabel 的frame
            
        return cell1;
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
      
        if (indexPath.row == 9 || indexPath.row == 10 || (indexPath.row == 4 && [self.navigationItem.title isEqualToString:@"快速搜索"])) {  //点击弹出PickerView 
            
            selectedRow = indexPath.row;
            
            if (indexPath.row == 9) {
                self.contents =[NSArray arrayWithObjects:@"2000~3000元",@"3000~5000元",@"5000~8000元", nil];
            }
            else if (indexPath.row == 10 || (indexPath.row == 4 && [self.navigationItem.title isEqualToString:@"快速搜索"])){
                self.contents =[NSArray arrayWithObjects:@"500米",@"1000米",@"2000米",@"5000米", nil];
            }
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
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
            
            UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
            closeButton.momentary = YES; 
            [closeButton setTitle:@"完成" forSegmentAtIndex:0];
            closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
            closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
            closeButton.tintColor = [UIColor blackColor];
            [closeButton addTarget:self action:@selector(done) forControlEvents:UIControlEventValueChanged];
            [actionSheet addSubview:closeButton];
            [closeButton release];
            
            [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
            
            [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
            
        }
        if (indexPath.row == 3 || indexPath.row == 1 || indexPath.row == 2 || (indexPath.row == 4 && [self.navigationItem.title isEqualToString:@"高级搜索"])|| indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8) {    
            
            
            A1FirstLevelViewController * city = [[A1FirstLevelViewController alloc] init];
            
            
            city.string = [[[self.advancedArr objectAtIndex:indexPath.row] componentsSeparatedByString:@":"]objectAtIndex:0];
            selectedRow = indexPath.row;
            
            city.selectRow = indexPath.row;
            
            city.delegate = self;
            city.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:city animated:YES];
           // city.hidesBottomBarWhenPushed=NO;
        }
        if (indexPath.row==0) 
        {
            self.locationManager = [[[CLLocationManager alloc] init] autorelease]; 
            if ([CLLocationManager locationServicesEnabled]) { 
                //NSLog( @"Starting CLLocationManager" ); 
                self.locationManager.delegate =(id)self; 
                self.locationManager.distanceFilter = 200; 
                locationManager.desiredAccuracy = kCLLocationAccuracyBest; 
                [self.locationManager startUpdatingLocation]; 
            } else { 
                //NSLog( @"Cannot Starting CLLocationManager" ); 
                /*self.locationManager.delegate = self; 
                 self.locationManager.distanceFilter = 200; 
                 locationManager.desiredAccuracy = kCLLocationAccuracyBest; 
                 [self.locationManager startUpdatingLocation];*/ 
            } 
            
            CLGeocoder * geocoder=[[CLGeocoder alloc]init];
            [geocoder reverseGeocodeLocation:self.checkinLocation completionHandler:
             
             ^(NSArray* placemarks, NSError* error){
                 
                 if (placemarks.count > 0) 
                 { 
                     CLPlacemark *placemark = [placemarks objectAtIndex:0]; 
                    /* NSString *country = placemark.ISOcountryCode; 
                     NSString *country2=placemark.country;
                     NSString *city = placemark.locality;
                     NSLog(@"%@    %@    %@",country,city,country2); */
                     [self.grayArr replaceObjectAtIndex:0 withObject:placemark.country];//修改cell数据
                     [self.tableView reloadData];
                 }
                 
             }];
        }
        
        
    }
    if (indexPath.section == 1)
    {
        
        NSMutableArray * historyInDatabase=[SearchJob findAllJobInDataBase];
        int count = [historyInDatabase count];
        SearchJob * ajob=[historyInDatabase objectAtIndex:count-indexPath.row-1];
        A1ShowTable *vc=[[A1ShowTable alloc]init];
        vc.searchjob=ajob;
        vc.dataSourseSign=2;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - A1SecondLevelViewControllerDelegate

-(void)A1SecondLevelViewController:(A1SecondLevelViewController *)controller didSelectTown:(NSString *)town
{
    [self.grayArr replaceObjectAtIndex:selectedRow withObject:town];
    [self.tableView reloadData];
    
    
    NSString * str = [NSString stringWithFormat:@"%d",selectedRow];
    [self.allDataDic setObject:town forKey:str];//搜索条件保存到字典中
}

-(void)A1SecondLevelViewController:(A1SecondLevelViewController *)controller didSelectJob:(NSString *)job
{
    [self.grayArr replaceObjectAtIndex:selectedRow withObject:job];
    [self.tableView reloadData];
    NSString * str = [NSString stringWithFormat:@"%d",selectedRow];
    [self.allDataDic setObject:job forKey:str];    
}

#pragma mark -
#pragma mark A1FirstLevelViewController Protocol Methods 

-(void)A1FirstLevelViewController:(A1FirstLevelViewController *)controller didSelectItem:(NSString *)item
{
    
    [self.grayArr replaceObjectAtIndex:selectedRow withObject:item];
    [self.tableView reloadData];
    
    
    if (selectedRow >=5) {
        selectedRow ++;
    }
    
    
    NSString * str = [NSString stringWithFormat:@"%d",selectedRow];
    [self.allDataDic setObject:item forKey:str];   
}


#pragma mark -
#pragma mark UIPickerViewDataSource Protocol Methods 
//@required

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.contents.count ;     
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.contents objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (selectedRow == 9) {
        
        NSArray *listItems = [[self.contents objectAtIndex:row] componentsSeparatedByString:@"~"];
        
        NSString * first=[listItems objectAtIndex:0];
        NSString * sencond = [[listItems objectAtIndex:1] substringWithRange:NSMakeRange(0, 4)];
        
        NSString * str = [NSString stringWithFormat:@"%d",selectedRow];
        [self.allDataDic setObject:first forKey:str];
        NSString * str1 = [NSString stringWithFormat:@"%d",selectedRow+1];
        [self.allDataDic setObject:sencond forKey:str1];

        
        [grayArr replaceObjectAtIndex:9 withObject:[self.contents objectAtIndex:row]];
    }
    else  if (selectedRow == 10 || (selectedRow == 4 && [self.navigationItem.title isEqualToString:@"快速搜索"])) {
    
        NSString * str = [NSString stringWithFormat:@"%d",selectedRow];
        [self.allDataDic setObject:[self.contents objectAtIndex:row] forKey:str];
        
        if ([self.navigationItem.title isEqualToString:@"快速搜索"]) {
             [grayArr replaceObjectAtIndex:4 withObject:[self.contents objectAtIndex:row]];
        }
        else{
        [grayArr replaceObjectAtIndex:10 withObject:[self.contents objectAtIndex:row]];
        }
    }
    [self.tableView reloadData];
}
-(void)done
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];

}

#pragma mark -
#pragma mark CLLocationManagerDelegate Protocol Methods
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    self.checkinLocation=newLocation;
//    NSLog(@"%@",self.checkinLocation);
}

#pragma mark - 键盘回收

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;    
}
#pragma mark searchBar 代理
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchbar;
{
    //键盘消失
	[searchbar resignFirstResponder];
    [self search];
	
}

-(void)dismissKeyBorad
{
    [searchBar resignFirstResponder];
}
@end
