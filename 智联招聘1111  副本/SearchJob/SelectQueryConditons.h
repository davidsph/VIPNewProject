//
//  SelectQueryConditons.h
//  SalarySearch
//
//  Created by Ibokan on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SelectQueryConditons;
@protocol SelectQueryConditonsDelegate <NSObject>

-(void )selectQueryCondition:(SelectQueryConditons  *)selectQueryCondition  atIndexPath:(NSIndexPath *)indexPath;//往前传选中的索引值，

-(void )selectedRowIn:(SelectQueryConditons *)sel;

@end

@interface SelectQueryConditons : UITableViewController


@property(nonatomic,retain)NSMutableArray  *selectedArray ;

@property(nonatomic,assign)id<SelectQueryConditonsDelegate>selectDelegate;

@end
