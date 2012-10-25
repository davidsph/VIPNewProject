//
//  VIPSalaryCompareVontroller.m
//  VIPZL
//
//  Created by david on 12-10-23.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import "VIPSalaryCompareVontroller.h"

#import "DealWithNetWorkAndXmlHelper.h"
#import "SaveDataSingleton.h"
#import "HZAreaPickerView.h"
#import "DavidCompareType.h"
#import "MBProgressHUD.h"
@interface VIPSalaryCompareVontroller ()<HZAreaPickerDelegate>
{
    
    MBProgressHUD *HUD;
}

@property(nonatomic,retain)HZAreaPickerView *localPickView;
@property(nonatomic,retain) NSString *comparetype,*comparevalue; //用户选择的比较条件 均已封装好
@property(nonatomic,retain)DavidCompareType *compareCondition; //比较条件
@property(nonatomic,retain)NSMutableDictionary *saveComparingConditionDictionary;
@property(nonatomic,retain) NSMutableArray *saveComparingResultArray; //保存薪酬比较的结果

@property(nonatomic,retain) NSString *compareValues1,*compareValues2,*compareValues3,*compareValues4,*compareValues5;







@end




@implementation VIPSalaryCompareVontroller


@synthesize compareValues1,compareValues2,compareValues3,compareValues4,compareValues5;

@synthesize saveComparingResultArray;
@synthesize saveComparingConditionDictionary;
@synthesize firstLowLabel;
@synthesize firstLowNormalLabel;
@synthesize firstNormalLabel;
@synthesize firstNormalHighLabel;
@synthesize firstHighLabel;
@synthesize secondLowLabel;
@synthesize secondLowNormalLabel;
@synthesize secondNormalLabel;
@synthesize secondNormalHighLabel;
@synthesize senondHighLabel;
@synthesize LowComparingLabel;
@synthesize lowNormalComparingLabel;
@synthesize normalComparingLabel;
@synthesize normalHighComparingLabel;
@synthesize highComparingLabel;
@synthesize comLabel1;
@synthesize comLabel2;
@synthesize comLabel3;
@synthesize comLabel4;
@synthesize comLabel5;
@synthesize pickerview;

@synthesize salaryInfoArray;
@synthesize salarySearchInfoDictionary;
@synthesize AllKeysForSalaryComparing;

@synthesize comparevalue;
@synthesize comparetype;
@synthesize localPickView;
@synthesize compareCondition;


- (void) setCompareValues1:(NSString *)compareValues11{
    
    
    if (![compareValues1 isEqualToString:compareValues11]) {
        
        
        [compareValues1 release];
        
        compareValues1 = [compareValues11 retain];
        
        int i = 0;
        
        i = [compareValues1 intValue] - [self.firstLowLabel.text intValue];
        
        if (i>0) {
            
            self.comLabel1.text=[NSString stringWithFormat:@"多%d",i];
            
        } else if(i==0){
            
            self.comLabel1.text=[NSString stringWithFormat:@"相等"];
        } else{
            self.comLabel1.text=[NSString stringWithFormat:@"少%d",i];
            
        }
        
    }
     
}


- (void) setCompareValues2:(NSString *)compareValues22{
 
    
    if (![compareValues2 isEqualToString:compareValues22]) {
        
        
        [compareValues2 release];
        
        compareValues2 = [compareValues22 retain];
        
        int i = 0;
        
        i = [compareValues2 intValue] - [self.firstLowLabel.text intValue];
        
        if (i>0) {
            
            self.comLabel2.text=[NSString stringWithFormat:@"多%d",i];
            
        } else if(i==0){
            
            self.comLabel2.text=[NSString stringWithFormat:@"相等"];
        } else{
            self.comLabel2.text=[NSString stringWithFormat:@"少%d",i];
            
        }
        
    }

    
}

