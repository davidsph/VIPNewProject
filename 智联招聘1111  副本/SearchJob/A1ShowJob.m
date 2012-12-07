//
//  A1ShowJob.m
//  A1ShowJob
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A1ShowJob.h"
#import "CollectJob.h"
#import "SearchJob.h"
#import "A1ShowTable.h"
#import "A1ShowOtherJob.h"
#import "A1MapVC.h"
#import "A1SingleApply.h"
#import "IsLogin.h"
#import "LoginViewController.h"
#import "A1PopMenu.h"
#import "PopPromptViewCount.h"

@implementation A1ShowJob

@synthesize job,jD;
@synthesize delegate;
@synthesize applyTapnumber;
@synthesize promptView,promptCount; 
//@synthesize selcetedPoint;


-(void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];   
    
    PopPromptViewCount *pc=[[PopPromptViewCount alloc]init];
    [pc readData];
    self.promptCount=[[pc.arr objectAtIndex:0] intValue];
    [pc release];

    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 75, 44);
    [btn setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    [btn setTitle:@"职位列表" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont fontWithName:@"ArialMT" size:14];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithCustomView:btn];  
    self.navigationItem.leftBarButtonItem=backBtn; 
    [backBtn release];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(0, 0, 55, 44);
    [btn2 setBackgroundImage:[UIImage imageNamed:@"方形按钮"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.titleLabel.font=[UIFont fontWithName:@"ArialMT" size:14];
    [btn2 setTitle:@"申请" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(joinjob) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn2=[[UIBarButtonItem alloc]initWithCustomView:btn2];  
    self.navigationItem.rightBarButtonItem=backBtn2;   
    [backBtn2 release];
    
    
    //    //更换pageC背景图片
    //    selcetedPoint = [UIImage imageNamed:@"BluePoint.png"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData:) name:@"职位详情" object:nil];
    [JobDetails GetJobDetailWithJobNumber:self.job.jobNumber Page:1 PageSize:20];
    
    self.navigationItem.title=@"职位介绍";
    applyTapnumber=0;//记录申请职位点击次数
    
    UIView *ActView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    ActView.tag=123;
    CGPoint po=self.view.center;
    po.y-=80;
    ActView.center=po;
    ActView.backgroundColor=[UIColor clearColor];
    UIActivityIndicatorView *actInd=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    actInd.color=[UIColor grayColor];
    actInd.tag=102;
    actInd.frame=CGRectMake(32, 20, 37, 37);
    [actInd startAnimating];
    [ActView addSubview:actInd];
    [actInd release];
    UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(15, 65, 70, 21)];
    la.tag=103;
    la.backgroundColor=[UIColor clearColor];
    la.textColor=[UIColor grayColor];
    la.text=@"载入中...";
    [ActView addSubview:la];
    [la release];
    [self.view  addSubview:ActView];
    [ActView release];

    
    
    
}
//返回上一界面
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    CGPoint point=scrollView.contentOffset;
    int currentPage=(int)(point.x)/320;
    pageC.currentPage=currentPage;
    if(currentPage==0)
    {
        self.navigationItem.title=@"职位介绍";
    }
    else if(currentPage==1)
    {
        button.hidden = YES;
        self.navigationItem.title=@"公司介绍";
    }
}


-(void)otherJob
{
    A1ShowOtherJob *soj=[[A1ShowOtherJob alloc]init];
    soj.jd=self.jD;
    soj.dataSourceSign=1;
    [self.navigationController pushViewController:soj animated:YES];
}


