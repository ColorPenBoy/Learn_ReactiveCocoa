//
//  NSObject+Calculate.h
//  链式编程_Demo
//
//  Created by colorPen on 15/12/1.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaculatorMaker.h"

@interface NSObject (Calculate)

+ (int)makeCalculate:(void(^)(CaculatorMaker *make))calculateMaker;

@end
