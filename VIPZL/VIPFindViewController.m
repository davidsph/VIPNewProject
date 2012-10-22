//
//  VIPFindViewController.m
//  VIPZL
//
//  Created by Ibokan on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VIPFindViewController.h"

@implementation VIPFindViewController
@synthesize imgView;

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
    imgView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.imgView addGestureRecognizer:swipe];
    [swipe release];
    // Do any additional setup after loading the view from its nib.
}
//向左轻扫触发的方法，返回上一个界面。
- (void)swipe
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidUnload
{
    [self setImgView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [imgView release];
    [super dealloc];
}
- (IBAction)clickSent:(id)sender {
    NSLog(@"点击了确认发送");
}
@end
