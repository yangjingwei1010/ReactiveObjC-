//
//  Person.m
//  ReactiveObjcTest
//
//  Created by yangjingwei on 2017/9/27.
//  Copyright © 2017年 yangjingwei. All rights reserved.
//

#import "Person.h"

@implementation Person

- (Person *)run{
    NSLog(@"跑步");
    //延时
    [NSThread sleepForTimeInterval:2];
    
    return  self;
}

- (Person *)walk{
    NSLog(@"走路");
    //延时
    [NSThread sleepForTimeInterval:2];
    
    return self;
}

@end
