//
//  ViewController.m
//  ChainProgrammingFunctionalProgrammingDemo
//
//  Created by colorpen on 16/8/3.
//  Copyright © 2016年 colorpen. All rights reserved.
//

#import "ViewController.h"

// 链式编程
#import "NSObject+Calculate.h"

// 函数式编程
#import "Calculator.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /* 链式编程 */
    int result = [NSObject makeCalculate:^(CaculatorMaker *make) {
        make.add(1).add(2).add(3).add(4).divide(5);
    }];
    
    NSLog(@"链式编程 -> %d",result);
    
    
    /* 函数式编程 */
    
    // 计算2* 5 = 10 并判断 是否与10相等
    Calculator *cal = [[Calculator alloc]init];
    BOOL isEqule = [[[cal calculate:^int(int result) {
        
        result += 2;
        result *= 5;
        
        return result;
        
    }] equle:^BOOL(int result) {
        
        return result == 10;
        
    }] isEqule];
    
    NSLog(@"函数式编程 -> %d",isEqule);


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
