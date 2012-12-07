//
//  QueryConditions.h
//  SalarySearch
//
//  Created by Ibokan on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//********************自定义一个封装类********************//

@interface QueryConditions : NSObject

//**********Propertys******

//所有节点为name的值存放一个数组
//所有的地区（文本值）
@property(nonatomic,retain)NSMutableArray  *citysName;
//所有的行业（文本值）
@property(nonatomic,retain)NSMutableArray  *industrysName;
//所有的企业性质（文本值）
@property(nonatomic,retain)NSMutableArray  *corppropertysName;
//所有的职位类别（文本值）
@property(nonatomic,retain)NSMutableArray  *jobcatsName;
//所有的职位级别（文本值）
@property(nonatomic,retain)NSMutableArray  *joblevelsName;
//所有的学历（文本值）
@property(nonatomic,retain)NSMutableArray  *educationsName;


//所有节点为id的值存放一个数组
//所有的地区ID（ID值）
@property(nonatomic,retain)NSMutableArray  *citysID;
//所有的地区行业（ID值）
@property(nonatomic,retain)NSMutableArray  *industrysID;
//所有的企业性质ID（ID值）
@property(nonatomic,retain)NSMutableArray  *corppropertysID;
//所有的职位类别ID（ID值）
@property(nonatomic,retain)NSMutableArray  *jobcatsID;
//所有的职位级别ID（ID值）
@property(nonatomic,retain)NSMutableArray  *joblevelsID;
//所有的学历ID（ID值）
@property(nonatomic,retain)NSMutableArray  *educationsID;



//********Methods******

-(void)prepareForAllQueryConditions;//准备初始化所有的条件数组
@end