-(void)loadData:(NSNotification *)not
{
    NSDictionary *dic=[not userInfo];
    self.jD=[dic objectForKey:@"jd"];
    
    [[self.view viewWithTag:123]removeFromSuperview];
    
    //添加一个scrollview
    scrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 371)];
    [self.view addSubview:scrollV];
    scrollV.delegate=self;
    scrollV.contentSize=CGSizeMake(640, 371);
    scrollV.bounces =  NO;
    scrollV.pagingEnabled=YES;
    [scrollV release];
    //添加pagec
    pageC=[[UIPageControl alloc]initWithFrame:CGRectMake(100, 361, 120,10)];
    pageC.numberOfPages=2;
    [pageC setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:pageC];
    //    pageC.hidden=YES;
    [pageC release];
    //label 4 职位名称
    introduceLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 310, 35)];
    [scrollV addSubview:introduceLabel];
    introduceLabel.textAlignment=UITextAlignmentLeft;
    introduceLabel.font=[UIFont systemFontOfSize:20];
    [introduceLabel setTextColor:[UIColor colorWithRed:224/255.0 green:122/255.0 blue:23/255.0 alpha:1]];
    introduceLabel.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    introduceLabel.text=self.job.jobTitle;
    
    
    //lable 4 公司名称
    introduceLabel2=[[UILabel alloc]initWithFrame:CGRectMake(330, 5, 310, 35)];
    [scrollV addSubview:introduceLabel2];
    introduceLabel2.textAlignment=UITextAlignmentLeft;
    introduceLabel2.font=[UIFont systemFontOfSize:20];
    [introduceLabel2 setTextColor:[UIColor colorWithRed:224/255.0 green:122/255.0 blue:23/255.0 alpha:1]];
    introduceLabel2.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    introduceLabel2.text=self.jD.companyName;
    [introduceLabel release];
    [introduceLabel2 release];
    //添加公共部分
    for(int i=0;i<2;i++)
    {
        UITextView *textView = [[[UITextView alloc]initWithFrame:CGRectMake(0+320*i, 35, 320, 336)]autorelease];
        textView.editable = NO;
        textView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        textView.tag=i+1;
        [scrollV addSubview:textView];
        
        //button to公司详情页面
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(240, 2, 48, 48);
        button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"companyDetails.png"]];
        [button addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
        [textView addSubview:button];
        
        //传值
        NSString *str = @"\n\n\n\n\n\n\n\n\n\n";
        if(textView.tag==1)
        {
            NSString *str1 = [str stringByAppendingFormat:@"%@",self.jD.responsibility];
            textView.text = [str1 stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        }
        else if(textView.tag==2)
        {
            NSString *str1 = [str stringByAppendingFormat:@"%@",self.jD.companyDesc];
            textView.text = [str1 stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        }
        
        for(int j=0;j<4;j++)
        {
            UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(10, 7+26*j, 300, 21)]autorelease];
            label.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:0];
            label.font= [UIFont fontWithName:@"Arial" size:13];//字体同样
            label.tag=i*10+11+j;
            label.text = @"载入中...";
            [textView addSubview:label];
            if(label.tag==11)
            {
                label.text=[NSString stringWithFormat:@"月薪:%@",self.jD.salaryRange];
            }
            else if(label.tag==12)
            {
                label.text=[NSString stringWithFormat:@"地点:%@",self.job.jobCity];
            }
            else if(label.tag==13)
            {
                label.text=[NSString stringWithFormat:@"经验:%@",self.jD.workingExp];
            }
            else if(label.tag==14)
            {
                label.text=[NSString stringWithFormat:@"人数:%@",self.jD.number];
            }
            else if(label.tag==21)
            {
                label.text=[NSString stringWithFormat:@"类别:%@",self.jD.companyProperty];
            }
            else if(label.tag==22)
            {
                label.frame = CGRectMake(10, 29, 300, 21);
                label.text=[NSString stringWithFormat:@"规模:%@",self.jD.companySize];
            }
            else if(label.tag==23)
            {
                NSString *str = [NSString stringWithFormat:@"行业:%@",self.jD.industry];
                UIFont *font = [UIFont systemFontOfSize:13];
                CGSize maximumLableSizeOne = CGSizeMake(300, MAXFLOAT);
                CGSize expectedLableSizeOne = [str sizeWithFont:font constrainedToSize:maximumLableSizeOne lineBreakMode:UILineBreakModeWordWrap];
                
                if (expectedLableSizeOne.height > 33)
                {   
                    expectedLableSizeOne.height = 33;
                    label.frame = CGRectMake(10, 50, 300, expectedLableSizeOne.height);
                }
                else
                {
                    
                    label.frame = CGRectMake(10, 50, 300, expectedLableSizeOne.height);
                }
                label.text = str;
                label.lineBreakMode = UILineBreakModeWordWrap;
                label.numberOfLines = 0;
            }
            else if(label.tag==24)
            {
                NSString *str = [NSString stringWithFormat:@"行业:%@",self.jD.address];
                UIFont *font = [UIFont systemFontOfSize:13];
                CGSize maximumLableSizeOne = CGSizeMake(300, MAXFLOAT);
                CGSize expectedLableSizeOne = [str sizeWithFont:font constrainedToSize:maximumLableSizeOne lineBreakMode:UILineBreakModeWordWrap];
                label.frame = CGRectMake(10, 85, 300, expectedLableSizeOne.height);
                label.lineBreakMode = UILineBreakModeWordWrap;
                label.numberOfLines = 0;
                label.text=[NSString stringWithFormat:@"地址:%@",self.jD.address];
            }
            
        }
        //文章分割线
        UIImageView *sprerator = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 135, 320, 2)]autorelease];
        sprerator.image = [UIImage imageNamed:@"contentSprarator.png"];
        [textView addSubview:sprerator];
        
        //otherJobView
        UIView *otherJobView = [[[UIView alloc]initWithFrame:CGRectMake(0+320*i, 371, 320, 45)]autorelease];
        otherJobView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"recommendJobBg.png"]];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(otherJob)];
        [otherJobView addGestureRecognizer:tap];
        [self.view addSubview:otherJobView];
        
        //otherJob lable
        UILabel *lable = [[[UILabel alloc]initWithFrame:CGRectMake(20+320*i, 12, 150, 21)]autorelease];
        lable.text = @"该公司其他职位";
        lable.backgroundColor=[UIColor clearColor];
        [lable setFont:[UIFont systemFontOfSize:18]];
        [otherJobView addSubview:lable];
        
        //arrow
        UIImageView *arrow = [[[UIImageView alloc]initWithFrame:CGRectMake(290+320*i, 16, 10, 14)]autorelease];
        arrow.image = [UIImage imageNamed:@"accessoryArrow.png"];
        [otherJobView addSubview:arrow];
    }
    A1PopMenu *mu=[[A1PopMenu alloc]initWithButtonName:[NSMutableArray arrayWithObjects: @"首页", @"申请",@"收藏",@"查看位置",@"相似职位",nil]];
    mu.delegate=self;
    mu.center=CGPointMake(290, 350);
    [self.view addSubview:mu];
    [mu release];
    
    if (promptCount<2) {
        self.promptView=[[UIImageView alloc]initWithFrame:CGRectMake(60, 150,200, 150)];
        promptView.Image=[UIImage imageNamed:@"滑动提示"];
        [self.view addSubview:promptView];
        [promptView release];
        self.promptCount++;
        PopPromptViewCount *pc=[[PopPromptViewCount alloc]init];
        [pc.arr removeAllObjects];
        [pc.arr addObject:[NSNumber numberWithInt:promptCount]];
        [pc savaData];
        [pc release];
        
        NSTimer *tt;
        tt=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(removePopPromptView) userInfo:nil repeats:NO];
    }
}
-(void)removePopPromptView
{
    [self.promptView removeFromSuperview];
}

