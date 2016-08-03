//
//  RACBaseViewController.m
//  ZZReactiveCocoa
//
//  Created by colorpen on 16/8/3.
//  Copyright © 2016年 Bobo. All rights reserved.
//

#import "RACBaseViewController.h"

@interface RACBaseViewController ()

@end

@implementation RACBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];

    /*  Sequence -> 队列  Map -> for 循环  */
//    [RACBase useSequenceAndMapMethod];
    
    /*  Switch - 信号量开关  */
//    [RACBase switchMethod];
    
    /*  信号量合并  */
//    [RACBase signalCombineMethod];
    
    /*  信号合并  */
//    [RACBase signalMergeMethod];
    
//    [RACBase sequenceMethod];
//    [RACBase subscribeCompletedMethod];
//    [RACBase subscribeNextMethod];
//    [RACBase flattenMethod];
//    [RACBase flattenMapMethod];
//    [RACBase doNextThenMethod];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
