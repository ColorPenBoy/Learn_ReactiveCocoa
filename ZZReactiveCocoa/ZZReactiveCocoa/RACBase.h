//
//  RACBase.h
//  ZZReactiveCocoa
//
//  Created by colorPen on 15/11/26.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RACBase : NSObject

/*  Sequence -> 队列  Map -> for 循环  */
+ (void)useSequenceAndMapMethod;

/*  Switch - 信号量开关  */
+ (void)switchMethod;

/*  信号量合并  */
+ (void)signalCombineMethod;

/*  信号合并  */
+ (void)signalMergeMethod;



+ (void)sequenceMethod;
+ (void)subscribeCompletedMethod;
+ (void)subscribeNextMethod;
+ (void)flattenMethod;
+ (void)flattenMapMethod;
+ (void)doNextThenMethod;


@end

