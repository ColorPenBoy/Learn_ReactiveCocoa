//
//  NSObject+Calculate.m
//  链式编程_Demo
//
//  Created by colorPen on 15/12/1.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import "NSObject+Calculate.h"

@implementation NSObject (Calculate)

+ (int)makeCalculate:(void(^)(CaculatorMaker *make))calculateMaker {
    
    CaculatorMaker *CM = [[CaculatorMaker alloc]init];
    
    calculateMaker(CM);
    
    return CM.result;
}


@end
