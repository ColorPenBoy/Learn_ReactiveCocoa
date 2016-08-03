//
//  LoginViewModel.m
//  ZZReactiveCocoa
//
//  Created by colorPen on 15/11/26.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel ()

@property (nonatomic, strong) RACSignal *userNameSignal;
@property (nonatomic, strong) RACSignal *passwordSignal;
@property (nonatomic, strong) NSArray *requestData;

@end

@implementation LoginViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _userNameSignal = RACObserve(self, userName);
    _passwordSignal = RACObserve(self, password);
    
    _successObject = [RACSubject subject];
    _failureObject = [RACSubject subject];
    _errorObject = [RACSubject subject];
}

// 发送登录按钮是否可用信号的方法如下，主要用到了信号量的合并。
// 合并两个输入框信号，并返回按钮bool类型的值
- (id)buttonIsValid {
    
    RACSignal *isValid = [RACSignal combineLatest:@[_userNameSignal, _passwordSignal]
                                           reduce:^id(NSString *userName, NSString *password){
        return @(userName.length >= 3 && password.length >= 3);
    }];
    
    return isValid;
}



// 模拟网络请求的发送，并发出网络请求成功的信号
- (void)login{
    
    //网络请求进行登录
    _requestData = @[_userName, _password];
    
    //成功发送成功的信号
    [_successObject sendNext:_requestData];
    
    //业务逻辑失败和网络请求失败发送fail或者error信号并传参
}

@end
