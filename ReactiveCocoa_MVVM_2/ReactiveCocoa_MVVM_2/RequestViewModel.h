//
//  RequestViewModel.h
//  ReactiveCocoa_MVVM_2
//
//  Created by colorPen on 15/12/2.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RequestViewModel : NSObject<UITableViewDataSource>


// 请求命令
@property (nonatomic, strong, readonly) RACCommand *reuqesCommand;

//模型数组
@property (nonatomic, strong, readonly) NSArray *models;

// 控制器中的view
@property (nonatomic, weak) UITableView *tableView;


@end
