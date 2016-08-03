//
//  Calculator.m
//  链式编程_Demo
//
//  Created by colorPen on 15/12/1.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

- (Calculator *)calculate:(int(^)(int result))calculator {
    self.result = calculator(self.result);
    return self;
}

- (Calculator *)equle:(BOOL(^)(int result))operation {
    self.isEqule = operation(self.result);
    return self;
}

@end
