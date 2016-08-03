//
//  LoginViewModel.h
//  ZZReactiveCocoa
//
//  Created by colorPen on 15/11/26.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject

// 绑定用户输入的用户名与密码
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;

// 用来发送网络请求的数据
@property (nonatomic, strong) RACSubject *successObject;// 网络请求成功且符合正常业务逻辑的事件
@property (nonatomic, strong) RACSubject *failureObject;// 网络请求成功不符合正常业务逻辑的处理
@property (nonatomic, strong) RACSubject *errorObject;  // 网络异常处理

// 负责返回登录按钮是否可用的信号量。
- (id)buttonIsValid;

// 发起网络请求，调用登录网络接口。
- (void)login;

@end
