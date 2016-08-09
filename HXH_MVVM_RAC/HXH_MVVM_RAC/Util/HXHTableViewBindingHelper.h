//
//  HXHTableViewBindingHelper.h
//  HXH_MVVM_RAC
//
//  Created by colorpen on 16/8/9.
//  Copyright © 2016年 colorpen. All rights reserved.
//

#import <Foundation/Foundation.h>

/// A helper class for binding view models with NSArray properties to a UITableView.

// 辅助类 -> 绑定ViewModel 数组 tableView
@interface HXHTableViewBindingHelper : NSObject

// forwards the UITableViewDelegate methods
@property (weak, nonatomic) id<UITableViewDelegate> delegate;

- (instancetype) initWithTableView:(UITableView *)tableView
                      sourceSignal:(RACSignal *)source
                  selectionCommand:(RACCommand *)selection
                      templateCell:(UINib *)templateCellNib;

+ (instancetype) bindingHelperForTableView:(UITableView *)tableView
                              sourceSignal:(RACSignal *)source
                          selectionCommand:(RACCommand *)selection
                              templateCell:(UINib *)templateCellNib;

@end
