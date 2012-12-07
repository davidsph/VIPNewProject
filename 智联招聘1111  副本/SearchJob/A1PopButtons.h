//
//  A1PopButtons.h
//  testMenu
//
//  Created by Ibokan on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A1PopMenuPro.h"

@interface A1PopButtons : UIImageView<A1PopMenuPro>
{
    int btnCount;
}
@property (assign,nonatomic)id<A1PopMenuPro>delegate,delegate1;

@property (retain,nonatomic)UIImageView *contentImageView;//
@property (assign,nonatomic)CGPoint startPoint,endPoint,nearPoint,farPoint;//开始点，结束点，近的点，远的点

-(id)initWithImageName:(NSString *)imageName andTag:(int )aTag andButtonCounts:(int )aBtnCount andStartPoint:(CGPoint)aPoint;//定义相应的初始化方法
-(void)setPostion;


@end
