//
//  SearchJob.m
//  search智联
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchJob.h"
#import "GDataXMLNode.h"

@implementation SearchJob

@synthesize receiveData,connection1,connection2;

@synthesize type=_type,schJobType=_schJobType,subJobType=_subJobType,industry=_industry,city=_city,keyWord=_keyWord,dataRefresh=_dataRefresh,eduLevel=_eduLevel,jobLocation=_jobLocation,pointRanger=_pointRanger,workingExp=_workingExp,companyType=_companyType,companySize=_companySize,emplType=_emplType,salaryFrom=_salaryFrom,salaryTo=_salaryTo,sort=_sort,pageSize=_pageSize,page=_page,date=_date;

-(id)initWithType:(int) type schJobType:(NSString *) schJobType subJobType:(int) subJobType industry:(NSString *) industry city:(NSString *) city keyWord:(NSString *) keyWord dataRefresh:(int)dataRefresh eduLevel:(int) eduLevel jobLocation:(NSString *) jobLocation pointRanger:(NSString *) pointRanger workingExp:(NSString *) workingExp companyType:(NSString *) companyType companySize:(NSString *) companySize emplType:(NSString *) emplType salaryFrom:(int) salaryFrom salaryTo:(int) salaryTo sort:(NSString *) sort date:(NSString *)date
{
    if (self=[super init]) 
    {
        self.type=type;
        self.schJobType=schJobType;
        self.subJobType=subJobType;
        self.industry=industry;
        self.city=city;
        self.keyWord=keyWord;
        self.dataRefresh=dataRefresh;
        self.eduLevel=eduLevel;
        self.jobLocation=jobLocation;
        self.pointRanger=pointRanger;
        self.workingExp=workingExp;
        self.companyType=companyType;
        self.companySize=companySize;
        self.emplType=emplType;
        self.salaryFrom=salaryFrom;
        self.salaryTo=salaryTo;
        self.sort=sort;
        self.date = date;
   
    }
    return self;
}

-(id)initWithschJobType:(NSString *) schJobType industry:(NSString *) industry city:(NSString *) city keyWord:(NSString *) keyWord pointRanger:(NSString *) pointRanger sort:(NSString *) sort 
{
    if (self=[super init]) 
    {
        self.schJobType=schJobType;
        self.industry=industry;
        self.city=city;
        self.keyWord=keyWord;
        self.pointRanger=pointRanger;
        self.sort=sort;
    }
    return self;
}


