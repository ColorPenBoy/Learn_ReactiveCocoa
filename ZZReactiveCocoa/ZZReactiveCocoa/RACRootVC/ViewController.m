//
//  ViewController.m
//  ZZReactiveCocoa
//
//  Created by colorPen on 15/11/26.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import "ViewController.h"
#import "DemoItem.h"
// RAC基础教学
#import "RACBase.h"

typedef void(^SignInRespongse)(BOOL result);

#define kRootItems \
@[\
@{@"title" : @"RAC基础", @"className" : @"RACBaseViewController"},\
@{@"title" : @"RAC登录", @"className" : @"LoginViewController"}\
]

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ReactiveCocoa";
    
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.mainTableView setTableFooterView:[UIView new]];
    
    //遍历数组
    [kRootItems enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        [self.dataSource addObject:[DemoItem initalizerWithTitle:obj[@"title"] className:obj[@"className"]]];
    }];
    
}
#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    DemoItem *item = self.dataSource[indexPath.row];
    cell.textLabel.text = item.title;
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DemoItem *item = self.dataSource[indexPath.row];
    
    Class currentClass = NSClassFromString(item.className);
    UIViewController * viewController = [[currentClass alloc] init];
    viewController.title = item.title;
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - Getter
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
