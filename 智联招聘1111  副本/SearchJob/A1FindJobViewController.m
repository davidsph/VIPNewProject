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
#import "A1ShowTable.h"
#import "SearchJob.h"
#import "A1historyCell.h"
#import "PromptsView.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 20.0f

@implementation A1FindJobViewController
@synthesize contents,grayArr,advancedArr,textField_,allDataDic,locationManager,checkinLocation,databaseStr,historyArrList,historyArr,historyMark,flagToday,flagErlier,flagYesterday;


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

-(void)dealloc
{
    [super dealloc];
    
    [grayArr release];
    [advancedArr release];
    [historyArr release];
    [contents release];
    [pickerValues release];
    [textField_ release];
    [locationManager release];
    [checkinLocation release];
    [allDataDic release];
    [databaseStr release];
}

#pragma mark - 数据初始化

-(void)dataInit   //数据的初始化
{
    
    self.historyMark=NO;   //历史列表是否展开的标志
    self.allDataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil,@"1",nil,@"2",nil,@"3",nil,@"4",nil,@"5",nil,@"6",nil,@"7",nil,@"8",nil,@"9",nil,@"10",nil,@"11",nil,@"12",nil,@"13",nil,@"14",nil,@"15",nil,@"16",nil,@"17", nil]; //存放搜索的条件
    
    today = [[NSMutableArray alloc] init];
    yesterday = [[NSMutableArray alloc] init];
    earlier = [[NSMutableArray alloc] init];
    
    self.historyArr = [SearchJob findAllJobInDataBase]; //打开存放历史的数据库
    int count = self.historyArr.count;
    NSDate * nowDate = [NSDate date];
    for (int i = 0; i<count; i++)
    {
        SearchJob * ajob=[self.historyArr objectAtIndex:i];
        NSString * dateStr = ajob.date;
        
        //两个日期之间相隔多少秒
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:dateStr];
        
        NSTimeInterval secondsBetweenDates= [date timeIntervalSinceDate:nowDate];
        
        
        if (secondsBetweenDates >-24*60*60) {  // 添加到今天的历史数组里边
            [today addObject:ajob];
        }
        else if (secondsBetweenDates<-24*60*60 && secondsBetweenDates>-2*24*60*60)// 添加到昨天的历史数组里边
        {
            [yesterday addObject:ajob];
        }
        else if (secondsBetweenDates <-2*24*60*60) // 添加到更早的历史数组里边
        {
            [earlier addObject:ajob];
        }
    }
    
    history = [[NSMutableDictionary alloc] init];  // 加入到历史字典里边
    [history setObject:today forKey:@"今天"];
    [history setObject:yesterday forKey:@"昨天"];
    [history setObject:earlier forKey:@"更早"];
    
    
    self.historyArrList=[[NSMutableArray alloc]init];     
    self.grayArr=[[NSMutableArray alloc]initWithCapacity:5];
    
    
    self.advancedArr=[NSMutableArray arrayWithObjects:@"当前位置:",@"职位名称:",@"行业类别:",@"工作地点:",@"定位范围:", nil];
    self.grayArr=[NSMutableArray arrayWithObjects:@"点击刷新获取当前位置",@"请选择职位名称",@"请选择行业",@"请选择工作地点",@"不选择", nil];
    originQuickGrayArr = [[NSMutableArray alloc] initWithObjects:@"点击刷新获取当前位置",@"请选择职位名称",@"请选择行业",@"请选择工作地点",@"不选择", nil];    //存放原始数据
    //    [self.grayArr release];
    
}
-(void)location
{
    self.locationManager = [[CLLocationManager alloc] init];//创建位置管理器  
    locationManager.delegate=(id)self;  
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;  
    locationManager.distanceFilter=1000.0f;  
    //启动位置更新  
    [locationManager startUpdatingLocation];  
    
    
    //    MKReverseGeocoder * reverseGeocoder =[[MKReverseGeocoder alloc] initWithCoordinate:coordinate];  
    //    NSLog(@"%g",coordinate.latitude);  
    //    NSLog(@"%g",coordinate.longitude);  
    //    reverseGeocoder.delegate = self;  
    //    [reverseGeocoder start];  
}
  
