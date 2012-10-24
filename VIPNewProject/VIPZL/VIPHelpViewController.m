//
//  VIPHelpViewController.m
//  VIPHelp
//
//  Created by Ibokan on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VIPHelpViewController.h"

//滚动视图加载的图片数目
#define numberOfPhotos 6

@implementation VIPHelpViewController
-(void)dealloc
{
    [_scrollView release];
    [_pageControl release];
    [super dealloc];
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
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
        self.navigationItem.title =@"智联助手";
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    backView.backgroundColor = [UIColor whiteColor];
    self.view = backView ;
    [backView release];
    
    //在视图上加载滚动视图对象
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    _scrollView.showsVerticalScrollIndicator = NO;//不显示垂直滚动条;
    _scrollView.showsHorizontalScrollIndicator = NO;//不显示水平滚动条;
    _scrollView.bounces = NO;//滚动超过边界不反弹回来；
    _scrollView.pagingEnabled = YES; //是否滚动的subView的边界,设置为划一屏的大小；
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(320*numberOfPhotos, 460);//设置滚动视图内容大小
    for (int i = 0; i<numberOfPhotos; i++)
    {
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(i*320, 0, 320, 460)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]];
        
        [_scrollView addSubview:imageView];
        [imageView release];
    }
    [self.view addSubview:_scrollView];
    //视图上加载pageControl
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 390, 320, 16)];
    _pageControl.numberOfPages = numberOfPhotos;
    [_pageControl addTarget:self action:@selector(pageEventMathod:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endBtn setBackgroundColor:[UIColor clearColor]];
    [endBtn setTitle:@"结束" forState:UIControlStateNormal];
    [endBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [endBtn setFrame:CGRectMake(240, 360, 60, 30)];
    [endBtn addTarget:self action:@selector(endTheView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endBtn];
    
    
}
-(void)pageEventMathod:(UIPageControl *)sender
{
    int cp =(int)sender.currentPage;
    //获取图片视图
    if (cp>0)
    {
        [_scrollView setContentOffset:CGPointMake(320*cp, 0) animated:YES];
    }
    else
    {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}
//结束按钮的方法
-(void)endTheView
{
    NSLog(@"结束了");
    [self.navigationController popViewControllerAnimated:NO];    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"drag end");
    CGPoint point = scrollView.contentOffset;//滚动内容的偏移量
    int currentPage = (int)(point.x)/320;
    _pageControl.currentPage = currentPage;
    NSLog(@"%@",NSStringFromCGPoint(point));
}



/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
