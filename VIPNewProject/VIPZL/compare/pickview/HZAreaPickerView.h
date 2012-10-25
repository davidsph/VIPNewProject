//
//  HZAreaPickerView.h
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZLocation.h"

typedef enum {
    HZAreaPickerWithStateAndCity,
    HZAreaPickerWithStateAndCityAndDistrict
} HZAreaPickerStyle;

@class HZAreaPickerView;
@class DavidCompareType;

//代理
@protocol HZAreaPickerDelegate <NSObject>


- (void)pickerDidClickCompareBn:(HZAreaPickerView *) picker;

@optional

- (void)pickerDidChaneStatus:(HZAreaPickerView *)picker;

@end

@interface HZAreaPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (retain, nonatomic) id <HZAreaPickerDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIPickerView *locatePicker;
@property (retain, nonatomic) HZLocation *locate;
@property (nonatomic) HZAreaPickerStyle pickerStyle;
@property(nonatomic,retain)DavidCompareType *compareCondition; //比较条件

- (IBAction)compareSalary:(id)sender;



//初始化方法
- (id)initWithStyle:(HZAreaPickerStyle)pickerStyle delegate:(id <HZAreaPickerDelegate>)delegate;
//显示 
- (void)showInView:(UIView *)view;

//取消显示
- (void)cancelPicker;

@end
