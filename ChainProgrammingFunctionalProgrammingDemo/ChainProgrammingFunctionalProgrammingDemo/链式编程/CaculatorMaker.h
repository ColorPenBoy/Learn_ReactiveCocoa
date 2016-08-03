//
//  CaculatorMaker.h
//  链式编程_Demo
//
//  Created by colorPen on 15/12/1.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorMaker : NSObject

@property (nonatomic, assign) int result;

// 加
- (CaculatorMaker *(^)(int))add;

// 减
- (CaculatorMaker *(^)(int))sub;

// 乘
- (CaculatorMaker *(^)(int))muilt;

// 除
- (CaculatorMaker *(^)(int))divide;

@end
