//
//  LIistItemsForCompany.m
//  LookAtMyJLi
//
//  Created by david on 12-10-17.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import "LIistItemsForCompany.h"

@implementation LIistItemsForCompany
@synthesize companyName;
@synthesize companyNumber;
@synthesize companySize;
@synthesize company_location;
@synthesize date_show;

- (id) initCompanyNumber:(NSString *) NewcompanyNumber andCompamyName:(NSString *) newCompanyName andCompanySize:(NSString *) newCompanySize andCompany_location:(NSString *) newCompany_location andDate_show:(NSString  *) newDate_show{
    
    if (self=[super init]) {
        
        self.companySize=newCompanySize;
        self.companyName = newCompanyName;
        self.company_location = newCompany_location;
        self.companyNumber = NewcompanyNumber;
        self.date_show = newDate_show;
      }
    
    return self; 
    
}

@end