- (void) setCompareValues3:(NSString *)compareValues33{
    
    
    
    if (![compareValues3 isEqualToString:compareValues33]) {
        
        
        [compareValues3 release];
        
        compareValues3 = [compareValues33 retain];
        
        int i = 0;
        
        i = [compareValues3 intValue] - [self.firstLowLabel.text intValue];
        
        if (i>0) {
            
            self.comLabel3.text=[NSString stringWithFormat:@"多%d",i];
            
        } else if(i==0){
            
            self.comLabel3.text=[NSString stringWithFormat:@"相等"];
        } else{
            self.comLabel3.text=[NSString stringWithFormat:@"少%d",i];
            
        }
        
    }

    
}

- (void) setCompareValues4:(NSString *)compareValues44{
    
    
    if (![compareValues4 isEqualToString:compareValues44]) {
        
        
        [compareValues4 release];
        
        compareValues4 = [compareValues44 retain];
        
        int i = 0;
        
        i = [compareValues4 intValue] - [self.firstLowLabel.text intValue];
        
        if (i>0) {
            
            self.comLabel4.text=[NSString stringWithFormat:@"多%d",i];
            
        } else if(i==0){
            
            self.comLabel4.text=[NSString stringWithFormat:@"相等"];
        } else{
            self.comLabel4.text=[NSString stringWithFormat:@"少%d",i];
            
        }
        
    }

    
}
- (void) setCompareValues5:(NSString *)compareValues55{
    
    
    if (![compareValues5 isEqualToString:compareValues55]) {
        
        
        [compareValues5 release];
        
        compareValues5 = [compareValues55 retain];
        
        int i = 0;
        
        i = [compareValues5 intValue] - [self.firstLowLabel.text intValue];
        
        if (i>0) {
            
            self.comLabel5.text=[NSString stringWithFormat:@"多%d",i];
            
        } else if(i==0){
            
            self.comLabel5.text=[NSString stringWithFormat:@"相等"];
        } else{
            self.comLabel5.text=[NSString stringWithFormat:@"少%d",i];
            
        }
        
    }

    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)cancelLocatePicker
{
    [self.localPickView cancelPicker];
    self.localPickView.delegate = nil;
    self.localPickView = nil;
}


- (void) initFirstLabels{
    
    self.firstLowLabel.text=[salaryInfoArray objectAtIndex:0];
    self.firstLowNormalLabel.text=[salaryInfoArray objectAtIndex:1];
    self.firstNormalLabel.text=[salaryInfoArray objectAtIndex:2];
    self.firstNormalHighLabel.text=[salaryInfoArray objectAtIndex:3];
    self.firstHighLabel.text=[salaryInfoArray objectAtIndex:4];
    
}

- (void) initSecondLabels{
    
    //这里显示比较的薪水
    
    self.secondLowLabel.text = [self.saveComparingResultArray objectAtIndex:0];
    self.secondLowNormalLabel.text=[self.saveComparingResultArray objectAtIndex:1];
    self.secondNormalLabel.text=[self.saveComparingResultArray objectAtIndex:2];
    self.secondNormalHighLabel.text=[self.saveComparingResultArray objectAtIndex:3];
    self.senondHighLabel.text=[self.saveComparingResultArray objectAtIndex:4];
    
}

- (void) initCompareLabels{
    
    
    self.compareValues1=[saveComparingResultArray objectAtIndex:0];
    self.compareValues2=[saveComparingResultArray objectAtIndex:1];
    self.compareValues3=[saveComparingResultArray objectAtIndex:2];
    self.compareValues4=[saveComparingResultArray objectAtIndex:3];
    self.compareValues5=[saveComparingResultArray objectAtIndex:4];
    
    
    
}

#pragma mark -
#pragma mark pickview 代理


- (void) pickerDidChaneStatus:(HZAreaPickerView *)picker{
  
    
    NSLog(@"值变化了");
    
    self.comparetype = picker.compareCondition.comparetype;
    self.comparevalue = picker.compareCondition.comparevalue;
    NSLog(@"key = %@ value = %@",self.comparetype,self.comparevalue);
    
}


