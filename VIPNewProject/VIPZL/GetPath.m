//
//  GetPath.m
//  VIPZL
//
//  Created by Ibokan on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GetPath.h"

@implementation GetPath

-(NSArray*)getThePath:(NSArray*)viewControllers
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[viewControllers count]];
    for (int i = 0; i<[viewControllers count]; i++) {
        
        UIViewController *vc = [viewControllers objectAtIndex:i];
        NSString *name = vc.navigationItem.title;
        [array replaceObjectAtIndex:i withObject:name];
    }
    return array;
}

@end
