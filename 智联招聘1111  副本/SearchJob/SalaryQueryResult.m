//
//  ABC.m
//  SalarySearch
//
//  Created by Ibokan on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SalaryQueryResult.h"
#import "DrawView.h"
#import "SalaryQueryHome.h"
#import "QueryConditions.h"

@implementation SalaryQueryResult

@synthesize exper;

@synthesize tableView;

@synthesize queryResultArray,compareResultArray;
@synthesize city,industry,corproperty,jobcat,joblevel,education,salary;
@synthesize cityID,industryID,corpropertyID,jobcatID,joblevelID,educationID;
@synthesize queryString,compareQueryString,compareQueryStringID;

@synthesize compareResultData ;

- (void)dealloc {
    
    [self.tableView release];
    
    [self.salary release];

    [activityView release];
    
    [self.city release];
    [self.industry release];
    [self.corproperty release];
    [self.joblevel release];
    [self.jobcat release];
    [self.education release];
    
    [self.cityID release];
    [self.industryID release];
    [self.corpropertyID release];
    [self.joblevelID release];
    [self.jobcatID release];
    [self.educationID release];
    
    [self.compareResultData release];
   
    [self.compareResultArray release];
    
    [promptView release];
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"%s %d",__FUNCTION__,__LINE__);
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
-(void)loadView
{
    NSLog(@"%s %d",__FUNCTION__,__LINE__);
    self.title =@"薪酬查询结果";
    
    self.view =[[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)]autorelease];
    
    //初始化tableview的大小
    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    
    promptView =[[PromptsView alloc] initWithFrame:CGRectMake(60, 300, 200, 40)];
    [self.tableView addSubview:promptView];
    [promptView hidden];
    
    activityView  =[[ActivityView  alloc] initWithFrame:self.view.frame];
    [self.view addSubview:activityView];//addsubview
    [activityView hidden];//暂时隐藏 ，需要时再把它显示出来
    
}