-(NSMutableArray *)quickSearchBySYNWith:(int)aPage Pagesize:(int)aPageSize//快速搜索（同步）
{  
    NSString *str1;
    if (self.schJobType!=nil) {
        str1=[NSString stringWithFormat:@"&schJobType=%@",[self.schJobType stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str1=@"";
    }
    NSString *str2;
    if (self.industry!=nil) {
        str2=[NSString stringWithFormat:@"&industry=%@",[self.industry stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str2=@"";
    }
    NSString *str3;
    if (self.city!=nil) {
        str3=[NSString stringWithFormat:@"&city=%@",[self.city stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str3=@"";
    }
    NSString *str4;
    if (self.keyWord!=nil) {
        str4=[NSString stringWithFormat:@"&key_word=%@",[self.keyWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str4=@"";
    }
    NSString *str5;
    if (self.pointRanger!=nil) {
        str5=[NSString stringWithFormat:@"&point_ranger=%@",[self.pointRanger stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str5=@"";
    }
    NSString *str6;
    if (self.sort!=nil) {
        str6=[NSString stringWithFormat:@"&sort=%@",[self.sort stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str6=@"";
    }    
    
    NSString *quickSearch=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/search/searchjob.aspx?type=0%@%@%@%@%@%@&Page=%d&Pagesize=%d",str1,str2,str3,str4,str5,str6,aPage,aPageSize];
    quickSearch=[DNWrapper getMD5String:quickSearch];    
    
    NSURL *url=[[NSURL alloc]initWithString:quickSearch];    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response=nil;
    NSError *error=nil;
    NSData *receivedData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];    
    NSString *str=[[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    return  [SearchJob analysisStr:str];
    
}
-(NSMutableArray *)advancedSearchBySYNWith:(int)aPage Pagesize:(int)aPageSize//高级搜索（同步）
{  
    NSString *str1;
    if (self.schJobType!=nil) {
        str1=[NSString stringWithFormat:@"&schJobType=%@",[self.schJobType stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str1=@"";
    }
    NSString *str2;
    if (self.industry!=nil) {
        str2=[NSString stringWithFormat:@"&industry=%@",[self.industry stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str2=@"";
    }
    NSString *str3;
    if (self.city!=nil) {
        str3=[NSString stringWithFormat:@"&city=%@",[self.city stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str3=@"";
    }
    NSString *str4;
    if (self.keyWord!=nil) {
        str4=[NSString stringWithFormat:@"&key_word=%@",[self.keyWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str4=@"";
    }
    NSString *str5;
    if (self.pointRanger!=nil) {
        str5=[NSString stringWithFormat:@"&point_ranger=%@",[self.pointRanger stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str5=@"";
    }
    NSString *str6;
    if (self.sort!=nil) {
        str6=[NSString stringWithFormat:@"&sort=%@",[self.sort stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else  
    {
        str6=@"";
    }    
    NSString *str7;
    if (self.dataRefresh!=0) {
        str7=[NSString stringWithFormat:@"&data_refresh=%d",self.dataRefresh ];
    }
    else
    {
        str7=@"";
    }    
    NSString *str8;
    if (self.eduLevel!=0) {
        str8=[NSString stringWithFormat:@"&edu_level=%d",self.eduLevel];
    }
    else
    {
        str8=@"";
    }    
    NSString *str9;
    if (self.jobLocation!=nil) {
        str9=[NSString stringWithFormat:@"&joblocation=%@",[self.jobLocation stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str9=@"";
    }    
    
    NSString *str10;
    if (self.workingExp!=nil) {
        str10=[NSString stringWithFormat:@"&workingexp=%@",[self.workingExp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str10=@"";
    }    
    NSString *str11;
    if (self.companyType!=nil) {
        str11=[NSString stringWithFormat:@"&companytype=%@",[self.companyType stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str11=@"";
    }    
    NSString *str12;
    if (self.companySize!=nil) {
        str12=[NSString stringWithFormat:@"&companysize=%@",[self.companySize stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str12=@"";
    }    
    NSString *str13;
    if (self.emplType!=nil) {
        str13=[NSString stringWithFormat:@"&emplType=%@",[self.emplType stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str13=@"";
    }    
    NSString *str14;
    if (self.salaryFrom!=0) {
        str14=[NSString stringWithFormat:@"&salaryfrom=%d",self.salaryFrom ];
    }
    else
    {
        str14=@"";
    }  
    NSString *str15;
    if (self.salaryTo!=0) {
        str15=[NSString stringWithFormat:@"&salaryto=%d",self.salaryTo];
    }
    else
    {
        str15=@"";
    }  
    
    NSString *quickSearch=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/search/searchjob.aspx?type=0%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@&Page=%d&Pagesize=%d",str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14,str15,aPage,aPageSize];
    quickSearch=[DNWrapper getMD5String:quickSearch];    
    
    NSURL *url=[[NSURL alloc]initWithString:quickSearch];    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response=nil;
    NSError *error=nil;
    NSData *receivedData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];    
    NSString *str=[[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    return  [SearchJob analysisStr:str];
    
    
}

+(NSMutableArray *)alikeJobBySYN:(NSString *)jobNumber page:(int)aPage pageSize:(int)aPageSize//查找相似职位(同步)
{
    
    NSString *alikeJob=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/search/searchsamejob.aspx?Job_number=%@&pagesize=%d&page=%d",jobNumber,aPageSize,aPage];
    alikeJob=[DNWrapper getMD5String:alikeJob];    
    
    NSURL *url=[[NSURL alloc]initWithString:alikeJob];    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLResponse *response=nil;
    NSError *error=nil;
    NSData *receivedData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];    
    NSString *str=[[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
    return  [SearchJob analysisStrForAlikeJob:str];
    
}



-(void)quickSearchWith:(int)aPage Pagesize:(int)aPageSize//快速搜索（异步）
{  

    self.page=aPage;
    NSString *str1;
    if (self.schJobType!=nil) {
        str1=[NSString stringWithFormat:@"&schJobType=%@",[self.schJobType stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str1=@"";
    }
    NSString *str2;
    if (self.industry!=nil) {
        str2=[NSString stringWithFormat:@"&industry=%@",[self.industry stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str2=@"";
    }
    NSString *str3;
    if (self.city!=nil) {
        str3=[NSString stringWithFormat:@"&city=%@",[self.city stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str3=@"";
    }
    NSString *str4;
    if (self.keyWord!=nil) {
        str4=[NSString stringWithFormat:@"&key_word=%@",[self.keyWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str4=@"";
    }
    NSString *str5;
    if (self.pointRanger!=nil) {
        str5=[NSString stringWithFormat:@"&point_ranger=%@",[self.pointRanger stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str5=@"";
    }
    NSString *str6;
    if (self.sort!=nil) {
        str6=[NSString stringWithFormat:@"&sort=%@",[self.sort stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str6=@"";
    }    
    
    NSString *quickSearch=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/search/searchjob.aspx?type=0%@%@%@%@%@%@&Page=%d&Pagesize=%d",str1,str2,str3,str4,str5,str6,aPage,aPageSize];
     quickSearch=[DNWrapper getMD5String:quickSearch];    
    
    NSURL *url=[[NSURL alloc]initWithString:quickSearch];    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    self.connection1=[[NSURLConnection alloc]initWithRequest:request delegate:self];

}

-(void)advancedSearchWith:(int)aPage Pagesize:(int)aPageSize//高级搜索（异步）
{  
    self.page=aPage;
    
    NSString *str1;
    if (self.schJobType!=nil) {
        str1=[NSString stringWithFormat:@"&schJobType=%@",[self.schJobType stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str1=@"";
    }
    NSString *str2;
    if (self.industry!=nil) {
        str2=[NSString stringWithFormat:@"&industry=%@",[self.industry stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str2=@"";
    }
    NSString *str3;
    if (self.city!=nil) {
        str3=[NSString stringWithFormat:@"&city=%@",[self.city stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str3=@"";
    }
    NSString *str4;
    if (self.keyWord!=nil) {
        str4=[NSString stringWithFormat:@"&key_word=%@",[self.keyWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str4=@"";
    }
    NSString *str5;
    if (self.pointRanger!=nil) {
        str5=[NSString stringWithFormat:@"&point_ranger=%@",[self.pointRanger stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str5=@"";
    }
    NSString *str6;
    if (self.sort!=nil) {
        str6=[NSString stringWithFormat:@"&sort=%@",[self.sort stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else  
    {
        str6=@"";
    }    
    NSString *str7;
    if (self.dataRefresh!=0) {
        str7=[NSString stringWithFormat:@"&data_refresh=%d",self.dataRefresh ];
    }
    else
    {
        str7=@"";
    }    
    NSString *str8;
    if (self.eduLevel!=0) {
        str8=[NSString stringWithFormat:@"&edu_level=%d",self.eduLevel];
    }
    else
    {
        str8=@"";
    }    
    NSString *str9;
    if (self.jobLocation!=nil) {
        str9=[NSString stringWithFormat:@"&joblocation=%@",[self.jobLocation stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str9=@"";
    }    
    
    NSString *str10;
    if (self.workingExp!=nil) {
        str10=[NSString stringWithFormat:@"&workingexp=%@",[self.workingExp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str10=@"";
    }    
    NSString *str11;
    if (self.companyType!=nil) {
        str11=[NSString stringWithFormat:@"&companytype=%@",[self.companyType stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str11=@"";
    }    
    NSString *str12;
    if (self.companySize!=nil) {
        str12=[NSString stringWithFormat:@"&companysize=%@",[self.companySize stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str12=@"";
    }    
    NSString *str13;
    if (self.emplType!=nil) {
        str13=[NSString stringWithFormat:@"&emplType=%@",[self.emplType stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        str13=@"";
    }    
    NSString *str14;
    if (self.salaryFrom!=0) {
        str14=[NSString stringWithFormat:@"&salaryfrom=%d",self.salaryFrom ];
    }
    else
    {
        str14=@"";
    }  
    NSString *str15;
    if (self.salaryTo!=0) {
        str15=[NSString stringWithFormat:@"&salaryto=%d",self.salaryTo];
    }
    else
    {
        str15=@"";
    }  
    
    NSString *quickSearch=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/search/searchjob.aspx?type=0%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@&Page=%d&Pagesize=%d",str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14,str15,aPage,aPageSize];
    quickSearch=[DNWrapper getMD5String:quickSearch];    
    
    NSURL *url=[[NSURL alloc]initWithString:quickSearch];    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
   self.connection1=[[NSURLConnection alloc]initWithRequest:request delegate:self];
}

+(void)alikeJob:(NSString *)jobNumber page:(int)aPage pageSize:(int)aPageSize//查找相似职位（异步）
{
    SearchJob *sj=[[SearchJob alloc]init];
    sj.page=aPage;
    sj.pageSize=aPageSize;
    [sj alikeJob:jobNumber page:aPage pageSize:aPageSize];
}

-(void)alikeJob:(NSString *)jobNumber page:(int)aPage pageSize:(int)aPageSize
{
    
    NSString *alikeJob=[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/search/searchsamejob.aspx?Job_number=%@&pagesize=%d&page=%d",jobNumber,aPageSize,aPage];
    alikeJob=[DNWrapper getMD5String:alikeJob];    
    
    NSURL *url=[[NSURL alloc]initWithString:alikeJob];    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
   self.connection2=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
}



//数据解析

+(NSMutableArray *)analysisStr:(NSString *)str
{
    NSMutableArray *arr=[NSMutableArray arrayWithCapacity:5];
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:str options:0 error:nil];
    GDataXMLElement *root=[document rootElement];//获得根节点
    GDataXMLElement *result=[[root children]objectAtIndex:0];
    
    for (int i=0;i<[result childCount];i++) 
    {
        GDataXMLElement *position=[[result children]objectAtIndex:i];
        
        GDataXMLElement *job_number=[[position elementsForName:@"job_number"]objectAtIndex:0];        
        NSString *jobNumber=[job_number stringValue];
        
        GDataXMLElement *job_title=[[position elementsForName:@"job_title"]objectAtIndex:0];        
        NSString *jobTitle=[job_title stringValue];
        
        GDataXMLElement *job_city=[[position elementsForName:@"job_city"]objectAtIndex:0];        
        NSString *jobCity=[job_city stringValue];        
        
        GDataXMLElement *job_city_region=[[position elementsForName:@"job_city_region"]objectAtIndex:0];        
        NSString *jobCityRegion=[job_city_region stringValue]; 
        
        GDataXMLElement *company_id=[[position elementsForName:@"company_id"]objectAtIndex:0];        
        NSString *companyId=[company_id stringValue]; 
        
        GDataXMLElement *company_number=[[position elementsForName:@"company_number"]objectAtIndex:0];        
        NSString *companyNumber=[company_number stringValue];
        
        GDataXMLElement *company_name=[[position elementsForName:@"company_name"]objectAtIndex:0];        
        NSString *companyName=[company_name stringValue];
        
        GDataXMLElement *country_id=[[position elementsForName:@"country_id"]objectAtIndex:0];        
        NSString *countryId=[country_id stringValue];
        
        GDataXMLElement *province_id=[[position elementsForName:@"province_id"]objectAtIndex:0];        
        NSString *provinceId=[province_id stringValue];
        
        GDataXMLElement *city_id=[[position elementsForName:@"city_id"]objectAtIndex:0];        
        NSString *cityId=[city_id stringValue];
        
        GDataXMLElement *company_short_name=[[position elementsForName:@"company_short_name"]objectAtIndex:0];        
        NSString *companyShortName=[company_short_name stringValue];        
        
        GDataXMLElement *date_opening=[[position elementsForName:@"date_opening"]objectAtIndex:0];        
        NSString *dateOpening=[date_opening stringValue];        
        
        GDataXMLElement *important=[[position elementsForName:@"important"]objectAtIndex:0];        
        NSString *importants=[important stringValue];        
        
        
        
        A1Job *job=[[A1Job alloc]initWithJobNumber:jobNumber JobTitle:jobTitle JobCity:jobCity JobCityRegion:jobCityRegion CompanyId:companyId CompanyNumber:companyNumber CompanyName:companyName CountryId:countryId ProvinceId:provinceId CityId:cityId CompanyShortName:companyShortName OpeningDate:dateOpening Important:importants];
        
        [arr addObject:job];
        
    }
    
    return  arr;
    
}

+(NSMutableArray *)analysisStrForAlikeJob:(NSString *)str//相似职位解析数据
{
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:str options:0 error:nil];
    GDataXMLElement *root=[document rootElement];//获得根节点
    
    for (int i=0;i<[root childCount];i++) 
    {
        GDataXMLElement *position=[[root children]objectAtIndex:i];
        
        GDataXMLElement *job_number=[[position elementsForName:@"job_number"]objectAtIndex:0];        
        NSString *jobNumber=[job_number stringValue];
        
        GDataXMLElement *job_title=[[position elementsForName:@"job_title"]objectAtIndex:0];        
        NSString *jobTitle=[job_title stringValue];
        
        GDataXMLElement *job_city=[[position elementsForName:@"job_city"]objectAtIndex:0];        
        NSString *jobCity=[job_city stringValue];        
        
        GDataXMLElement *job_city_region=[[position elementsForName:@"job_city_region"]objectAtIndex:0];        
        NSString *jobCityRegion=[job_city_region stringValue]; 
        
        GDataXMLElement *company_id=[[position elementsForName:@"company_id"]objectAtIndex:0];        
        NSString *companyId=[company_id stringValue]; 
        
        GDataXMLElement *company_number=[[position elementsForName:@"company_number"]objectAtIndex:0];        
        NSString *companyNumber=[company_number stringValue];
        
        GDataXMLElement *company_name=[[position elementsForName:@"company_name"]objectAtIndex:0];        
        NSString *companyName=[company_name stringValue];
        
        GDataXMLElement *country_id=[[position elementsForName:@"country_id"]objectAtIndex:0];        
        NSString *countryId=[country_id stringValue];
        
        GDataXMLElement *province_id=[[position elementsForName:@"province_id"]objectAtIndex:0];        
        NSString *provinceId=[province_id stringValue];
        
        GDataXMLElement *city_id=[[position elementsForName:@"city_id"]objectAtIndex:0];        
        NSString *cityId=[city_id stringValue];
        
        GDataXMLElement *company_short_name=[[position elementsForName:@"company_short_name"]objectAtIndex:0];        
        NSString *companyShortName=[company_short_name stringValue];        
        
        GDataXMLElement *date_opening=[[position elementsForName:@"date_opening"]objectAtIndex:0];        
        NSString *dateOpening=[date_opening stringValue];        
        
        GDataXMLElement *important=[[position elementsForName:@"important"]objectAtIndex:0];        
        NSString *importants=[important stringValue];        
        
        
        
        A1Job *job=[[A1Job alloc]initWithJobNumber:jobNumber JobTitle:jobTitle JobCity:jobCity JobCityRegion:jobCityRegion CompanyId:companyId CompanyNumber:companyNumber CompanyName:companyName CountryId:countryId ProvinceId:provinceId CityId:cityId CompanyShortName:companyShortName OpeningDate:dateOpening Important:importants];
        
        [arr addObject:job];
        
    }
    return  arr;   
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
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    if (self.connection1==connection)
    { 
        arr=[SearchJob analysisStr:str];
    }
    else if(self.connection2==connection)
    {
        arr=[SearchJob analysisStrForAlikeJob:str];
    }
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:arr,@"arr", nil];
    NSNotification *not=nil;
    if (self.page==1) {
        not=[NSNotification notificationWithName:@"搜索职位结果" object:self userInfo:dic];
    }
    else
    {
        not=[NSNotification notificationWithName:@"更多搜索职位结果" object:self userInfo:dic];
    }
   [[NSNotificationCenter defaultCenter]postNotification:not];
   
}

+(NSMutableArray *)findAllJobInDataBase
{
    NSMutableArray * histroyJobArray=nil;
    sqlite3 * db=[A1HistroyDB openDB];
    sqlite3_stmt *stmt=nil;
    int result=sqlite3_prepare_v2(db, "select*from history ", -1, &stmt, nil);
    if (result==SQLITE_OK) {
        histroyJobArray=[[NSMutableArray alloc]init ];
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            const unsigned char * schJobType=sqlite3_column_text(stmt, 0);
            const unsigned char * industry=sqlite3_column_text(stmt, 1);
            const unsigned char * city=sqlite3_column_text(stmt, 2);
            const unsigned char * keyWord=sqlite3_column_text(stmt, 3);
            const unsigned char * dataRefresh=sqlite3_column_text(stmt, 4);
            const unsigned char * workingExp=sqlite3_column_text(stmt, 5);
            const unsigned char * companyType=sqlite3_column_text(stmt, 6);
            const unsigned char * companySize=sqlite3_column_text(stmt, 7);
            const unsigned char * salaryFrom=sqlite3_column_text(stmt, 8);
            const unsigned char * salaryTo=sqlite3_column_text(stmt, 9);
            const unsigned char * sort=sqlite3_column_text(stmt, 10);
            const unsigned char * pointRange=sqlite3_column_text(stmt, 11);
            const unsigned char * date=sqlite3_column_text(stmt, 12);

            NSString * schJobTypeString=[NSString stringWithUTF8String:(const char *)schJobType];
            if ([schJobTypeString isEqualToString: @"(null)"]) 
            {
                schJobTypeString=@"";
            }
            NSString * industryString=[NSString stringWithUTF8String:(const char *)industry];
            if ([industryString isEqualToString:@"(null)"]) 
            {
                industryString=@"";
            }
            NSString * cityString=[NSString stringWithUTF8String:(const char *)city];
            if ([cityString isEqualToString:@"(null)"]) 
            {
                cityString=@"";
            }
            NSString * keyWordString=[NSString stringWithUTF8String:(const char *)keyWord];
            if ([keyWordString isEqualToString:@"(null)"]) 
            {
                keyWordString=@"";
            }
            NSString * dataRefreshString=[NSString stringWithUTF8String:(const char *)dataRefresh];
            if ([dataRefreshString isEqualToString:@"(null)"]) 
            {
                dataRefreshString=@"";
            }
            NSString * workingExpString=[NSString stringWithUTF8String:(const char *)workingExp];
            if ([workingExpString isEqualToString:@"(null)"]) 
            {
                workingExpString=@"";
            }
            NSString * companyTypeString=[NSString stringWithUTF8String:(const char *)companyType];
            if ([companyTypeString isEqualToString:@"(null)"]) 
            {
                companyTypeString=@"";
            }
            NSString * companySizeString=[NSString stringWithUTF8String:(const char *)companySize];
            if ([companySizeString isEqualToString:@"(null)"]) 
            {
                companySizeString=@"";
            }
            NSString * salaryFromString=[NSString stringWithUTF8String:(const char *)salaryFrom];
            if ([salaryFromString isEqualToString:@"(null)"]) 
            {
                salaryFromString=@"";
            }
            NSString * salaryToString=[NSString stringWithUTF8String:(const char *)salaryTo];
            if ([salaryToString isEqualToString:@"(null)"]) 
            {
                salaryToString=@"";
            }
            NSString * sortString=[NSString stringWithUTF8String:(const char *)sort];
            if ([sortString isEqualToString:@"(null)"]) 
            {
                sortString=@"";
            }
            NSString * pointRangeString=[NSString stringWithUTF8String:(const char *)pointRange];
            if ([pointRangeString isEqualToString:@"(null)"]) 
            {
                pointRangeString=@"";
            }
            NSString * dateString=[NSString stringWithUTF8String:(const char *)date];
            if ([dateString isEqualToString:@"(null)"]) 
            {
                dateString=@"";
            }
            SearchJob *job =[[SearchJob alloc]initWithType:1 schJobType:schJobTypeString subJobType:005 industry:industryString city:cityString keyWord:keyWordString dataRefresh:[dataRefreshString intValue] eduLevel:2 jobLocation:nil pointRanger:pointRangeString workingExp:workingExpString companyType:companyTypeString companySize:companySizeString emplType:nil salaryFrom:[salaryFromString intValue] salaryTo:[salaryToString intValue] sort:sortString date:dateString];
            [histroyJobArray addObject:job];
            [job release];
        }
    }
    else
    {
        histroyJobArray=[[NSMutableArray alloc]init];
    }
    sqlite3_finalize(stmt);
    return histroyJobArray;
}
+(void)addSearchJobINDataBaseofschJobType:(NSString *) schJobType  industry:(NSString *) industry city:(NSString *) city keyWord:(NSString *) keyWord dataRefresh:(NSString *)dataRefresh  pointRanger:(NSString *) pointRanger workingExp:(NSString *) workingExp companyType:(NSString *) companyType companySize:(NSString *) companySize salaryFrom:(NSString *) salaryFrom salaryTo:(NSString *) salaryTo sort:(NSString *) sort date:(NSString *)date
{
    sqlite3*db=[A1HistroyDB openDB];
    sqlite3_stmt *stmt=nil;
    int result=sqlite3_prepare_v2(db, [[NSString stringWithFormat:@"insert into history(schJobType,industry,city,keyWord,dataRefresh,workingExp,companyType,companySize,salaryFrom,salaryTo,sort,pointRange,date)values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@') ",schJobType,industry,city,keyWord,dataRefresh,workingExp,companyType,companySize,salaryFrom,salaryTo,sort,pointRanger,date] UTF8String] , -1, &stmt, nil);
    if (result==SQLITE_OK) {
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}
+(void)deleteAllINDatabase
{
    sqlite3*db=[A1HistroyDB openDB];
    sqlite3_stmt *stmt=nil;
    int result=sqlite3_prepare_v2(db, "delete from  history" , -1, &stmt, nil);
    if (result==SQLITE_OK) {
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}
@end







