//
//  A2ResumeView.m
//  LogIn
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A2ResumeView.h"
#import "DNWrapper.h"
#import "IsLogin.h"
#import "GDataXMLNode.h"

@implementation A2ResumeView
@synthesize delegate = _delegate;
@synthesize theResume = _theResume;
@synthesize number = _number;
@synthesize isDefault = _isDefault;
@synthesize setDefalutResumebt = _setDefalutResumebt;
- (id)initWithFrame:(CGRect)frame resume:(Resume *)currentRsm
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.theResume = currentRsm;
        
        UIButton *showButton = [UIButton buttonWithType:UIButtonTypeCustom];
        showButton.frame = CGRectMake(40, 10, 30, 30);
        [showButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [showButton setTitle:currentRsm.rsmShowCount forState:UIControlStateNormal];
        [showButton addTarget:self action:@selector(showButton) forControlEvents:UIControlEventTouchUpInside];
        //showButton.titleLabel.textColor = [UIColor blackColor];
        [self addSubview:showButton];
        
        self.image = [UIImage imageNamed:@"resume_page_bg@2x.png"];
        UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 40, 15)];
        showLabel.text = @"浏览";
        showLabel.backgroundColor = [UIColor clearColor];
        showLabel.textColor = [UIColor blackColor];
        [self addSubview:showLabel];
        [showLabel release];
        
        //刷新按钮
        UIButton *rereshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rereshButton.frame = CGRectMake(135, 10, 22, 22);
        [rereshButton setImage:[UIImage imageNamed:@"reresh_resume_button@2x.png"] forState:UIControlStateNormal];
        [rereshButton setImage:[UIImage imageNamed:@"reresh_resume_button@2x.png"] forState:UIControlStateNormal];
        
        //点击触发刷新方法
        [rereshButton addTarget:self action:@selector(rereshResume) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rereshButton];
        
        UILabel *refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 40, 40, 15)];
        refreshLabel.text = @"刷新";
        refreshLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:refreshLabel];
        [refreshLabel release];
        
        //设置默认简历按钮
        _setDefalutResumebt = [UIButton buttonWithType:UIButtonTypeCustom];
        _setDefalutResumebt.frame = CGRectMake(230, 10, 25, 25);
        if ([self.theResume.rsmLanguage isEqualToString:@"1"]) 
        {
            //如果是默认简历，设为蓝色的标志并且传回它的的numbeer，以便主页将它的标志设为灰色。
            NSLog(@"是默认简历吗？%@",self.theResume.rsmLanguage);
            [_setDefalutResumebt setImage:[UIImage imageNamed:@"resume_selected@2x.png"] forState:UIControlStateNormal];
            if (_delegate != nil && [_delegate respondsToSelector:@selector(sentNumber:)]) {
                [_delegate sentNumber:self.number];
            }
        }
        else{
            [_setDefalutResumebt setImage:[UIImage imageNamed:@"resume_unselected@2x.png"] forState:UIControlStateNormal];
        }
        //点击触发的方法
        [_setDefalutResumebt addTarget:self action:@selector(setDefaultResume) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_setDefalutResumebt];
        
        UILabel *defaultRefumeLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 40, 130, 15)];
        defaultRefumeLabel.text = @"设置默认简历";
        defaultRefumeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:defaultRefumeLabel];
        [defaultRefumeLabel release];
    }
    return self;
}
//点击浏览
- (void)showButton
{
    NSLog(@"推出浏览的公司，以列表展示");
    if (_delegate!= nil && [_delegate respondsToSelector:@selector(pushNewPage:)]) {
        [self.delegate pushNewPage:self.theResume];
    }
}

//刷新方法
- (void)rereshResume
{
    NSLog(@"向服务器提出刷新请求");
    NSString *urlstr1 = @"http://wapinterface.zhaopin.com/iphone/myzhaopin/resume_refresh.aspx?resume_id=123456&uticket=xxxxxxxxxxxxx";
    NSString *urlstr2 = [DNWrapper getMD5String:urlstr1];
    NSLog(@"resumeID = %@",self.theResume.rsmID);
    NSLog(@"resumeNumber = %@",self.theResume.rsmNumber);
    NSLog(@"urlstr2 = %@",urlstr2);
    
    IsLogin *islg = [IsLogin defaultIsLogin];
    NSLog(@"uiticket = %@",islg.uticket);
    
    
}
//设置默认简历触发的方法
- (void)setDefaultResume
{
    NSLog(@"%d",self.isDefault);
    
    if (self.isDefault == NO) {
        IsLogin *islg = [IsLogin defaultIsLogin];
        NSLog(@"向服务器提出设置默认简历请求");
        NSString *url1 = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/setdefaultresume.aspx?resume_id=%@&resume_number=%@&version_number=%@&uticket=%@",self.theResume.rsmID,self.theResume.rsmNumber,self.theResume.rsmVersion,islg.uticket];
        NSString *url2 = [DNWrapper getMD5String:url1];
        NSLog(@"morenjianliqingqiu = %@",url2);
        NSURL *url = [NSURL URLWithString:url2];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        
        //第三步， 连接服务器
        NSURLResponse *response = nil;
        NSError *err = nil;
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        
        NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
        GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:str options:0 error:nil];
        
        GDataXMLElement *root = [document rootElement];//获得根节点
        
        NSArray *children = [root children];
        GDataXMLElement *resultValue = [children objectAtIndex:0];
        GDataXMLElement *message = [children objectAtIndex:1];
        NSLog(@"result = %@",[resultValue stringValue]);
        NSLog(@"message = %@",[message stringValue]);
        
        [_setDefalutResumebt setImage:[UIImage imageNamed:@"resume_selected@2x.png"] forState:UIControlStateNormal];
        
        if (_delegate!=nil&&[_delegate respondsToSelector:@selector(setDefaultResume:) ] ) {
            //把当前view的下标值穿过去。
            [_delegate setDefaultResume:[message stringValue]];
            [_delegate sentNumber:self.number];
        
        }
        NSLog(@"设置了新的默认简历");
        self.isDefault = YES;
    }
    else
    {
        
    }
    
}

@end