- (void)viewDidLoad
{
    NSLog(@"%s %d",__FUNCTION__,__LINE__);
    [super viewDidLoad];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame =  CGRectMake(0, 0, 44, 34);
    backButton.titleLabel.font =[UIFont systemFontOfSize:15.0];

    backButton.backgroundColor = [UIColor clearColor];
    backButton.titleLabel.adjustsFontSizeToFitWidth =YES;
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"返回按钮.png"] forState:UIControlStateNormal];
    
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
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       
    if (indexPath.row==1) {
        return 180;
    }
    if (indexPath.row==3) 
            return 120;
    
    return 33;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableVi cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *CellIdentifier =[NSString stringWithFormat:@"Row%d",indexPath.row];
    
    UITableViewCell *cell = [tableVi dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }else{
        return cell;
    }
   
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text =@"此类职位的市场起薪水平";
            break;
        }
        case 1:
        {   
            UIImageView  *imgV3 =[[UIImageView alloc] initWithFrame:CGRectMake(40, 60, 270, 100)];
            imgV3.image =[UIImage imageNamed:@"chartBg.png"];
            
            [cell.contentView addSubview:imgV3];
            [imgV3 release];
            
            UIImageView  *imgV1 =[[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 320, 20)];
            imgV1.image =[UIImage imageNamed:@"form_title.png"];
            
            UIImageView  *imgV2 =[[UIImageView alloc] initWithFrame:CGRectMake(0, 27, 320, 20)];
            imgV2.image =[UIImage imageNamed:@"form_query.png"];
            
            [cell.contentView  addSubview:imgV1];
            [cell.contentView addSubview:imgV2];
            [imgV1 release];
            [imgV2 release];
            //插入一个图
            DrawView  *view =[[DrawView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
            view.backgroundColor =[UIColor clearColor];
            [view initDrawView:self.queryResultArray andSalary:[self.salary intValue]];
            
            [cell.contentView addSubview: view];
            
            break;
        }
        case 2:
        {
            cell.textLabel.text =@"你的查询条件";
            break;
        }
        case 3:
        {   //将一个自定义的cell插入到当前的cell
            QueryCell  *queryCell =[[QueryCell alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
            if (self.exper ==1) {
                queryCell.joblevelOrEducationLabel.text =@"职位级别:";
                queryCell.joblevelOrEducationLabel2.text =self.joblevel;
            } else {
                queryCell.joblevelOrEducationLabel.text =@"学历:";
                queryCell.joblevelOrEducationLabel2.text =self.education;
            }
            queryCell.cityLabel2.text =self.city;
            queryCell.industryLabel2.text=self.industry;
            queryCell.corppropertyLabel2.text =self.corproperty;
            queryCell.jobcatLabel2.text =self.jobcat;
            queryCell.salaryLabel2.text =self.salary;
            [cell.contentView addSubview:queryCell];
            [queryCell release];
            
            break;
        }   
        case 4:
        {
            cell.textLabel.text =@"薪酬比较";
            break;
        }
        case 5:
        {               
            UIImageView  *imgV =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
            imgV.image =[UIImage imageNamed:@"accessoryArrow.png"];
            cell.accessoryView =imgV;
            
            cell.textLabel.text =@"我想比较:";
            UITextField   *tf =[[UITextField alloc] initWithFrame:CGRectMake(110, 4, 170, 29)];
            if (self.exper ==1) {
                tf.placeholder =@"地区/行业/企业性质/职业类别/职业级别";
            }
            else{
                tf.placeholder =@"地区/行业/企业性质/职业类别/学历";
            }
            tf.text =@"";
            tf.tag =1000;//方便以后取值
            tf.textAlignment =UITextAlignmentRight;
            tf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
            tf.borderStyle =UITextBorderStyleNone;
            tf .userInteractionEnabled =NO;//关闭与用户的交互
            [cell.contentView addSubview:tf];
            [tf release];
            
            break;
        }
        case 6:
        {   
            UIImageView  *imgV =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
            imgV.image =[UIImage imageNamed:@"accessoryArrow.png"];
            cell.accessoryView =imgV;
            
            cell.textLabel.text =@"继续比较:";
            UITextField   *tf =[[UITextField alloc] initWithFrame:CGRectMake(110, 4, 170, 29)];
            tf.placeholder =@"请选择详细比较内容";
            
            tf.tag =1000;//方便以后取值
            tf.textAlignment =UITextAlignmentRight;
            tf.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
            tf.borderStyle =UITextBorderStyleNone;
            tf .userInteractionEnabled =NO;//关闭与用户的交互(重要)
                    
            [cell.contentView addSubview:tf];
            [tf release];
            
            break;
        }
        case 7:
        {   
            UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame =CGRectMake(80, 2, 160, 31);
            [btn setTitle:@"比较" forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"button_bg_normal.png"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(compareBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];
            
            break;
        }
        default:
            break;
    }
    
        
    return cell;
}
#pragma mark -
-(void)compareBtnClicked
{
    NSLog(@"%s %d",__FUNCTION__,__LINE__);
    
    //第一个条件框所在的cell
    UITableViewCell  *cell =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    //该cell上的UITextField
    UITextField  *tf =(UITextField *)[cell.contentView viewWithTag:1000];
    
    //只需判断第一个条件选择框是否有值即可，因为只要第一个有值，第二个一定有值，默认是相应数组的第一个（索引0）值
    if ([tf.text isEqualToString:@""]) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:5];
        [promptView show:@"请先选择比较类型!"];
        [promptView hidden];
        [UIView commitAnimations];
    }else{//此时可进行查询操作了，因为两个条件框都有值了，并且值被保存下来了
        

        [activityView show];//显示
        
        //进行查询请求
        [self requestForCompare];
    }
                              
}
-(void)requestForCompare//进行比较
{
    NSString  *string1 =[NSString stringWithFormat:@"http://mobileinterface.zhaopin.com/iphone/payquery/comparequery.service?experience=%d&cityid=%@&industryid=%@&corppropertyid=%@&jobcatid=%@&joblevelid=%@&salary=%d&comparetype=%@&comparevalue=%@",self.exper,self.cityID,self.industryID,self.corpropertyID,self.jobcatID,self.joblevelID,[self.salary intValue],self.queryString,self.compareQueryStringID];
    
    NSString  *string2 =[NSString stringWithFormat:@"http://mobileinterface.zhaopin.com/iphone/payquery/comparequery.service?experience=%d&cityid=%@&industryid=%@&corppropertyid=%@&jobcatid=%@&educationid=%@&salary=%d&comparetype=%@&comparevalue=%@",self.exper,self.cityID,self.industryID,self.corpropertyID,self.jobcatID,self.educationID,[self.salary intValue],self.queryString,self.compareQueryStringID];

    
    NSURL  *url =nil;
    if (self.exper ==1) {
        url =[NSURL URLWithString:string1];
        NSLog(@"%@",string1);
    }else{
        url =[NSURL URLWithString:string2];
        NSLog(@"%@",string2);
    }
    
    NSURLRequest  *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    NSURLConnection  *connection =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection release];
     
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{    
    self.compareResultData =[[NSMutableData alloc] init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.compareResultData  appendData:data];//附加到Data上
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [activityView hidden];//隐藏风火轮
    
    [self readXMLString];//解析请求结果并做相应的处理
    
}
-(void)readXMLString
{
    NSLog(@"%s %d",__FUNCTION__,__LINE__);
    NSString  *string =[[NSString  alloc] initWithData:self.compareResultData encoding:NSUTF8StringEncoding];
    NSLog(@"XML %@",string);//XMLString 
    
    GDataXMLDocument *document =[[GDataXMLDocument alloc] initWithXMLString:string options:0 error:nil];
    
    GDataXMLElement  *root =[document rootElement];//xml文本的根节点
    
    if ([[root children] count]==2) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:5];
        [promptView show:@"根据您输入的条件没有查询到相应的薪资信息！"];
        [promptView hidden];
        [UIView commitAnimations];
    } else{
        //调用方法
        [self parseFromXMLNodeRoot:root];             
        //推入另一个界面
        SalaryCompareResult  *salaryCompareResult =[[SalaryCompareResult alloc] init];
        salaryCompareResult.experience =self.exper;
        
        salaryCompareResult.querySalary =self.queryResultArray;//查询的薪水
        salaryCompareResult.compareSalary =self.compareResultArray;//比较的薪水
        salaryCompareResult.salary =self.salary;//传递薪水值
        
        salaryCompareResult.city =self.city;
        salaryCompareResult.industry =self.industry;
        salaryCompareResult.corproperty =self.corproperty;
        salaryCompareResult.jobcat =self.jobcat;
        salaryCompareResult.joblevel =self.joblevel;
        salaryCompareResult.education =self.education;
        
        salaryCompareResult.cityID =self.cityID;
        salaryCompareResult.industryID =self.industryID;
        salaryCompareResult.corpropertyID =self.corpropertyID;
        salaryCompareResult.jobcatID =self.jobcatID;
        salaryCompareResult.joblevelID =self.joblevelID;
        salaryCompareResult.educationID =self.educationID;
        
        salaryCompareResult.compareQueryString  =self.compareQueryString;
        salaryCompareResult .tempNumFromLastClass =tempNum;
        [self.navigationController pushViewController:salaryCompareResult animated:YES];
        [salaryCompareResult release];
    }
}

