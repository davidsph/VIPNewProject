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

@interface VIPSalaryCompareVontroller ()<HZAreaPickerDelegate>


@property(nonatomic,retain)HZAreaPickerView *localPickView;
@property(nonatomic,retain) NSString *comparetype,*comparevalue;
@property(nonatomic,retain)DavidCompareType *compareCondition; //比较条件



@end



@implementation VIPSalaryCompareVontroller

@synthesize pickerview;
@synthesize salaryInfoArray;
@synthesize salarySearchInfoDictionary;
@synthesize AllKeysForSalaryComparing;
@synthesize comparevalue;
@synthesize comparetype;
@synthesize localPickView;
@synthesize compareCondition;



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
#pragma mark -
#pragma mark pickview 代理
- (void) pickerDidChaneStatus:(HZAreaPickerView *)picker{
  
    
    NSLog(@"值变化了");
    
    self.comparetype = picker.compareCondition.comparetype;
    self.comparevalue = picker.compareCondition.comparevalue;
    NSLog(@"key = %@ value = %@",self.comparetype,self.comparevalue);
    
}




- (void) pickerDidClickCompareBn:(HZAreaPickerView *)picker{
    
    
    
    
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [super viewDidLoad];
    
    
    NSLog(@"收到的薪酬数据 salaryInfoArray count %d",  [salaryInfoArray count]);
   
    NSLog(@"salarySearchInfoDictionary count = %d", [salarySearchInfoDictionary count]);
    
   }


- (void)viewDidUnload
{
    [self setPickerview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




- (IBAction)compare:(id)sender {
    
    self.localPickView = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCity delegate:self];
    
    [self.localPickView showInView:self.view];
        
    
}
- (void)dealloc {
    [pickerview release];
    [super dealloc];
}




@end
