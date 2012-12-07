//
//  SalaryCompareResult.m
//  SalarySearch
//
//  Created by Ibokan on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SalaryCompareResult.h"
#import "SalaryQueryHome.h"
#import "SalaryQueryResult.h"
#import "QueryConditions.h"
#import "QueryCell.h"

@implementation SalaryCompareResult

@synthesize tableView;
@synthesize experience ,tempNumFromLastClass;
@synthesize salary;// 
@synthesize queryString,compareQueryString,compareQueryStringID;
@synthesize data;
@synthesize querySalary,compareSalary;
@synthesize city,industry,corproperty,joblevel,jobcat,education;
@synthesize cityID,industryID,corpropertyID,joblevelID,jobcatID,educationID;
- (void)dealloc {


    [self.tableView release];
    [self.salary release];
    [self.queryString release];
    [self.compareQueryString release];
    [self.compareQueryStringID release];
    [self.data release];
    
    [self.querySalary release];
    [self.compareSalary release];

    [self.city release];
    [self.industry release];
    [self.corproperty release];
    [self.jobcat release];
    [self.joblevel release];
    [self.education release];
    
    [self.cityID release];
    [self.industryID release];
    [self.corpropertyID release];
    [self.jobcatID release];
    [self.joblevelID release];
    [self.educationID release];
    
    [promptView release];
    [activityView release];
    
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"%s %d",__FUNCTION__,__LINE__);
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"%s %d",__FUNCTION__,__LINE__);
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    NSLog(@"%s %d",__FUNCTION__,__LINE__);
    
    self.title =@"薪酬比较结果";
    
    self.view =[[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)] autorelease];
    
    //初始化tableview的大小
    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    
    promptView =[[PromptsView alloc] initWithFrame:CGRectMake(60, 300, 200, 40)];
    [self.tableView addSubview:promptView];
    [promptView hidden];
    
    activityView  =[[ActivityView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:activityView];
    [activityView hidden];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%s %d",__FUNCTION__,__LINE__);
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame =  CGRectMake(0, 0, 44, 34);
    backButton.titleLabel.font =[UIFont systemFontOfSize:15.0];

    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.adjustsFontSizeToFitWidth =YES;
    backButton.backgroundColor = [UIColor clearColor];
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
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row==1) 
            return 200;
    if (indexPath.row ==3) {
        return 120;
    }
    return 33;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableVi cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
     NSString *CellIdentifier = [NSString stringWithFormat:@"Row%d",indexPath.row];
    
    UITableViewCell *cell = [tableVi dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
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
            UIImageView  *imgV1 =[[UIImageView alloc] initWithFrame:CGRectMake(0, 3, 320, 20)];
            imgV1.image =[UIImage imageNamed:@"form_title.png"];
            
            UIImageView  *imgV2 =[[UIImageView alloc] initWithFrame:CGRectMake(0, 26, 320, 20)];
            imgV2.image =[UIImage imageNamed:@"form_query.png"];
            
            UIImageView *imgV3 =[[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 320, 20)];
            imgV3.image =[UIImage imageNamed:@"form_compare.png"];
            [cell.contentView  addSubview:imgV1];
            [cell.contentView addSubview:imgV2];
            [cell.contentView addSubview:imgV3];
            
            [imgV1 release];
            [imgV2 release];
            [imgV3 release];
            
            UIImageView  *imgV =[[UIImageView alloc] initWithFrame:CGRectMake(40, 80, 270, 100)];
            imgV.image =[UIImage imageNamed:@"chartBg.png"];
            
            [cell.contentView addSubview:imgV];
            [imgV release];
            
            //插入一个图
            DrawTwoView  *view =[[DrawTwoView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
            view.backgroundColor =[UIColor clearColor];
            
            [view initDrawView:self.querySalary andView:self.compareSalary andSalary:[self.salary intValue]];
            
            [cell.contentView addSubview: view];
            
            break;
        }
        case 2:
        {  
            cell.textLabel.text =@"您的查询条件";
            break;
        }   
        case 3:
        {
            //将一个自定义的cell插入到当前的cell
            QueryCell  *queryCell =[[QueryCell alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
            if (self.experience ==1) {
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
            cell.textLabel.text =@"您的比较查询条件";
            break;
        }
        case 5:
        {
            //为使风格与上面自定义的cell一致，在这里我也采用了贴两个label上去，否则使用cell原带的textLabel与detailTextLabel会让让用户觉得孤立，与上面的cell没有联系
           UILabel * nameLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 4, 75, 25)];
            nameLabel.font =[UIFont systemFontOfSize:15];//15号字大小
            switch (self.tempNumFromLastClass) {
                case 0:
                    nameLabel.text =@"地区:";
                    break;
                case 1:
                    nameLabel.text =@"行业:";
                    break;
                case 2:
                    nameLabel.text =@"企业性质:";
                    break;
                case 3:
                    nameLabel.text =@"职位类别:";
                    break;
                case 4:
                    if (self.experience ==1) {
                        nameLabel.text =@"职位级别:";
                    }else{
                        nameLabel.text =@"学历:";
                    }
                    break;
                default:
                    break;
            }
        
            UILabel  *detailLabel =[[UILabel alloc] initWithFrame:CGRectMake(90, 4, 220, 25)];
            detailLabel.text =self.compareQueryString;
            detailLabel.font =[UIFont systemFontOfSize:15];
            [cell.contentView addSubview:nameLabel];
            [cell.contentView addSubview:detailLabel];
            [nameLabel release];
            [detailLabel release];
            
            break;
        }
        case 6:
        {   
            cell.textLabel.text =@"薪酬比较";
            break;
        }
        case 7:
        {   
            UIImageView  *imgV =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
            imgV.image =[UIImage imageNamed:@"accessoryArrow.png"];
            cell.accessoryView =imgV;
            
            cell.textLabel.text =@"我想比较:";
            UITextField   *tf =[[UITextField alloc] initWithFrame:CGRectMake(110, 4, 170, 29)];
            if (self.experience ==1) {
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
        case 8:
        {   
            UIImageView  *imgV =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
            imgV.image =[UIImage imageNamed:@"accessoryArrow.png"];
            cell.accessoryView =imgV;
            
            cell.textLabel.text =@"继续比较:";
            UITextField   *tf =[[UITextField alloc] initWithFrame:CGRectMake(110, 6, 170, 32)];
            tf.placeholder =@"请选择详细比较内容";
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
        case 9:
        {   
            UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame =CGRectMake(10, 2, 140, 31);
            [btn setTitle:@"比较" forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"button_bg_normal.png"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(compareBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];
            
            UIButton *btn2 =[UIButton buttonWithType:UIButtonTypeCustom];
            btn2.frame =CGRectMake(170, 2, 140, 31);
            [btn2 setTitle:@"重新查询" forState:UIControlStateNormal];
            [btn2 setBackgroundImage:[UIImage imageNamed:@"button_bg_normal.png"] forState:UIControlStateNormal];
            [btn2 addTarget:self action:@selector(restartBtn) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn2];

            break;
        }
        default:
            break;
    }
    
    return cell;
}
#pragma mark -
-(void)restartBtn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)compareBtnClicked
{
    NSLog(@"%s %d",__FUNCTION__,__LINE__);
    //第一个条件框所在的cell
    UITableViewCell  *cell1 =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
   //cell上贴的uitextfield
    UITextField  *tf =(UITextField *)[cell1.contentView viewWithTag:1000];
    
    //只需判断第一个条件选择框是否有值即可，因为只要第一个有值，第二个一定有值，默认是相应数组的第一个（索引0）值
    if ([tf.text isEqualToString:@""]) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:5];
        [promptView show:@"请先选择比较类型!"];
        [promptView hidden];
        [UIView commitAnimations];
    }else{//可直接进行查询操作了，因为第二个条件框里一定有值了，无需判断
        
        [activityView show];
        
        //进行查询请求 
        [self requestForCompare];
    }
    
}
-(void)requestForCompare//异步get请求
{ 
    NSString  *string1 =[NSString stringWithFormat:@"http://mobileinterface.zhaopin.com/iphone/payquery/comparequery.service?experience=%d&cityid=%@&industryid=%@&corppropertyid=%@&jobcatid=%@&joblevelid=%@&salary=%d&comparetype=%@&comparevalue=%@",self.experience,self.cityID,self.industryID,self.corpropertyID,self.jobcatID,self.joblevelID,[self.salary intValue],self.queryString,self.compareQueryStringID];
    
    NSString  *string2 =[NSString stringWithFormat:@"http://mobileinterface.zhaopin.com/iphone/payquery/query.service?experience=%d&cityid=%@&industryid=%@&corppropertyid=%@&jobcatid=%@&educationid=%@&salary=%d&comparetype=%@&comparevalue=%@",self.experience,self.cityID,self.industryID,self.corpropertyID,self.jobcatID,self.educationID,[self.salary intValue],self.queryString,self.compareQueryStringID];
        
    NSURL  *url =nil;
    if (self.experience ==1) {
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
    self.data =[[NSMutableData alloc] init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data2
{
    [self.data  appendData:data2];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%s %d",__FUNCTION__,__LINE__);

    [activityView hidden];
    
    //将获取的xml数据进行解析处理的方法
    [self readXMLString];
}
-(void)readXMLString
{
    NSLog(@"%s %d",__FUNCTION__,__LINE__);
    NSString  *string =[[NSString  alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);//XMLString 
    
    GDataXMLDocument *document =[[GDataXMLDocument alloc] initWithXMLString:string options:0 error:nil];
    GDataXMLElement  *root =[document rootElement];//xml文本的根节点
    
    
    if ([[root children] count]==2) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:5];
        [promptView show:@"根据您输入的条件没有查询到相应的薪资信息！"];
        [promptView hidden];
        [UIView commitAnimations];
    } else{
        
        [self parseFromXMLNodeRoot:root];
        //推入另一个界面
        SalaryCompareResult2  *salaryCompareResult2 =[[SalaryCompareResult2 alloc] init];
        salaryCompareResult2.experience =self.experience;
        
        salaryCompareResult2.querySalary =self.querySalary;//查询的薪水
        salaryCompareResult2.compareSalary =self.compareSalary;//比较的薪水
        salaryCompareResult2.salary =self.salary;//传递薪水值
        
        salaryCompareResult2.city =self.city;
        salaryCompareResult2.industry =self.industry;
        salaryCompareResult2.corproperty =self.corproperty;
        salaryCompareResult2.jobcat =self.jobcat;
        salaryCompareResult2.joblevel =self.joblevel;
        salaryCompareResult2.education =self.education;
        
        salaryCompareResult2.cityID =self.cityID;
        salaryCompareResult2.industryID =self.industryID;
        salaryCompareResult2.corpropertyID =self.corpropertyID;
        salaryCompareResult2.jobcatID =self.jobcatID;
        salaryCompareResult2.joblevelID =self.joblevelID;
        salaryCompareResult2.educationID =self.educationID;
        
        salaryCompareResult2.compareQueryString =self.compareQueryString;
        salaryCompareResult2.tempNumFromLastClass =tempNum;
        [self.navigationController pushViewController:salaryCompareResult2 animated:YES];
        [salaryCompareResult2 release];
       
    }

}
//根据xml的根节点解析相关数据
-(void)parseFromXMLNodeRoot:(GDataXMLElement *)root
{
   
    self.compareSalary =[[NSMutableArray alloc] init];
    
    
    
    //开始解析比较的五个工资
   NSArray  * node =[root nodesForXPath:@"compareresult/low" error:nil];
    for (GDataXMLElement  *element in node) {
        [self.compareSalary addObject:[element stringValue]];
    }
    
    node =[root nodesForXPath:@"compareresult/low-normal" error:nil];
    for (GDataXMLElement  *element in node) {
        [self.compareSalary addObject:[element stringValue]];
    }
    
    node =[root nodesForXPath:@"compareresult/normal" error:nil];
    for (GDataXMLElement  *element in node) {
        [self.compareSalary addObject:[element stringValue]];
    }
    
    node =[root nodesForXPath:@"compareresult/normal-high" error:nil];
    for (GDataXMLElement  *element in node) {
        [self.compareSalary addObject:[element stringValue]];
    }
    
    node =[root nodesForXPath:@"compareresult/high" error:nil];
    for (GDataXMLElement  *element in node) {
        [self.compareSalary addObject:[element stringValue]];
    }
    NSLog(@"查询工资 %@",self.querySalary);
    NSLog(@"比较后的五个工资 %@",self.compareSalary);

}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow =indexPath.row;
    UITableViewCell  *cell =[self.tableView cellForRowAtIndexPath:indexPath];
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
            /* 0~6点击时什么操作都没有 */
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
        { //push to selectQueryCondition
            NSMutableArray *array1 =[[NSMutableArray alloc] initWithObjects:@"地区",@"行业",@"企业性质",@"职位类别",@"职位级别", nil];
            NSMutableArray *array2 =[[NSMutableArray alloc] initWithObjects:@"地区",@"行业",@"企业性质",@"职位类别",@"学历", nil];
            
            SelectQueryConditons  *sel =[[SelectQueryConditons alloc] init];
            sel.title =@"选择比较类型";
            sel.selectDelegate =self;
            if (self.experience ==1) {
                sel.selectedArray =array1;
            }else
                sel.selectedArray =array2;
            
            [self.navigationController pushViewController:sel animated:YES];
            
            break;
        }
        case 8:
        { //push to selectQueryCondition
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
                        if (self.experience==1) {
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
        case 9:
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
    
    QueryConditions  *queryConditions =[[QueryConditions alloc] init];
    [queryConditions prepareForAllQueryConditions];
    
    UITableViewCell  *cell =[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
    UITextField  *tf =(UITextField *)[cell.contentView viewWithTag:1000];
    
    int num ;//选中的某个具体条件
    num =[sel .tableView indexPathForSelectedRow].row;
    switch (selectedRow) {
            
        case 7://第一个选择条件
            tempNum =num;
            switch (num) {
                case 0:
                    self.queryString =@"city";
                    tf.text =[queryConditions .citysName objectAtIndex:0];
                    self.compareQueryString = [queryConditions.citysName objectAtIndex:0];
                    self.compareQueryStringID = [queryConditions.citysID objectAtIndex:0];
                    break;
                case 1:
                    self.queryString =@"industry";
                    tf.text =[queryConditions .industrysName objectAtIndex:0];
                    self.compareQueryString = [queryConditions.industrysName objectAtIndex:0];
                    self.compareQueryStringID = [queryConditions.industrysID objectAtIndex:0];
                    break;
                case 2:
                    self.queryString =@"corpproperty";
                    tf.text =[queryConditions .corppropertysName objectAtIndex:0];
                    self.compareQueryString = [queryConditions.corppropertysName objectAtIndex:0];
                    self.compareQueryStringID = [queryConditions.corppropertysID objectAtIndex:0];
                    break;
                case 3:
                    self.queryString =@"jobcat";
                    tf.text =[queryConditions .jobcatsName objectAtIndex:0];
                    self.compareQueryString = [queryConditions.jobcatsName objectAtIndex:0];
                    self.compareQueryStringID = [queryConditions.jobcatsID objectAtIndex:0];
                    break;
                case 4:
                    if (self.experience==1) {
                        self.queryString =@"joblevel";
                        tf.text =[queryConditions .joblevelsName objectAtIndex:0];
                        self.compareQueryString = [queryConditions.joblevelsName objectAtIndex:0];
                        self.compareQueryStringID = [queryConditions.joblevelsID objectAtIndex:0];
                    }else{
                        self.queryString =@"education";
                        tf.text =[queryConditions .educationsName objectAtIndex:0];
                        self.compareQueryString = [queryConditions.educationsName objectAtIndex:0];
                        self.compareQueryStringID = [queryConditions.educationsID objectAtIndex:0];
                    }
                    break;
                default:
                    break;
            }
            NSLog(@"第一查询条件 queryString %@",self.queryString);
            break;
        case 8://第二个选择条件，一定会在第一个选择之后
        {
            QueryConditions  *queryConditions =[[QueryConditions alloc] init];
            [queryConditions prepareForAllQueryConditions];
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
                    if (self.experience ==1){ 
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
            [queryConditions release];
            NSLog(@"详细查询条件 compareQueryString %@",self.compareQueryString);
            break;
        }
        default:
            break;
    }
}

@end
