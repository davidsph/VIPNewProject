//
//  HZAreaPickerView.m
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import "HZAreaPickerView.h"
#import <QuartzCore/QuartzCore.h>
#import "SaveDataSingleton.h"
#import "DealWithNetWorkAndXmlHelper.h"

#define kDuration 0.3

@interface HZAreaPickerView ()
{
    NSArray *provinces, *cities, *areas;
    
    
    NSArray *saveallKeysArray;
    NSArray *saveAllValuesArray;
    
    NSDictionary *tmpRightDictionary;
    
    //暂时保存所有比较条件数据的字典
    NSArray *tmpSaveArray;
    NSMutableDictionary *tmpSaveSearchDictionary;

}

@property(nonatomic,retain)NSMutableDictionary *AllKeysForSalaryComparing; //获取比较信息 城市等


@end

@implementation HZAreaPickerView

@synthesize delegate=_delegate;
@synthesize pickerStyle=_pickerStyle;
@synthesize locate=_locate;
@synthesize locatePicker = _locatePicker;
@synthesize AllKeysForSalaryComparing;

- (void)dealloc
{
    [_locate release];
    [_locatePicker release];
    [provinces release];
    [super dealloc];
}

-(HZLocation *)locate
{
    if (_locate == nil) {
        _locate = [[HZLocation alloc] init];
    }
    
    return _locate;
}

//初始化方法
- (id)initWithStyle:(HZAreaPickerStyle)pickerStyle delegate:(id<HZAreaPickerDelegate>)delegate
{
    
    self = [[[[NSBundle mainBundle] loadNibNamed:@"HZAreaPickerView" owner:self options:nil] objectAtIndex:0] retain];
    if (self) {
        self.delegate = delegate;
        self.pickerStyle = pickerStyle;
        self.locatePicker.dataSource = self;
        self.locatePicker.delegate = self;
        
        saveallKeysArray = [[DealWithNetWorkAndXmlHelper getsaveallKeysArray] retain];
        saveAllValuesArray = [[DealWithNetWorkAndXmlHelper getsaveAllValuesArray] retain];
        
        
        //获取 比较的城市 行业 学历等信息
        self.AllKeysForSalaryComparing = [DealWithNetWorkAndXmlHelper getAllKeysForSalaryComparing];
        
        NSLog(@"薪酬查询界面 地区 keys 为 %@",AllKeysForSalaryComparing);
        
        SaveDataSingleton *myData = [SaveDataSingleton DefaultSaveData];
        
        
        //保存字典的数组 各个选择项目
        
        tmpSaveArray =[[NSArray alloc] initWithObjects:myData.cityItemDictionary,myData.IndustryItemsDictionary,myData.CompanyTypeItemsDictionary,myData.JobTypeItemsDictionary,myData.JobLevelItemsDictionary, myData.EducationItemsDictionary,nil];
        
        
        //将数据封装到字典中
        tmpSaveSearchDictionary =[[NSMutableDictionary alloc] init];
        
        [tmpSaveSearchDictionary setObject:[tmpSaveArray objectAtIndex:0] forKey:@"city"];
        [tmpSaveSearchDictionary setObject:[tmpSaveArray objectAtIndex:1] forKey:@"industry"];
        [tmpSaveSearchDictionary setObject:[tmpSaveArray objectAtIndex:2] forKey:@"corpproperty"];
        [tmpSaveSearchDictionary setObject:[tmpSaveArray objectAtIndex:3] forKey:@"jobcat"];
        [tmpSaveSearchDictionary setObject:[tmpSaveArray objectAtIndex:4] forKey:@"joblevel"];
        [tmpSaveSearchDictionary setObject:[tmpSaveArray objectAtIndex:5] forKey:@"educationid"];
        

        
        //动态显示的数据
        tmpRightDictionary = [tmpSaveSearchDictionary objectForKey:@"city"];
        
        
        NSLog(@"在薪酬比较界面 各个选择列表 count= %d",[tmpSaveArray count]);

        
        provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
            
        cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
            
            //当前显示的第一个省份 即北京
            self.locate.state = [[provinces objectAtIndex:0] objectForKey:@"state"];
            //城市中的第一个城市
            self.locate.city = [cities objectAtIndex:0];
        
    }
        
    return self;
    
}



#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [saveallKeysArray count];
            break;
        case 1:
            return [tmpRightDictionary count]; // 默认显示 城市 城市的第一行
            break;
        default:
            return 0;
        break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //一下开始写  每行每列要显示的值
    
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"state"];
                break;
            case 1:
                return [cities objectAtIndex:row];
                break;
            default:
                return @"";
                break;
        }
   
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   
        switch (component) {
            case 0:
                //正确取得城市数据
                cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];
                
                self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"state"];
                self.locate.city = [cities objectAtIndex:0];
                break;
            case 1:
                self.locate.city = [cities objectAtIndex:row];
                break;
            default:
                break;
        }
   
    
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
        [self.delegate pickerDidChaneStatus:self];
    }

}


#pragma mark - animation

- (void)showInView:(UIView *) view
{
    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
    
}

- (void)cancelPicker
{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}

@end
