//
//  Person1.h
//  ReactiveObjcTest
//
//  Created by yangjingwei on 2017/9/27.
//  Copyright © 2017年 yangjingwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person1 : NSObject

- (Person1 *(^)(void))runBlock;
- (Person1 *(^)(void)) walkBlock;

@end