#pragma mark - View lifecycle

-(void)setDefault  // 保存最后一次搜索的搜索条件记录
{
    textString = [[NSString alloc] init]; // 关键字字符串初始化
    if (self.historyArr.count == 0) {  // 如果没有历史记录，不做任何操作     
        return;
    }
    SearchJob *ajob=[self.historyArr objectAtIndex:self.historyArr.count-1];
    if (ajob.schJobType!=@"") {
        [self.grayArr replaceObjectAtIndex:1 withObject:ajob.schJobType];
        [self.allDataDic setObject:ajob.schJobType forKey:@"1"];
        [self.tableView reloadData];
    }
    if (ajob.industry!=@"") {
        [self.grayArr replaceObjectAtIndex:2 withObject:ajob.industry];
        [self.allDataDic setObject:ajob.industry forKey:@"2"];
        [self.tableView reloadData];
    }
    if (ajob.city!=@"") {
        [self.grayArr replaceObjectAtIndex:3 withObject:ajob.city];
        [self.allDataDic setObject:ajob.city forKey:@"3"];
        [self.tableView reloadData];
    }
    if (ajob.keyWord!=@"") {
        textString = ajob.keyWord;
        [self.allDataDic setObject:ajob.keyWord forKey:@"4"];
    }
}

-(void)backFirstView
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 44, 44);
    [btn setBackgroundImage:[UIImage imageNamed:@"返回首页"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backFirstView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:btn];  
    self.navigationItem.leftBarButtonItem=backBtn; 
    [backBtn release];
    
    self.flagErlier = NO;
    self.flagToday = NO;
    self.flagYesterday = NO;
    
    tempArr = [[NSMutableArray alloc] init];
    
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    
    self.navigationItem.title = @"职位搜索";
    self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"setting-button-click.png"];//button背景图片
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(0, 0, 55, 44);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"方形按钮"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.titleLabel.font=[UIFont fontWithName:@"ArialMT" size:14];
    [btn2 setTitle:@"清空" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(newSearch) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:btn2];  
    self.navigationItem.rightBarButtonItem=backBtn2;   
    [backBtn2 release];
    
    
    [self dataInit]; // 调用初始化数据的方法；
    //   [self location]; // 定位
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)]; //self.tableView的背景设置
    imageView.image = [UIImage imageNamed:@"纸纹"];
    [self.view addSubview:imageView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(2, 0, 316, 416) style:UITableViewStyleGrouped];
    self.tableView.backgroundView = imageView;    //设置tableView的背景图片

    
    [self setDefault];

    
    promptView =[[PromptsView alloc] initWithFrame:CGRectMake(60, 200, 200, 40)];
    [self.tableView addSubview:promptView];
    [promptView hidden];//先隐藏着，需要的时候再调出来
    
    [super viewDidLoad];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