//跳转至公司详情界面
-(void)nextPage
{
    CGPoint point = CGPointMake(320, 0);
    scrollV.contentOffset = point;
    
    button.hidden = YES;
    
}

#pragma mark - tabBarButton tapped

-(void)joinjob
{
    NSLog(@"申请职位");
    IsLogin *logInFlag=[IsLogin defaultIsLogin];
    if(logInFlag.isLogin==YES)//如果用户已登录
    {
        applyTapnumber++;
        if(applyTapnumber==1)
        {
            ApplyProcess *aApply=[ApplyProcess Apply];
            self.delegate=aApply;
            NSArray *arr=[NSArray arrayWithObject:self.job.jobNumber];
            [self.delegate singleApply:arr];
        }
        else
        {
            UIAlertView *moreApplyAlert=[[UIAlertView alloc]init];
            [moreApplyAlert setMessage:@"您已经申请过了"];
            [moreApplyAlert addButtonWithTitle:@"取消"];
            [moreApplyAlert show];
            [moreApplyAlert release];
        }
    }
    else//用户未登陆
    {
        UIAlertView *unLogIn=[[UIAlertView alloc]initWithTitle:@"您未登录" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登陆", nil];
        unLogIn.tag=1;
        [unLogIn show];
        [unLogIn release];
    }
    
}

//收藏职位
-(void)backupjob
{
    IsLogin *isLg=[[IsLogin defaultIsLogin]init];
    
    if (isLg.isLogin) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CollectJob:) name:@"收藏职位" object:nil];
        [CollectJob CollectJobWithUticket:isLg.uticket JobNumber:self.job.jobNumber];
    }else
    {
        UIAlertView *av=[[UIAlertView alloc]initWithTitle:nil message:@"您需要登录后才可继续操作，是否决定登陆？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [av show];
    }
}

