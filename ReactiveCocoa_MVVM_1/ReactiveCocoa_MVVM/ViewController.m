//
//  ViewController.m
//  ReactiveCocoa_MVVM
//
//  Created by colorPen on 15/12/1.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (strong , nonatomic) LoginViewModel *loginViewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /* 需求：
     1.监听两个文本框的内容，有内容才允许按钮点击
     2.默认登录请求.
     
     用MVVM：实现，之前界面的所有业务逻辑
     分析：
     1.之前界面的所有业务逻辑都交给控制器做处理
     2.在MVVM架构中把控制器的业务全部搬去VM模型，也就是每个控制器对应一个VM模型.
     
     步骤：
     1.创建LoginViewModel类，处理登录界面业务逻辑.
     2.这个类里面应该保存着账号的信息，创建一个账号Account模型
     3.LoginViewModel应该保存着账号信息Account模型。
     4.需要时刻监听Account模型中的账号和密码的改变，怎么监听？
     5.在非RAC开发中，都是习惯赋值，在RAC开发中，需要改变开发思维，由赋值转变为绑定，可以在一开始初始化的时候，就给Account模型中的属性绑定，并不需要重写set方法。
     6.每次Account模型的值改变，就需要判断按钮能否点击，在VM模型中做处理，给外界提供一个能否点击按钮的信号.
     7.这个登录信号需要判断Account中账号和密码是否有值，用KVO监听这两个值的改变，把他们聚合成登录信号.
     8.监听按钮的点击，由VM处理，应该给VM声明一个RACCommand，专门处理登录业务逻辑.
     9.执行命令，把数据包装成信号传递出去
     10.监听命令中信号的数据传递
     11.监听命令的执行时刻
     */
    [self bindModel];
    
}

// 视图模型绑定
- (void)bindModel
{
    // 给模型的属性绑定信号
    // 只要账号文本框一改变，就会给account赋值
    RAC(self.loginViewModel.account, account) = self.accountField.rac_textSignal;
    RAC(self.loginViewModel.account, pwd)     = self.pwdField.rac_textSignal;
    
    // 绑定登录按钮
    RAC(self.loginBtn,enabled) = self.loginViewModel.enableLoginSignal;
    
    // 监听登录按钮点击
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        // 执行登录事件
        [self.loginViewModel.LoginCommand execute:nil];
        
    }];
}

- (LoginViewModel *)loginViewModel {
    
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
