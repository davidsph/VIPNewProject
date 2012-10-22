//
//  XMLAnalysis.h
//  XMLAnalysis
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLAnalysis : NSObject
+(NSMutableArray*)XMLAnalysisProvince;
+(NSMutableArray*)XMLAnalysisCity:(NSString*)city;
+ (NSMutableArray*)XMLAnalysisJob;
+ (NSMutableArray*)XMLAnalysisSmallJob:(NSString*)smallJob;
+(NSMutableArray*)XMLAnalysisIndustry;
+(NSMutableArray*)XMLAnalysisPublishTime;
+(NSMutableArray*)XMLAnalysisWorkExperience;
+(NSMutableArray*)XMLAnalysisDegree;
+(NSMutableArray*)XMLAnalysisCompanyQuality;
+(NSMutableArray*)XMLAnalysisCompanyScale;
+(NSMutableArray*)XMLAnalysismonthPay;





@end
