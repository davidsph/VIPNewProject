//
//  A1PopMenu.h
//  testMenu
//
//  Created by Ibokan on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A1PopMenuPro.h"


@interface A1PopMenu : UIImageView<A1PopMenuPro>
{
    int popCount;
}
@property (assign,nonatomic)id<A1PopMenuPro>delegate;
@property (assign,nonatomic)BOOL isMovedSign;
@property (retain,nonatomic)UIView *view;
@property (retain,nonatomic)UIImageView *imageV,*imageView;
@property (retain,nonatomic)NSMutableArray *btnArr,*btnNameArr;
@property (retain,nonatomic)UIImageView *semllView;

-(id)initWithButtonName:(NSMutableArray *)arr;
-(void)loadMenu;
-(void)removeMenu;
-(void)popSemllView;
@end
