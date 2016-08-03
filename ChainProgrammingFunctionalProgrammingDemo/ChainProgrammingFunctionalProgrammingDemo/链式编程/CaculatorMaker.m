//
//  CaculatorMaker.m
//  链式编程_Demo
//
//  Created by colorPen on 15/12/1.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import "CaculatorMaker.h"

@implementation CaculatorMaker

- (CaculatorMaker *(^)(int))add {
    
    return ^(int num) {
        self.result = self.result + num;
        return self;
    };
}

- (CaculatorMaker *(^)(int))sub {
    
    return ^(int num) {
        self.result = self.result - num;
        return self;
    };
}

- (CaculatorMaker *(^)(int))muilt {
    
    return ^(int num) {
        self.result = self.result * num;
        return self;
    };
}

- (CaculatorMaker *(^)(int))divide {
    
    return ^(int num) {
        self.result = self.result / num;
        return self;
    };
}
@end
