//
//  Cell.h
//  xiangmu
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface A1FindJobViewCell : UITableViewCell

@property (nonatomic,retain) UILabel * advancedName;  // 客户端cell前边的黑色数据
@property (nonatomic,retain) UILabel * grayName;      // 客户端cell前边的灰色数据
@property (nonatomic,retain) UIImageView * imageView; // cell后边的箭头
@end
