//
//  QueryConditions.m
//  SalarySearch
//
//  Created by Ibokan on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QueryConditions.h"
#import "GDataXMLNode.h"
@implementation QueryConditions

@synthesize citysName,industrysName,corppropertysName,jobcatsName,joblevelsName,educationsName;
@synthesize citysID,industrysID,corppropertysID,jobcatsID,joblevelsID,educationsID;


- (void)dealloc
{
    [self.citysName release];
    [self.industrysName release];
    [self.corppropertysName release];
    [self.jobcatsName release];
    [self.joblevelsName release];
    [self.educationsName release];
    
    [self.citysID release];
    [self.industrysID release];
    [self.corppropertysID release];
    [self.jobcatsID release];
    [self.joblevelsID release];
    [self.educationsID release];
    
    [super dealloc];
}
-(void)prepareForAllQueryConditions
{
   self. citysName =[[NSMutableArray alloc] init];
    self.industrysName =[[NSMutableArray alloc] init];
    self.educationsName =[[NSMutableArray alloc] init];
    self.jobcatsName =[[NSMutableArray alloc] init];
    self.joblevelsName =[[NSMutableArray alloc] init];
    self.corppropertysName =[[NSMutableArray alloc] init];
    
    self.citysID =[[NSMutableArray alloc] init];
    self.corppropertysID =[[NSMutableArray alloc] init];
    self.educationsID =[[NSMutableArray alloc] init];
    self.jobcatsID =[[NSMutableArray alloc] init];
    self.joblevelsID =[[NSMutableArray alloc] init];
    self.industrysID =[[NSMutableArray alloc] init];
    
    
    //把查询条件接口放在本地
    NSString  *string =[NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"querylist.service" ofType:@"xml" ]encoding:NSUTF8StringEncoding error:nil];
    
    GDataXMLDocument  *document =[[GDataXMLDocument alloc] initWithXMLString:string options:0 error:nil];
    
    GDataXMLElement  *root =[document rootElement];
    
    
    NSArray *  searchCondition =[root nodesForXPath:@"citys/city/name" error:nil];
    for (GDataXMLElement  *element in searchCondition) {
        [self.citysName addObject:[element stringValue]];
    }
    NSArray *  searchCondition2 =[root nodesForXPath:@"citys/city/id" error:nil];
    for (GDataXMLElement  *element in searchCondition2) {
        [self.citysID addObject:[element stringValue]];
    }
    
    
    searchCondition =[root nodesForXPath:@"corppropertys/corpproperty/name" error:nil];
    for (GDataXMLElement  *element in searchCondition) {
        [self. corppropertysName addObject:[element stringValue]];
    }
    searchCondition2 =[root nodesForXPath:@"corppropertys/corpproperty/id" error:nil];
    for (GDataXMLElement  *element in searchCondition2) {
        [self. corppropertysID addObject:[element stringValue]];
    }
    
    searchCondition =[root nodesForXPath:@"educations/education/name" error:nil];
    for (GDataXMLElement  *element in searchCondition) {
        [self. educationsName addObject:[element stringValue]];
    } 
    searchCondition2 =[root nodesForXPath:@"educations/education/id" error:nil];
    for (GDataXMLElement  *element in searchCondition2) {
        [self. educationsID addObject:[element stringValue]];
    }
    
    searchCondition =[root nodesForXPath:@"jobcats/jobcat/name" error:nil];
    for (GDataXMLElement  *element in searchCondition) {
        [self. jobcatsName addObject:[element stringValue]];
    }
    searchCondition2 =[root nodesForXPath:@"jobcats/jobcat/id" error:nil];
    for (GDataXMLElement  *element in searchCondition2) {
        [self. jobcatsID addObject:[element stringValue]];
    }
    
    searchCondition =[root nodesForXPath:@"joblevels/joblevel/name" error:nil];
    for (GDataXMLElement  *element in searchCondition) {
        [self. joblevelsName addObject:[element stringValue]];
    }
    searchCondition2 =[root nodesForXPath:@"joblevels/joblevel/id" error:nil];
    for (GDataXMLElement  *element in searchCondition2) {
        [self. joblevelsID addObject:[element stringValue]];
    }
    
    searchCondition =[root nodesForXPath:@"industrys/industry/name" error:nil];
    for (GDataXMLElement  *element in searchCondition) {
        [self. industrysName addObject:[element stringValue]];
    }
    searchCondition2 =[root nodesForXPath:@"industrys/industry/id" error:nil];
    for (GDataXMLElement  *element in searchCondition2) {
        [self. industrysID addObject:[element stringValue]];
    }

}
@end