#pragma mark - Table view delegate


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section //设置不同section的header的高度
{  
    if (section ==0)  
        return 80.0f;  // 第一分区高度设定为80.0f。
    else  
        return 90.0f;  
}  

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section  //设置不同section的Footer的高度
{  
    if (section ==0)  
        return 70.0f;  
    else  
        
        return 50.0f;  
} 

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section //设置不同section的header的view
{
    if (section == 0) {
        
        UIView * myView =[[[UIView alloc] init] autorelease]; // 整个headerView的superView；
        
        UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 320, 50)];
        view.image = [UIImage imageNamed:@"111.png"];  // @“设置搜索条件”的文字图片的设置;
        [myView addSubview:view];
        [view release];
        
        UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(3, 5, 314, 40)]; //关键字搜索的创建
        searchBar.delegate = self;  // UISearchDelegate代理
        searchBar.tag = 1;
        [[searchBar.subviews objectAtIndex:0]removeFromSuperview];
        searchBar.backgroundColor = [UIColor clearColor]; // 背景设置
        searchBar.barStyle = UIBarStyleDefault;  //barStyle设置
        [myView addSubview:searchBar];
        [searchBar release];
        
        UITextField * text = [[UITextField alloc] initWithFrame:CGRectMake(40, 15, 250, 30)]; //在searchBar上边贴一个UITextField，，UITextField的inputAccessoryView属性是可读写的，可以方便的设置它的键盘的UIToolbar。
        text.tag = 2; //设置teg值 ，，用于后边找到这个值，键盘回收
        text.placeholder = @"请输入关键字";
        if (textString != nil ) {
            text.text = textString;
        }
        
        UIToolbar * toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        toolbar.barStyle = UIBarStyleBlack;
        
        UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];   //空缺的区域，放在done按钮的左边部分
        UIBarButtonItem * doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(back)];  // done按钮的设置
        toolbar.items = [NSArray arrayWithObjects:spaceItem,doneItem, nil];
        
        text.inputAccessoryView = toolbar;  // UITextField变成第一响应者的时候，显示toolBar
        
        [myView addSubview:text];

        
        
        return myView;
    }
    else   //第二分区headerView的设置
    {
        UIView * myView =[[[UIView alloc] init] autorelease];
        
        UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        view.image = [UIImage imageNamed:@"222.png"];  // 设置“我的历史搜索图片”;
        [myView addSubview:view];
        
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 100, 40)];//设置label，显示历史记录的条数
        label.tag=2137;
        label.textColor = [UIColor colorWithRed:33/255 green:117/255 blue:218/255 alpha:1.0];
        label.font = [UIFont systemFontOfSize:15];
        label.backgroundColor = [UIColor clearColor];        
        int count = [self.historyArr count];  //历史记录数组的元素的个数
        NSString * str = [NSString stringWithFormat:@"(%d条)",count];        
        label.text = str; 
        [myView addSubview:label];
        
        
        UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(10, 50, 50, 30);
        button1.tag = 1000;
        [button1 setBackgroundColor:[UIColor clearColor]];
        [button1 setBackgroundImage:[UIImage imageNamed:@"今天2.png"] forState:UIControlStateNormal];
        [button1 setBackgroundImage:[UIImage imageNamed:@"今天.png"] forState:UIControlStateSelected];
        [button1 addTarget:self action:@selector(todayHistoryStretch) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:button1];
        
        UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(70, 50, 50, 30);
        button2.tag = 2000;
        [button2 setBackgroundImage:[UIImage imageNamed:@"昨天2.png"] forState:UIControlStateNormal];
        [button2 setBackgroundImage:[UIImage imageNamed:@"昨天.png"] forState:UIControlStateSelected];
        [button2 addTarget:self action:@selector(yesterdayHistoryStretch) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:button2];
        
        UIButton * button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        button3.frame = CGRectMake(130, 50, 50, 30);
        button3.tag = 3000;
        [button3 setBackgroundImage:[UIImage imageNamed:@"更早2.png"] forState:UIControlStateNormal];
        [button3 setBackgroundImage:[UIImage imageNamed:@"更早.png"] forState:UIControlStateSelected];
        [button3 addTarget:self action:@selector(earlierHistoryStretch) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:button3];
        
        UIButton * delButton = [UIButton buttonWithType:UIButtonTypeCustom]; //添加历史删除的按钮
        delButton.frame = CGRectMake(200, 47, 100, 30);       
        [delButton setBackgroundImage:[UIImage imageNamed:@"删除记录.png"] forState:UIControlStateNormal];        
        [delButton addTarget:self action:@selector(deleteHistory) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:delButton];

        
        return myView;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section //设置不同section的Footer的view
{
    if (section == 0) {
        
        UIView * myView =[[[UIView alloc] init] autorelease];
        
        UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 65, 320, 2)];//添加灰色分割线
        view.image = [UIImage imageNamed:@"grayline.png"];
        [myView addSubview:view];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom]; //添加查找按钮
        button.frame = CGRectMake(70, 15, 185, 42);        
        [button setTitle:@"查找" forState:UIControlStateNormal];       
        [button setBackgroundImage:[UIImage imageNamed:@"查找按钮"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:button];
        
        
        return myView;
    }
    else
    {
        UIView * myView =[[[UIView alloc] init] autorelease];
        
        UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 65, 320, 2)];
        view.image = [UIImage imageNamed:@"grayline.png"];//添加灰色分割线
        [myView addSubview:view];

        return myView;
    }
}


