//
//  Calculator.h
//  链式编程_Demo
//
//  Created by colorPen on 15/12/1.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

@property (nonatomic, assign) BOOL isEqule;
@property (nonatomic, assign) int result;

- (Calculator *)calculate:(int(^)(int result))calculator;
- (Calculator *)equle:(BOOL(^)(int result))operation;

@end
