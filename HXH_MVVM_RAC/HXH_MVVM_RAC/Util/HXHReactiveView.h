//
//  HXHReactiveView.h
//  HXH_MVVM_RAC
//
//  Created by colorpen on 16/8/9.
//  Copyright © 2016年 colorpen. All rights reserved.
//

@import Foundation;

@protocol HXHReactiveView <NSObject>

// 给view绑定指定的ViewModel
- (void)bindViewModel:(id)viewModel;

@end

