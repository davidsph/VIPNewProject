//
//  PersonnelMessageViewController.m
//  MyZhilian
//
//  Created by Ibokan on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PersonnelMessageViewController.h"
#import "DetailEmailViewController.h"
#import "Indicator.h"
#import "MessageCell.h"
#import "Message.h"
#import "GDataXMLNode.h"
#import "DNWrapper.h"
#import "IsLogin.h"

@implementation PersonnelMessageViewController

@synthesize uTicket;
@synthesize messageData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
-(void)backFirstView
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)loadView
{
    
    self.view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"纸纹.png"]];
    self.navigationItem.title=@"收件箱";
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 50, 40);
    [btn setTitle:@"首页" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
    [btn addTarget:self action:@selector(backFirstView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:btn];  
    self.navigationItem.leftBarButtonItem=backBtn; 
    [backBtn release];
    
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(0, 0, 55, 44);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"方形按钮"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.titleLabel.font=[UIFont fontWithName:@"ArialMT" size:14];
    [btn2 setTitle:@"编辑" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(doSomething:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:btn2];  
    self.navigationItem.rightBarButtonItem=backBtn2;  
    //self.navigationItem.rightBarButtonItem
    [backBtn2 release];

    
//    self.editButtonItem.title=@"编辑";
//    self.navigationItem.rightBarButtonItem=self.editButtonItem;    
    
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:nil];
        
   
    [Indicator addIndicator:self.view];
    messageArray=[[NSMutableArray alloc]init];
    IsLogin *islogin=[IsLogin defaultIsLogin];
    uTicket=islogin.uticket;
    NSString *str=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/get_hr_email_list.aspx?uticket=%@&page=1&pagesize=10",uTicket];
    
    [self setURL:str];
    
    self.messageData=[[NSMutableData alloc]init ];
    

}

-(void)doSomething:(UIButton *)btn
{
    NSString  *string1 =[btn titleForState:UIControlStateNormal];
    
    if ([string1 isEqualToString:@"编辑"]) {
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        // allow  deleting 
        [self setEditing:YES animated:YES];
    }else
    {
        // forbid deleting
        if ([string1 isEqualToString:@"完成"]) {
            [btn setTitle:@"编辑" forState:UIControlStateNormal];
            // no editing  but has animation
            [self setEditing:NO animated:YES];
        }
    }
}

-(void)setURL:(NSString *)string{
    NSString *urlstr=[DNWrapper getMD5String:string];
    NSURL *url=[[NSURL alloc]initWithString:urlstr];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
}

//异步请求代理方法的实现
//数据请求失败
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"数据请求失败");
}
//服务器段开始响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}
//数据接受，拼接数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.messageData appendData:data];
}
//数据加载完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [self setEmail];
    [Indicator removeIndicator:self.view];
    tableTV=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    tableTV.backgroundColor=[UIColor clearColor];
    tableTV.delegate=self;
    tableTV.dataSource=self;
    [self.view addSubview:tableTV];
}

//数据解析

-(void)setEmail{
    GDataXMLDocument *doucument=[[GDataXMLDocument alloc]initWithData:self.messageData options:0 error:nil];
    root=[doucument rootElement];
    NSArray *emailList=[root nodesForXPath:@"emaillist/email" error:nil];
    for (int i=0; i<[emailList count]; i++) {
        
        GDataXMLElement *email=[emailList objectAtIndex:i];
        Message *message=[[Message alloc]init];
        message.subject=[[[email nodesForXPath:@"subject" error:nil] objectAtIndex:0]stringValue];
        message.companyNumber=[[[email nodesForXPath:@"company_number" error:nil] objectAtIndex:0]stringValue];
        message.companyName=[[[email nodesForXPath:@"company_name" error:nil] objectAtIndex:0]stringValue];
        message.emailNumber=[[[email nodesForXPath:@"email_number" error:nil]objectAtIndex:0]stringValue];
        message.emailDate=[[[email nodesForXPath:@"date_posted" error:nil]objectAtIndex:0]stringValue];
        message.isRead=[[[email nodesForXPath:@"is_read" error:nil]objectAtIndex:0]stringValue];
        [messageArray addObject:message];
        
    }
}

#pragma mark -tableView 代理
//返回tableview的row 的数目
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [messageArray count];
}
//返回tableview的section的数目
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//返回tableview的row的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"Cell";
    MessageCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    Message *message=[messageArray objectAtIndex:indexPath.row];
    cell.resumeLabel.text=message.subject;
    cell.companyLabel.text=message.companyName;
    cell.dateLabel.text=message.emailDate;

    if ([message.isRead isEqualToString:@"y"]) {
        cell.imageView.image=[UIImage imageNamed:@"reader_flag@2x.png"];
    }else{
        cell.imageView.image=[UIImage imageNamed:@"unreader@2x.png"];
    }
    //添加右侧小按钮
    UIImage *image= [UIImage imageNamed:@"accessoryArrow.png"];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton. frame = CGRectMake(0.0,0.0,image.size.width,image.size.height);
    [rightButton setBackgroundImage:image forState:UIControlStateNormal];
    rightButton. backgroundColor = [UIColor clearColor];
    [rightButton addTarget:self action:@selector(tableView:didSelectRowAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];//点击此小按钮和点击cell作用相同，都是进入职位详情界面
    cell. accessoryView = rightButton; 
    return cell;
}
//tableview的可编辑代理方法
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [tableTV setEditing:editing animated:animated];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //向服务器发送删除请求，删除人事来信
        
       // Message *message=[messageArray objectAtIndex:indexPath.row];
        
        //同步get请求
//        NSString *str=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobmng_fav_del.aspx?job_number=%@&uticket=%@",[job_number stringValue],uTicket];
//        
//        NSString *url1=[self getMD5String:str];
//        NSURL *url=[NSURL URLWithString:url1];
//        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//        
//        //第三步，连接服务器
//        NSURLResponse *response = nil;
//        NSError *err = nil;
//        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        
        [messageArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Message *message=[messageArray objectAtIndex:indexPath.row];
    DetailEmailViewController *detailEmail=[[[DetailEmailViewController alloc]init] autorelease];
    detailEmail.emailNum=message.emailNumber;
    [self.navigationController pushViewController:detailEmail animated:YES];
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

@end
