//
//  HXHTableViewBindingHelper.m
//  HXH_MVVM_RAC
//
//  Created by colorpen on 16/8/9.
//  Copyright © 2016年 colorpen. All rights reserved.
//

#import "HXHTableViewBindingHelper.h"
#import "HXHReactiveView.h"

@interface HXHTableViewBindingHelper () <UITableViewDataSource, UITableViewDelegate>
    
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) UITableViewCell *templateCell;

@property (nonatomic, strong) RACCommand *selection;


@end

@implementation HXHTableViewBindingHelper

#pragma  mark - initialization

- (instancetype)initWithTableView:(UITableView *)tableView
                     sourceSignal:(RACSignal *)source
                 selectionCommand:(RACCommand *)selection
                     templateCell:(UINib *)templateCellNib {
    
    if (self = [super init]) {
        
        self.tableView = tableView;
        self.data = [[NSArray alloc] init];
        self.selection = selection;
        
        // 每当 ViewModel 更新 数据源Array 的时候，存储最新数据，刷新tableView
        [source subscribeNext:^(id x) {
            self.data = x;
            [self.tableView reloadData];
        }];
        
        // 实例化一个template cell，在tableView上注册
        _templateCell = [[templateCellNib instantiateWithOwner:nil options:nil] firstObject];
        [_tableView registerNib:templateCellNib forCellReuseIdentifier:_templateCell.reuseIdentifier];
        
        // 设置高度
        _tableView.rowHeight = _templateCell.bounds.size.height;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return self;
}

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                             sourceSignal:(RACSignal *)source
                         selectionCommand:(RACCommand *)selection
                             templateCell:(UINib *)templateCellNib{
    
    return [[HXHTableViewBindingHelper alloc] initWithTableView:tableView
                                                   sourceSignal:source
                                               selectionCommand:selection
                                                   templateCell:templateCellNib];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<HXHReactiveView> cell = [tableView dequeueReusableCellWithIdentifier:_templateCell.reuseIdentifier];
    [cell bindViewModel:_data[indexPath.row]];
    return (UITableViewCell *)cell;
}

#pragma mark = UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // execute the command
    [_selection execute:_data[indexPath.row]];
    
    // forward the delegate method
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark = UITableViewDelegate forwarding

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.delegate respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.delegate respondsToSelector:aSelector]) {
        return self.delegate;
    }
    return [super forwardingTargetForSelector:aSelector];
}


@end