//根据xml的根节点解析相关数据
-(void)parseFromXMLNodeRoot:(GDataXMLElement *)root
{
    NSLog(@"%s %d",__FUNCTION__,__LINE__);
    
    self.compareResultArray =[[NSMutableArray alloc] init];
    
       
    //开始解析比较的五个工资
    NSArray  * node =[root nodesForXPath:@"compareresult/low" error:nil];
    for (GDataXMLElement  *element in node) {
        [self.compareResultArray addObject:[element stringValue]];
    }
    
    node =[root nodesForXPath:@"compareresult/low-normal" error:nil];
    for (GDataXMLElement  *element in node) {
        [self.compareResultArray addObject:[element stringValue]];
    }
    
    node =[root nodesForXPath:@"compareresult/normal" error:nil];
    for (GDataXMLElement  *element in node) {
        [self.compareResultArray addObject:[element stringValue]];
    }
    
    node =[root nodesForXPath:@"compareresult/normal-high" error:nil];
    for (GDataXMLElement  *element in node) {
        [self.compareResultArray addObject:[element stringValue]];
    }
    
    node =[root nodesForXPath:@"compareresult/high" error:nil];
    for (GDataXMLElement  *element in node) {
        [self.compareResultArray addObject:[element stringValue]];
    }
    NSLog(@"查询工资 %@",self.queryResultArray);
    NSLog(@"比较后的五个工资 %@",self.compareResultArray);

}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow =indexPath.row;//保存选中行
    UITableViewCell  *cell =[self.tableView cellForRowAtIndexPath:indexPath];
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
            break;
            
        case 1:
            break;
            
        case 2:
            break;
            
        case 3:
            break;
            
        case 5:
        { 
            NSMutableArray *array1 =[[NSMutableArray alloc] initWithObjects:@"地区",@"行业",@"企业性质",@"职位类别",@"职位级别", nil];
            NSMutableArray *array2 =[[NSMutableArray alloc] initWithObjects:@"地区",@"行业",@"企业性质",@"职位类别",@"学历", nil];
            
            SelectQueryConditons  *sel =[[SelectQueryConditons alloc] init];
            sel.title =@"选择比较类型";
            sel.selectDelegate =self;
            if (self.exper ==1){
                sel.selectedArray =array1;
            }else
                sel.selectedArray =array2;
            
            [self.navigationController pushViewController:sel animated:YES];
            
            break;
        }
        case 6:
        { 
            UITableViewCell  *cell =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:0]];
            UITextField  *tf =(UITextField *)[cell .contentView viewWithTag:1000];
            if ([tf.text isEqualToString:@""]) {
               
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:5];
                [promptView show:@"请先选择第一个比较条件！"];
                [promptView hidden];
                [UIView commitAnimations];
            }else{
                QueryConditions  *queryConditions =[[QueryConditions alloc] init];
                [queryConditions prepareForAllQueryConditions];
                
                SelectQueryConditons  *sel =[[SelectQueryConditons alloc] init];
                sel.title =@"选择比较内容";
                sel.selectDelegate =self;
                switch (tempNum) {
                    case 0:
                        sel.selectedArray =queryConditions.citysName;
                        break;
                    case 1:
                        sel.selectedArray =queryConditions.industrysName;
                        break;
                    case 2:
                        sel.selectedArray =queryConditions.corppropertysName;
                        break;
                    case 3:
                        sel.selectedArray =queryConditions.jobcatsName;
                        break;
                    case 4:
                        if (self.exper==1) {
                            sel.selectedArray =queryConditions.joblevelsName;
                        }else
                            sel.selectedArray =queryConditions.educationsName;
                        break;
                    default:
                        break;
                }
                
                [self.navigationController pushViewController:sel animated:YES];
                
                [queryConditions release];
                [sel release];
            }
            break;
        }
        case 7:
            break;
        default:
            break;
      
    }
    
}
#pragma mark -
#pragma mark SelectQueryConditonsDelegate Methods
-(void)selectQueryCondition:(SelectQueryConditons *)selectQueryCondition atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %d",__FUNCTION__,__LINE__);
    UITableViewCell  *cell =  [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedRow inSection:0]];
    
    UITextField  *tf =(UITextField *)[cell.contentView viewWithTag:1000];
    
    tf.text =[selectQueryCondition.tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    
}
-(void)selectedRowIn:(SelectQueryConditons *)sel
{
    NSLog(@"%s %d",__FUNCTION__,__LINE__);
    
    int num ;//选中的某个具体条件
    QueryConditions  *queryConditions=[[QueryConditions alloc] init];
    [queryConditions prepareForAllQueryConditions];
    
    num =[sel .tableView indexPathForSelectedRow].row;
    switch (selectedRow) {
        
        case 5://第一个选择条件
        {
            tempNum =num;
            UITableViewCell *cell =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
            UITextField  *tf =(UITextField *)[cell.contentView viewWithTag:1000];//根据第一个条件相应的改变第二个条件的值
            switch (num) {
                case 0:
                    self.queryString =@"city";
                    self.compareQueryString =[queryConditions.citysName objectAtIndex:0];
                    self.compareQueryStringID =[queryConditions.citysID objectAtIndex:0];
                    tf .text =[queryConditions .citysName objectAtIndex:0];
                    break;
                case 1:
                    self.queryString =@"industry";
                    self.compareQueryString =[queryConditions.industrysName objectAtIndex:0];
                     self.compareQueryStringID =[queryConditions.industrysID objectAtIndex:0];
                    tf .text =[queryConditions .industrysName objectAtIndex:0];
                    break;
                case 2:
                    self.queryString =@"corpproperty";
                    self.compareQueryString =[queryConditions.corppropertysName objectAtIndex:0];
                     self.compareQueryStringID =[queryConditions.corppropertysID objectAtIndex:0];
                    tf .text =[queryConditions .corppropertysName objectAtIndex:0];
                    break;
                case 3:
                    self.queryString =@"jobcat";
                    self.compareQueryString =[queryConditions.jobcatsName objectAtIndex:0];
                     self.compareQueryStringID =[queryConditions.jobcatsID objectAtIndex:0];
                    tf .text =[queryConditions .jobcatsName objectAtIndex:0];
                    break;
                case 4:
                    if (self.exper==1) {
                        self.queryString =@"joblevel";
                        self.compareQueryString =[queryConditions.joblevelsName objectAtIndex:0];
                         self.compareQueryStringID =[queryConditions.joblevelsID objectAtIndex:0];
                        tf .text =[queryConditions .joblevelsName objectAtIndex:0];
                    }else{
                        self.queryString =@"education";
                        self.compareQueryString =[queryConditions.educationsName objectAtIndex:0];
                         self.compareQueryStringID =[queryConditions.educationsID objectAtIndex:0];
                    tf .text =[queryConditions .educationsName objectAtIndex:0];
                    }
                    break;
                default:
                    break;
            }
            
            NSLog(@"第一查询条件queryString %@",self.queryString);
            break;
        }
        case 6://第二个选择条件，一定会在第一个选择之后
        {            
            switch (tempNum) {
                case 0:// 说明第一个选择的是地区
                    self.compareQueryString = [queryConditions.citysName objectAtIndex:num];
                    self.compareQueryStringID = [queryConditions.citysID objectAtIndex:num];
                    break;
                case 1:
                    self.compareQueryString = [queryConditions.industrysName objectAtIndex:num];
                    self.compareQueryStringID = [queryConditions.industrysID objectAtIndex:num];
                    break;
                case 2:
                    self.compareQueryString = [queryConditions.corppropertysName objectAtIndex:num];
                    self.compareQueryStringID = [queryConditions.corppropertysID objectAtIndex:num];
                    break;
                case 3:
                    self.compareQueryString = [queryConditions.jobcatsName objectAtIndex:num];
                    self.compareQueryStringID = [queryConditions.jobcatsID objectAtIndex:num];
                    break;
                case 4:
                    if (self.exper ==1){ 
                         self.compareQueryString = [queryConditions.joblevelsName objectAtIndex:num];
                    self.compareQueryStringID= [queryConditions.joblevelsID objectAtIndex:num];
                    }else{
                        self.compareQueryString = [queryConditions.educationsName objectAtIndex:num];
                        self.compareQueryStringID = [queryConditions.educationsID objectAtIndex:num];
                    }
                    break;
                default:
                    break;
            }
            NSLog(@"详细查询条件compareQueryString %@",self.compareQueryString);
            break;
        }
        default:
            break;
    }
    [queryConditions release];
}

@end
