//
//  ViewController.m
//  ReactiveCocoa_MVVM_2
//
//  Created by colorPen on 15/12/2.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RequestViewModel.h"

@interface ViewController ()

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) RequestViewModel *requesViewModel;

@end

@implementation ViewController

- (RequestViewModel *)requesViewModel
{
    if (!_requesViewModel) {
        _requesViewModel = [[RequestViewModel alloc] init];
    }
    return _requesViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self.requesViewModel;
    
    self.requesViewModel.tableView = tableView;
    [self.view addSubview:tableView];
    
    // 执行请求
    [self.requesViewModel.reuqesCommand execute:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
