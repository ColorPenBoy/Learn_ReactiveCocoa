//
//  LoginViewModel.h
//  ReactiveCocoa_MVVM
//
//  Created by colorPen on 15/12/1.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Account.h"

@interface LoginViewModel : NSObject

@property (nonatomic, strong) Account *account;


// 是否允许登录的信号
@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;

@property (nonatomic, strong, readonly) RACCommand *LoginCommand;

@end