#pragma mark - 搜索方法集合

-(void)newSearch  // 点击重新输入按钮以后，对数据进行初始化恢复。
{    
    self.grayArr=[NSMutableArray arrayWithObjects:@"点击刷新获取当前位置",@"请选择职位名称",@"请选择行业",@"请选择工作地点",@"不选择", nil];
    self.allDataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil,@"1",nil,@"2",nil,@"3",nil,@"4",nil,@"5",nil,@"6",nil,@"7",nil,@"8",nil,@"9",nil,@"10",nil,@"11",nil,@"12",nil,@"13",nil,@"14",nil,@"15",nil,@"16",nil,@"17", nil];
    textString = @"";
    [self.tableView reloadData];
}

- (void) search 
{
    UITextField * text = (UITextField *)[self.tableView viewWithTag:2];  // 找到tag为2的UITextField
    if ( text.text !=nil ) {
        textString = text.text;
        [self.allDataDic setObject:text.text forKey:@"4"]; //把关键字加入数据库
    }
    
    NSDate * nowDate = [NSDate date];     // 获取当前时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * dateStr = [formatter stringFromDate:nowDate];
    
    [self.allDataDic setObject:dateStr forKey:@"13"];  // 当前点击时候的时间加入到数据库
    
    
    //************ 取出我们在didSelected方法中加入到历史字典中的数据，用于search的初始化。
    NSString * schJobType = [self.allDataDic objectForKey:@"1"]; 
    NSString * industry = [self.allDataDic objectForKey:@"2"];
    NSString * city = [self.allDataDic objectForKey:@"3"];
    NSString * keyword = [self.allDataDic objectForKey:@"4"];
    NSString * dataRefresh = [self.allDataDic objectForKey:@"5"];
    NSString * workingExp = [self.allDataDic objectForKey:@"6"];
    //NSString * eduLevel = [self.allDataDic objectForKey:@"7"];   /////////这个地方还没有加入
    NSString * companyType = [self.allDataDic objectForKey:@"8"];
    NSString * companySize = [self.allDataDic objectForKey:@"9"];
    NSString * salaryForm = [self.allDataDic objectForKey:@"10"];
    NSString * salaryTo = [self.allDataDic objectForKey:@"11"];    
    NSString * sort = [self.allDataDic objectForKey:@"16"];    
    NSString * pointRange= [self.allDataDic objectForKey:@"12"];
    NSString * date = [self.allDataDic objectForKey:@"13"];
    
    
    int dataTime = 5; //设置默认为5天，，在接口中发布时间为int类型，，在此处进行转换
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
    
    if (schJobType!=nil||industry!=nil||city!=nil) {
        [SearchJob addSearchJobINDataBaseofschJobType:schJobType industry:industry city:city keyWord:keyword dataRefresh:[NSString stringWithFormat:@"%d",dataTime] pointRanger:pointRange workingExp:workingExp companyType:companyType companySize:companySize salaryFrom:salaryForm salaryTo:salaryTo sort:sort date:date]; // 把搜索结果添加到历史数据库
        
    }
    int salForm = [salaryForm intValue]; // 对月薪范围进行int类型的转换
    int salTo = [salaryTo intValue];
    
    
    SearchJob * seachJob = [[SearchJob alloc] initWithType:1 schJobType:schJobType subJobType:005 industry:industry city:city keyWord:keyword dataRefresh:dataTime eduLevel:2 jobLocation:nil pointRanger:pointRange workingExp:workingExp companyType:companyType companySize:companySize emplType:nil salaryFrom:salForm salaryTo:salTo sort:sort date:date]; // 数据的初始化
    
    
    A1ShowTable *vc=[[A1ShowTable alloc]init]; // 点击搜索按钮以后要进去的页面
    vc.searchjob=seachJob; // 两个界面之间用代理进行传值
    vc.dataSourseSign=2;   // 搜索的标记位
    vc.hidesBottomBarWhenPushed=YES;  // 隐藏最下边的tabar的标记为
    [self.navigationController pushViewController:vc animated:YES]; // 推进到下一个页面

    
    
    if (self.historyMark) // 判断历史记录列表是否打开,,如果打开则关闭
    {
        [self todayHistoryStretch];   // 插入cell的方法
    }
    self.historyArr=[SearchJob findAllJobInDataBase];
    UILabel * alabel=(UILabel*)[self.tableView viewWithTag:2137];   // 每添加一次历史，历史的记录条数加1；
    alabel.text=[NSString stringWithFormat:@"(%d 条)",self.historyArr.count] ;
    [self dataInit];
    
    
}
-(void)yesterdayHistoryStretch
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button = (UIButton *)[self.tableView viewWithTag:2000];
    if (yesterday.count != 0) {
        button.selected = !button.selected;
    }    
    if (self.flagToday) {
        [self todayHistoryStretch]; // 判断再次之前，今天和更早的历史列表是否打开，如果打开则关闭
    }
    if (self.flagErlier) {
        [self earlierHistoryStretch];
    }
    if (yesterday.count == 0) {        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        promptView.backgroundColor = [UIColor blueColor];
        [promptView show:@"没有昨天的记录"];
        [promptView hidden];
        [UIView commitAnimations];
        return;
    }
    if (self.flagYesterday) 
    {
        [button setBackgroundImage:[UIImage imageNamed:@"昨天2.png"] forState:UIControlStateNormal];
        self.flagYesterday=NO;
    }
    else
    {
        [button setBackgroundImage:[UIImage imageNamed:@"昨天.png"] forState:UIControlStateNormal];
        flagYesterday = YES;// 当走到这一步的时候，设置为YES，表示次列表已打开
        tempArr = yesterday;
        flag = 1;// 历史搜索推进到职位列表的时候用做判断
    }
    [self historyStretch];
}
-(void)todayHistoryStretch
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button = (UIButton *)[self.tableView viewWithTag:1000];
    if (today.count != 0) {
        
        button.selected = !button.selected;
    }
    
    if (self.flagYesterday) {
        [self yesterdayHistoryStretch];
    }
    if (self.flagErlier) {
        [self earlierHistoryStretch];
    }
    if (today.count == 0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        promptView.backgroundColor = [UIColor blueColor];
        [promptView show:@"没有今天的记录"];
        [promptView hidden];
        [UIView commitAnimations];
        
        return;
    }
    if (self.flagToday) 
    {
        [button setBackgroundImage:[UIImage imageNamed:@"今天2.png"] forState:UIControlStateNormal];
        self.flagToday=NO;
    }
    else
    {
        [button setBackgroundImage:[UIImage imageNamed:@"今天.png"] forState:UIControlStateNormal];
        flagToday = YES;
        tempArr = today;
        flag = 2;
    }
    [self historyStretch];
    
}
-(void)earlierHistoryStretch
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button = (UIButton *)[self.tableView viewWithTag:3000];
    if (earlier.count != 0) {
        
        button.selected = !button.selected;
    }
    
    
    if (self.flagYesterday) {
        [self yesterdayHistoryStretch];
    }
    if (self.flagToday) {
        [self todayHistoryStretch];
    }
    if (earlier.count == 0) {
        [UIView beginAnimations:nil context:nil];
        // promptView.frame = CGRectMake(100, 400, 100, 50);
        [UIView setAnimationDuration:3];
        [promptView show:@"没有更早的记录"];
        promptView.backgroundColor = [UIColor blueColor];
        [promptView hidden];
        [UIView commitAnimations];
        
        return;
    }
    if (self.flagErlier) 
    {
        [button setBackgroundImage:[UIImage imageNamed:@"更早2.png"] forState:UIControlStateNormal];
        self.flagErlier=NO;
    }
    else
    {
        [button setBackgroundImage:[UIImage imageNamed:@"更早.png"] forState:UIControlStateNormal];
        self.flagErlier = YES;
        tempArr = earlier;
        flag = 3;
    }
    [self historyStretch];
}