//推荐职位
-(void)samejob
{
    A1ShowTable *vc=[[A1ShowTable alloc]init];
    vc.jobNumber=self.job.jobNumber;
    vc.dataSourseSign=3;
    [self.navigationController pushViewController:vc animated:YES];
}

//查看地图
-(void)jobmap
{
    
    A1MapVC *mc = [[A1MapVC alloc]init];
    mc.longitude = self.jD.latitude;
    mc.latitude = self.jD.longitude;
    mc.companyName = self.jD.companyName;
    mc.jobName = self.jD.jobTitle;
    [self.navigationController pushViewController:mc animated:YES];
    [mc release];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1)//未登录界面
    {
        if(buttonIndex==0)
        {
            NSLog(@"放弃");
        }
        else
        {
            NSLog(@"登陆");
            LoginViewController *logInVC=[[LoginViewController alloc]init];
            logInVC.tag=4;
            [self.navigationController pushViewController:logInVC animated:YES];
        }
    }
    else
    {
        if (buttonIndex==1) {
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginedCollectJob) name:@"登陆后收藏" object:nil];
            LoginViewController *lv=[[LoginViewController alloc]init];
            lv.tag=2;
            [self.navigationController pushViewController:lv animated:YES];
        }
    }
}

-(void)loginedCollectJob
{
    IsLogin *isLg=[[IsLogin defaultIsLogin]init];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CollectJob:) name:@"收藏职位" object:nil];
    [CollectJob CollectJobWithUticket:isLg.uticket JobNumber:self.job.jobNumber];
}

-(void)CollectJob:(NSNotification *)not
{
    NSDictionary *dic=[not userInfo];
    NSString *result=[dic objectForKey:@"result"];
    NSString *message=[dic objectForKey:@"message"];
    if ([result isEqualToString:@"1"])
    {
        UIAlertView *av=[[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        [av release];
    }
    else if([result isEqualToString:@"5"])
    {
        IsLogin *isLg=[[IsLogin defaultIsLogin]init];
        isLg.isLogin=NO;
        [self backupjob];
    }
    else
    {
        UIAlertView *av=[[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        [av release];
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)didSelected:(int)index
{
    switch (index) {
        case 0:
            //首页
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
            break;
        case 1:
            //申请
        {
            [self joinjob];
        }
            break;
        case 2:
            //收藏
        {
            [self backupjob];
        }
            break;
        case 3:
            //查看位置
        {
            [self jobmap];
        }
            break;
        case 4:
            //相似职位
        {
            [self samejob];
        }
            break;
        default:
            break;
    }
    
}


@end
