//
//  AppDelegate.m
//  VIPZL
//
//  Created by Ibokan on 12-10-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "VIPHomeViewController.h"
#import "VIPLoginViewController.h"
#import "SaveDataSingleton.h"
#import "DealWithNetWorkAndXmlHelper.h"
@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    //使用单例模式预先存储数据
    SaveDataSingleton * myData = [SaveDataSingleton DefaultSaveData];
    myData.cityItemDictionary = [DealWithNetWorkAndXmlHelper getCityItems];
    myData.IndustryItemsDictionary = [DealWithNetWorkAndXmlHelper getIndustryItems];
    myData.EducationItemsDictionary = [DealWithNetWorkAndXmlHelper getEducationItems];
    myData.CompanyTypeItemsDictionary = [DealWithNetWorkAndXmlHelper getCompanyTypeItems];
    myData.JobTypeItemsDictionary = [DealWithNetWorkAndXmlHelper getJobTypeItems];
    myData.JobLevelItemsDictionary = [DealWithNetWorkAndXmlHelper getJobLevelItems];
   /* 
    NSLog(@"cityItemDictionary = %d",[myData.cityItemDictionary count]);
    NSLog(@"IndustryItemsDictionary = %d",[myData.IndustryItemsDictionary count]);
    NSLog(@"EducationItemsDictionary = %d",[myData.EducationItemsDictionary count]);
    NSLog(@"CompanyTypeItemsDictionary count = %d",[myData.CompanyTypeItemsDictionary count]);
    NSLog(@"JobTypeItemsDictionary count = %d",[myData.JobTypeItemsDictionary count]);
    NSLog(@"JobLevelItemsDictionary count =%d",[myData.JobLevelItemsDictionary count]);
    */
    
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    VIPHomeViewController *homeVC = [[VIPHomeViewController alloc] init];
    UINavigationController *homeNV = [[UINavigationController alloc] init];
    homeNV.viewControllers = [[NSMutableArray alloc] init];
    [homeNV initWithRootViewController:homeVC];
    
    [homeVC release];
    
    self.window.rootViewController = homeNV;
    [homeNV release];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