-(void)historyStretch  // 插入cell的方法
{    
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
	for (NSUInteger i=0; i<tempArr.count; i++) {  //将要操作的行的坐标存进数组
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:1];  
		[rowToInsert addObject:indexPathToInsert];
	}
    [self.tableView beginUpdates];  // 开始加入或者删除cell
    if (self.historyMark) 
    {       
        UIImageView * viewsort = (UIImageView *)[self.tableView viewWithTag:3];
        viewsort.image = [UIImage imageNamed:@"shang.png"];  // 修改箭头方法
        self.historyMark=NO; // 所有标志位至为NO；
        self.flagYesterday = NO;
        self.flagToday = NO;
        self.flagErlier = NO;
        self.historyArrList=nil;
        [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationNone]; // 删除cell
        
    }
    else
    {
        UIImageView * viewsort = (UIImageView *)[self.tableView viewWithTag:3];
        viewsort.image = [UIImage imageNamed:@"xia.png"];
        self.historyArrList=[[NSMutableArray alloc]init];
        [self changeHistoryArrList];
        [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationNone]; // 增加cell
        
        self.historyMark=YES;
    }
    [self.tableView endUpdates]; // 添加或者删除结束
}
-(void)changeHistoryArrList  // 历史cell的显示内容
{
    for (int i=0; i<tempArr.count; i++)   
    {
        int count = [tempArr count];
        NSString * dataRefreshString = [[NSString alloc]init];
        SearchJob * ajob=[tempArr objectAtIndex:count-i-1];  // 对历史数据库进行倒叙查询
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
        
        
        NSMutableString *returnStr=[NSMutableString stringWithString:@""];   // 对数据库中的数据进行排列组合
        if(ajob.schJobType!=nil)
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"/ "];
            }
            [returnStr appendString:ajob.schJobType];
        }
        if(ajob.industry!=@"")
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"/ "];
            }        
            [returnStr appendString:ajob.industry];
        }
        if(ajob.city!=@"")
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"/ "];
            }
            [returnStr appendString:ajob.city];
        }
        if(ajob.keyWord!=@"")
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"/ "];
            }
            [returnStr appendString:ajob.keyWord];
        }
        if(ajob.dataRefresh!=0 && ajob.dataRefresh!=5)
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"/ "];
            }
            [returnStr appendFormat:@"%d",ajob.dataRefresh];
            
        }
        if(ajob.pointRanger!=@"")
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"/ "];
            }
            [returnStr appendString:ajob.pointRanger];
        }
        if(ajob.eduLevel!=0 && ajob.eduLevel!=2)
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"/ "];
                [returnStr appendFormat:@"%d",ajob.eduLevel];
                
            }
        }
        if(ajob.workingExp!=@"")
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"/ "];
            }
            [returnStr appendFormat:@"经验:%@",ajob.workingExp];
        }
        if(ajob.companyType!=@"")
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"/ "];
            }
            [returnStr appendString:ajob.companyType];
        }
        if(ajob.companySize!=@"")
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"/ "];
            }
            [returnStr appendFormat:@"%@",ajob.companySize];
        }
        if(ajob.salaryFrom!=0)
        {
            if(![returnStr isEqualToString:@""])
            {
                [returnStr appendString:@"/ "];
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
        [self.historyArrList addObject:returnStr];  //  每一条数据加入数组
    }
}
-(void)deleteHistory  // 删除历史记录 
{    
    if (self.flagErlier) {
        [self earlierHistoryStretch];
    }
    if (self.flagToday){
        [self todayHistoryStretch];
    }
    if (self.flagYesterday) {
        [self yesterdayHistoryStretch];
    }
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消删除" destructiveButtonTitle:@"确定删除" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
    sheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    
    [today removeAllObjects];
    [yesterday removeAllObjects];
    [earlier removeAllObjects];
}

