//
//  Person1.m
//  ReactiveObjcTest
//
//  Created by yangjingwei on 2017/9/27.
//  Copyright © 2017年 yangjingwei. All rights reserved.
//

#import "Person1.h"

@implementation Person1

- (Person1 *(^)(void))runBlock{
    
    Person1 * (^block)(void) = ^() {
        
        NSLog(@"run");
        // 延时2s
        [NSThread sleepForTimeInterval:2];
        return self;
    };
    
    return block;
}
- (Person1 * (^)(void))walkBlock {
    
    Person1 * (^block)(void) = ^() {
        
        NSLog(@"walk");
        // 延时2s
        [NSThread sleepForTimeInterval:2];
        return self;
    };
    
    return block;
}
@end
