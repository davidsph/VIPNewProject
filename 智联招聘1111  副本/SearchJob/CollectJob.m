//
//  CollectJob.m
//  SearchJob
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CollectJob.h"
#import "DNWrapper.h"
#import "GDataXMLNode.h"

@implementation CollectJob

@synthesize receiveData;

-(void)dealloc
{
    [self.receiveData release];
    [super dealloc];
}

+(void)CollectJobWithUticket:(NSString *)aUticket JobNumber:(NSString *)aJobNumber
{
    CollectJob *cj=[[[CollectJob alloc]init]autorelease];
    [cj CollectJobWithUticket:aUticket JobNumber:aJobNumber];
}
-(void)CollectJobWithUticket:(NSString *)aUticket JobNumber:(NSString *)aJobNumber
{
    
    NSString * urlStr=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/job/collectposition.aspx?uticket=%@&job_number=%@",aUticket,aJobNumber]; 
    urlStr=[DNWrapper getMD5String:urlStr];
    NSURL *url=[[NSURL alloc]initWithString:urlStr];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [url release];
    NSURLConnection *connection;
    connection=[[NSURLConnection alloc]initWithRequest:request delegate:self]; 
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receiveData=[NSMutableData data];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receiveData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   NSString *str=[[NSString alloc]initWithData:self.receiveData encoding:NSUTF8StringEncoding];
   GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:str options:0 error:nil];
   GDataXMLElement *root=[document rootElement];
    GDataXMLElement *result=[[root children]objectAtIndex:0];
    GDataXMLElement *message=[[root children]objectAtIndex:1];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[result stringValue],@"result",[message stringValue],@"message", nil];
    NSNotification *not=[NSNotification notificationWithName:@"收藏职位" object:self userInfo:dic];
    [[NSNotificationCenter defaultCenter]postNotification:not];

}



@end










