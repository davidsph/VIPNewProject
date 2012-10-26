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
#import "DavidCompareType.h"
#define kDuration 0.3

@interface HZAreaPickerView ()
{
   
    
    //待选择的 key key 和value 一一对应
    NSArray *saveallKeysArray;
    //待选择的value
    NSArray *saveAllValuesArray;
    
    //第一列的数值 数组
    NSArray *tmpRightArray;
    
    //暂时保存所有比较条件数据的字典
    NSArray *tmpSaveArray;
    //
    NSDictionary *tmpdic;
    
}

@property(nonatomic,retain) NSArray *tmpRightArray;
@property(nonatomic,retain) NSArray *tmpSaveArray;


@end

@implementation HZAreaPickerView

@synthesize delegate=_delegate;
@synthesize pickerStyle=_pickerStyle;
@synthesize locate=_locate;
@synthesize locatePicker = _locatePicker;

@synthesize compareCondition;
@synthesize tmpRightArray;
@synthesize tmpSaveArray;
- (void)dealloc
{
    [_locate release];
    [_locatePicker release];
   
    [super dealloc];
}

-(HZLocation *)locate
{
    if (_locate == nil) {
        _locate = [[HZLocation alloc] init];
    }
    
    return _locate;
}

- (DavidCompareType *) compareCondition{
    
    if (compareCondition==nil) {
        compareCondition =[[DavidCompareType alloc] init];
    }
    
    return compareCondition;
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
        
        SaveDataSingleton *myData = [SaveDataSingleton DefaultSaveData];
        
        
        //保存字典的数组 各个选择项目
        
        tmpSaveArray =[[NSArray alloc] initWithObjects:myData.cityItemDictionary,myData.IndustryItemsDictionary,myData.CompanyTypeItemsDictionary,myData.JobTypeItemsDictionary,myData.JobLevelItemsDictionary, myData.EducationItemsDictionary,nil];
        
        self.tmpRightArray = [[NSArray alloc] init];
        
        //第一列默认显示的是地区列表
        self.tmpRightArray = [[tmpSaveArray objectAtIndex:0] allValues] ;
        
        
        NSLog(@"在薪酬比较界面 各个选择列表 count= %d",[tmpSaveArray count]);
        
        
        
        //初始化用户选择 这个很重要 参数
        self.compareCondition.comparetype = [saveallKeysArray objectAtIndex:0];
        //默认选择的值是第一列中的第一行 即地区的第一个数据 的key
        
        self.compareCondition.comparevalue = [[[tmpSaveArray objectAtIndex:0] allKeysForObject:[self.tmpRightArray objectAtIndex:0]] objectAtIndex:0];
        
        //默认选择 名字
        self.compareCondition.comparetypeName = [saveAllValuesArray objectAtIndex:0];
        
        self.compareCondition.comparevalueName =[self.tmpRightArray objectAtIndex:0];
        
        
        
        //初始化选择字典 这个也很重要 表示 用户不点击第0列的时候第一列默认显示的是 地区里面的条目
        tmpdic = [tmpSaveArray objectAtIndex:0];
        
        
    }
    
    return self;
    
}



#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //有两列
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [saveallKeysArray count];
            break;
        case 1:
            return [self.tmpRightArray count]; // 默认显示 城市 城市的第一行
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
            //显示的是要比较的类别
            return [saveAllValuesArray objectAtIndex:row];
            break;
        case 1:
            //每个类别下具体的项目
            return [self.tmpRightArray objectAtIndex:row];
            break;
        default:
            return @"";
            break;
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //这个方法很重要，不仅要取得用户选择的是什么，还要动态改变第一列中要显示的值
    switch (component) {
        case 0:
            
            NSLog(@"用户选择的是第0列 第%d行",row);
            //正确取得第一列中要显示的数值
            self.tmpRightArray =[ [tmpSaveArray objectAtIndex:row] allValues] ;
            //刷新第一列的数据
            [self.locatePicker reloadComponent:1];

            //动态改变的时候默认选择 第一列中的第一行
            [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                        
            //保存用户的选择
            self.compareCondition.comparetype = [saveallKeysArray objectAtIndex:row];
            
            NSLog(@"用户要比较的类型 是 %@ 用户选择的是 %@ ",[saveallKeysArray objectAtIndex:row],[saveAllValuesArray objectAtIndex:row]);
            
            //取得正确的字典
            tmpdic = [tmpSaveArray objectAtIndex:row];
            
            
            //默认选择的值是第一列中的第一行
            self.compareCondition.comparevalue = [[tmpdic allKeysForObject:[tmpRightArray  objectAtIndex:0]] objectAtIndex:0];               
            
            break;
            //选择的是第一列
        case 1:
            
        self.compareCondition.comparevalue = [[tmpdic allKeysForObject:[self.tmpRightArray  objectAtIndex:row]] objectAtIndex:0];
            
            
            self.compareCondition.comparevalueName = [self.tmpRightArray objectAtIndex:row];
            
            NSLog(@"用户选择的具体哪一个 %@",[self.tmpRightArray objectAtIndex:row]);
            break;
        default:
            break;
    }
    if (self.delegate!=nil) {

        
        NSLog(@"选择的时候代理不为空");
        if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
            [self.delegate pickerDidChaneStatus:self];
        }

        
        
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

- (IBAction)compareSalary:(id)sender {
    
    
    //由于不执行代理方法 只能用通知
    NSLog(@"在自定义pickview中 点击了比较按钮");
    
    NSString *string = @"DidCLickCompareBnNotification";
    NSNotificationCenter *ceter = [NSNotificationCenter defaultCenter];
    [ceter postNotificationName:string object:self];
    
    
    if (self.delegate!=nil) {
        
        NSLog(@"代理不为空");
        if ([self.delegate respondsToSelector:@selector(pickerDidClickCompareBn:)]) {
            NSLog(@"响应代理方法");
            [self.delegate pickerDidClickCompareBn:self];
        } else{
            
            NSLog(@"不响应代理方法");
        }

        
    } else{
        
        NSLog(@"代理为空");
    }
        
    
}
@end