//这个方法 执行查询操作  
- (void) pickerDidClickCompareBn:(HZAreaPickerView *)picker{
    
    
    self.comparetype = self.localPickView.compareCondition.comparetype;
    self.comparevalue = self.localPickView.compareCondition.comparevalue;
    NSLog(@"未进行任何选择 key =%@ value = %@",self.comparetype,self.comparevalue);
    
    
    
    
    
    //封装数据 
    [self.saveComparingConditionDictionary setObject:self.comparetype forKey:@"comparetype"];
    [self.saveComparingConditionDictionary setObject:self.comparevalue forKey:@"comparevalue"];
     
    
    NSLog(@"封装数据之后 字典中的count = %d",[self.saveComparingConditionDictionary count]);
    
    NSLog(@"响应用户进行比较的操作");
    
    
    //活动指示图
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.dimBackground = YES;
    HUD.labelText = @"正在查询";
    
    
    //
    [HUD showWhileExecuting:@selector(getSalaryComparingResultFromNetwork) onTarget:self withObject:nil animated:YES];

    
    
    
    [self cancelLocatePicker];

    
    //以下是封装数据 查询比较结果

    //将更新显示在 界面中
    
    
}
#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void) hudWasHidden:(MBProgressHUD *)hud{
    
    // Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];

    [self initSecondLabels];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新成功" message:@"OK" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
    //执行更新界面操作10
    
   
    [self initCompareLabels];
    
    
}




#pragma mark -
#pragma mark 为比较查询 封装数据 以及网络请求

- (void) getSalaryComparingResultFromNetwork{
    
    
    
    //调用工具类方法  会得到一个数组 数组里面保存的是薪酬比较的结果 然后在显示在 界面上
    
    self.saveComparingResultArray = [DealWithNetWorkAndXmlHelper getSalaryComparingResultFromNetwork:self.saveComparingConditionDictionary];
    
    //等待数据返回
   
    NSLog(@"返回的数据为 count %d",[self.saveComparingResultArray count]);
    
    
}







#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [super viewDidLoad];
    
    [self initFirstLabels];
    
    //接受通知
     NSString *string = @"DidCLickCompareBnNotification";
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(pickerDidClickCompareBn:) name:string object:nil];
    
    
    saveComparingConditionDictionary = [[NSMutableDictionary alloc] initWithDictionary:salarySearchInfoDictionary copyItems:YES];
    
    
    
    NSLog(@"收到的薪酬数据 salaryInfoArray count %d",  [salaryInfoArray count]);
   
    NSLog(@"salarySearchInfoDictionary count = %d", [salarySearchInfoDictionary count]);
    
   }


- (void)viewDidUnload
{
    [self setPickerview:nil];
    [self setFirstLowLabel:nil];
    [self setFirstLowNormalLabel:nil];
    [self setFirstNormalLabel:nil];
    [self setFirstNormalHighLabel:nil];
    [self setFirstHighLabel:nil];
    [self setSecondLowLabel:nil];
    [self setSecondLowNormalLabel:nil];
    [self setSecondNormalLabel:nil];
    [self setSecondNormalHighLabel:nil];
    [self setSenondHighLabel:nil];
    [self setLowComparingLabel:nil];
    [self setLowNormalComparingLabel:nil];
    [self setNormalComparingLabel:nil];
    [self setNormalHighComparingLabel:nil];
    [self setHighComparingLabel:nil];
    [self setComLabel1:nil];
    [self setComLabel2:nil];
    [self setComLabel3:nil];
    [self setComLabel4:nil];
    [self setComLabel5:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




- (IBAction)compare:(id)sender {
    
    self.localPickView = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCity delegate:self];
    
    self.localPickView.delegate=self;
    [self.localPickView showInView:self.view];
        
    
}
- (void)dealloc {
    [pickerview release];
    [firstLowLabel release];
    [firstLowNormalLabel release];
    [firstNormalLabel release];
    [firstNormalHighLabel release];
    [firstHighLabel release];
    [secondLowLabel release];
    [secondLowNormalLabel release];
    [secondNormalLabel release];
    [secondNormalHighLabel release];
    [senondHighLabel release];
    [LowComparingLabel release];
    [lowNormalComparingLabel release];
    [normalComparingLabel release];
    [normalHighComparingLabel release];
    [highComparingLabel release];
    [comLabel1 release];
    [comLabel2 release];
    [comLabel3 release];
    [comLabel4 release];
    [comLabel5 release];
    [super dealloc];
}




@end