#pragma mark - UIActionSheetDelegate 
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {  // 点击确定删除按钮的时候进行的操作
        if (self.historyMark) 
        {
            [self historyStretch];
        }
        
        [SearchJob deleteAllINDatabase];  // 调用数据库方法
        self.historyArr=[SearchJob findAllJobInDataBase];
        [self.tableView reloadData];
        UILabel * alabel=(UILabel*)[self.tableView viewWithTag:2137];
        alabel.text=[NSString stringWithFormat:@"%d 条",self.historyArr.count]; // 删除以后修改历史条数
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView  // self.tableView 分区个数的控制
{
    return 2;  //返回两个分区
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section // self.tableView 每一个分区的行数的控制
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  // cell的高度的设置
{
    if (indexPath.section ==0)//每个分区第0行都是100了。。
    {
        return 40;
    }
    else  // 动态控制cell的高度
    {
        
        NSMutableString * astring=[[NSMutableString alloc]init];
        astring=[self.historyArrList objectAtIndex:indexPath.row];
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f);//可接受的最大大小的字符串
        
        CGSize size = [astring sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap]; // 根据label中文字的字体号的大小和每一行的分割方式确定size的大小
        
        CGFloat height = MAX(size.height, 44.0f);
        
        return height;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath // 为cell赋值
{
    if (indexPath.section == 0)  // 对第1个分区cell赋值
    {
        NSString * str = [advancedArr objectAtIndex:indexPath.row];
        NSString * str1 = [self.grayArr objectAtIndex:indexPath.row];
        
        if (indexPath.row == 0) {
            static NSString *CellIdentifier2 = @"Cell2";   // 为每一行或者是每一类型的cell确定一个单独的CellIdentifier，防止在cell重用的时候出现重用混乱的现象
            A1FindJobViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            if (cell == nil) 
            {
                cell = [[[A1FindJobViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2] autorelease];
            }
            
            cell.imageView.frame = CGRectMake(270, 5, 25, 27);    // 为cell的不同属性进行赋值
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
            
            cell.imageView.frame = CGRectMake(275, 12, 15, 11);
            cell.imageView.image = [UIImage imageNamed:@"arrowDown.png"];
            
            if (str1 != @"不选择") {
                cell.grayName.textColor = [UIColor blackColor];
            } else{
                cell.grayName.textColor = [UIColor grayColor];
            }
            
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
            if (str1 !=[originQuickGrayArr objectAtIndex:indexPath.row]) // 判断是不是选择了搜索条件，如果选择了，标记颜色为黑色
            {
                cell.grayName.textColor = [UIColor blackColor];
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
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 10000.0f); // 动态控制cell的frame
        
        CGSize size = [astring sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];        
        
        
        cell1.firstLabel.text = astring;
        [cell1.firstLabel setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN-20, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];//确定firstLabel 的frame
        
        
        return cell1;
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath // cell选中以后今次那个的操作
{
    UITextField * text = (UITextField *)[self.tableView viewWithTag:2];  // 找到tag为2的UITextField
    if ( text.text !=nil ) {
        textString = text.text;
    }
    
    if(indexPath.section == 0)
    {
        
        if (indexPath.row == 4) {  //点击弹出PickerView 
            
            selectedRow = indexPath.row;
            
            self.contents =[NSArray arrayWithObjects:@"100米以内",@"500米以内",@"1000米以内",@"5000米以内", nil];
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:nil];
            actionSheet.tag = 10;
            [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
            
            CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
            
            UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
            pickerView.showsSelectionIndicator = YES;
            pickerView.dataSource = self;
            pickerView.delegate = self;
            
            [actionSheet addSubview:pickerView];
            [pickerView release];
            
            UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];  // 对pickerView进行自定义
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
        if (indexPath.row == 3 || indexPath.row == 1 || indexPath.row == 2) {    
            
            A1FirstLevelViewController * city = [[A1FirstLevelViewController alloc] init]; // 点击cell后推进到此页面
            
            city.string = [[[self.advancedArr objectAtIndex:indexPath.row] componentsSeparatedByString:@":"]objectAtIndex:0];
            selectedRow = indexPath.row; 
            
            city.selectRow = indexPath.row;  // 代理传值
            city.delegate = self;
            city.hidesBottomBarWhenPushed=YES;
            
            // blocks 传值
            [city setDataFromA1FirstLevelViewController:^(NSString *job) {
                NSLog(@"%@",job);
                [self.grayArr replaceObjectAtIndex:selectedRow withObject:job]; // 传值job细节
                [self.tableView reloadData];
                NSString * str = [NSString stringWithFormat:@"%d",selectedRow];
                [self.allDataDic setObject:job forKey:str];    //搜索条件保存到字典中
            }];
            
            
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
            
            NSLog(@"%s,%d",__FUNCTION__,__LINE__);
            
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
                     NSLog(@"%s,%d",__FUNCTION__,__LINE__);
                     [self.grayArr replaceObjectAtIndex:0 withObject:placemark.country];//修改cell数据
                     [self.tableView reloadData];
                 }
                 
             }];
        }
        
        
    }
    if (indexPath.section == 1) // 点击历史的cell触发
    {
        SearchJob * ajob = [[SearchJob alloc] init];    
        if (flag == 1) {   // 判断点击的是哪一个按钮
            ajob=[yesterday objectAtIndex:yesterday.count-indexPath.row-1];
        }
        if (flag == 2) {
            ajob=[today objectAtIndex:today.count-indexPath.row-1];
            
        }
        if (flag == 3) {
            ajob=[earlier objectAtIndex:earlier.count-indexPath.row-1];
            
        }
        
        A1ShowTable *vc=[[A1ShowTable alloc]init];
        vc.searchjob= ajob;
        vc.dataSourseSign=2;
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
}

#pragma mark -
#pragma mark A1FirstLevelViewController Protocol Methods 
-(void)A1FirstLevelViewController:(A1FirstLevelViewController *)controller didSelectTown:(NSString *)town
{
    [self.grayArr replaceObjectAtIndex:selectedRow withObject:town]; // 代理传值，传值town
    [self.tableView reloadData];
    
    NSString * str = [NSString stringWithFormat:@"%d",selectedRow];
    [self.allDataDic setObject:town forKey:str];//搜索条件保存到字典中
}
-(void)A1FirstLevelViewController:(A1FirstLevelViewController *)controller didSelectJob:(NSString *)job
{
//    [self.grayArr replaceObjectAtIndex:selectedRow withObject:job]; // 传值job细节
//    [self.tableView reloadData];
//    NSString * str = [NSString stringWithFormat:@"%d",selectedRow];
//    [self.allDataDic setObject:job forKey:str];    //搜索条件保存到字典中
}
-(void)A1FirstLevelViewController:(A1FirstLevelViewController *)controller didSelectItem:(NSString *)item
{
    
    [self.grayArr replaceObjectAtIndex:selectedRow withObject:item];
    [self.tableView reloadData];
    
    if (selectedRow >=5) {  // 设置key的值
        selectedRow ++;
    }
    
    NSString * str = [NSString stringWithFormat:@"%d",selectedRow];
    [self.allDataDic setObject:item forKey:str];   
}


#pragma mark -
#pragma mark UIPickerViewDataSource Protocol Methods 

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.contents.count ;   // pickerView  里边元素的个数
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.contents objectAtIndex:row]; // 返回特定某一行的内容
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (selectedRow == 4) {
        [self.grayArr replaceObjectAtIndex:selectedRow withObject:[self.contents objectAtIndex:row]];
        [self.allDataDic setObject:[self.contents objectAtIndex:row] forKey:@"12"];        
    }
    [self.tableView reloadData]; // 重新加载tabelView
}
-(void)done   // 点击pickerView上边定义的done按钮的时候触发
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];  // 移除视图
}

#pragma mark -
#pragma mark CLLocationManagerDelegate Protocol Methods
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{ 
    self.checkinLocation=newLocation;
}



#pragma mark - 键盘回收

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;    
}
-(void)back
{
    UITextField * textField = (UITextField *)[self.tableView viewWithTag:2];
    [textField resignFirstResponder];  //键盘回收
}
#pragma mark searchBar 代理
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchbar;
{
    //键盘消失
	[searchbar resignFirstResponder];
    [self search];	
}

@end