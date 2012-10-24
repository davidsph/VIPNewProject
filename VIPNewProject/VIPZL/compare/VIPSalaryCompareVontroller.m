//
//  VIPSalaryCompareVontroller.m
//  VIPZL
//
//  Created by david on 12-10-23.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import "VIPSalaryCompareVontroller.h"
#import "PCPieChart.h"
@implementation VIPSalaryCompareVontroller

@synthesize salaryInfoArray;
@synthesize salarySearchInfoDictionary;
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
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    salaryLevelKeyArray = [[NSArray alloc] initWithObjects:@"低端",@"中低端",@"中端",@"中高端",@"高端", nil];
    thisDictionaryForPieChart = [[NSMutableDictionary alloc] init];
    

    
    NSLog(@"收到的数据 salaryInfoArray count %d",  [salaryInfoArray count]);
   
    NSLog(@"salarySearchInfoDictionary count = %d", [salarySearchInfoDictionary count]);
    
   }

- (void) viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:YES];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
