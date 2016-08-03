//
//  LoginViewController.m
//  ZZReactiveCocoa
//
//  Created by colorpen on 16/8/3.
//  Copyright © 2016年 Bobo. All rights reserved.
//

#import "LoginViewController.h"

#import "LoginViewModel.h"

#import "LoginSuccessViewController.h"

@interface LoginViewController ()


@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong)LoginViewModel *viewModel;

@end

@implementation LoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self bindModel];
    
    [self onClick];
}


//关联ViewModel
- (void)bindModel {
    
    _viewModel = [[LoginViewModel alloc] init];
    
    
    RAC(self.viewModel, userName) = self.userNameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    RAC(self.loginButton, enabled) = [_viewModel buttonIsValid];
    
    @weakify(self);
    
    //登录成功要处理的方法
    [self.viewModel.successObject subscribeNext:^(NSArray * x) {
        @strongify(self);
        
        // 输入成功，跳转
        LoginSuccessViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginSuccessViewController"];
        vc.userName = x[0];
        vc.password = x[1];
        [self presentViewController:vc animated:YES completion:nil];
    }];
    
    //fail
    [self.viewModel.failureObject subscribeNext:^(id x) {
        
    }];
    
    //error
    [self.viewModel.errorObject subscribeNext:^(id x) {
        
    }];
    
}

// 点击登录按钮，调用VM中登录相应的网络请求方法即可
- (void)onClick {
    //按钮点击事件
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [_viewModel login];
     }];
}

- (IBAction)tapGestureRecognizer:(id)sender {
    [self.view endEditing:YES];
}

//输入框过滤
- (void)inputTextFilter{
    //过滤
    [[_userNameTextField.rac_textSignal filter:^BOOL(id value) {
        
        NSString *text = value;
        //长度大于5才执行下方的打印方法
        return text.length > 5;
        
    }] subscribeNext:^(id x) {
        NSLog(@">=5%@", x);
    }];
    
}
-(void)inputTextViewObserv {
    [_userNameTextField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"first---%@", x);
    }];
}

//映射和过滤
- (void)mapAndFilter {
    //映射
    [[[_userNameTextField.rac_textSignal map:^id(NSString * value) {
        return @(value.length);
    }] filter:^BOOL(NSNumber * value) {
        return [value integerValue] > 5;
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

//RAC的使用
- (void)userRACSetValue {
    //当输入长度超过5时，使用RAC()使背景颜色变化
    RAC(self.view, backgroundColor) = [_userNameTextField.rac_textSignal map:^id(NSString * value) {
        return value.length > 5 ? [UIColor yellowColor] : [UIColor greenColor];
    }];
}


- (void)combineLatestTextField {
    
    __weak LoginViewController *copy_self = self;
    //把两个输入框的信号合并成一个信号量，并把其用来改变button的可用性
    NSArray *signalArray = @[copy_self.userNameTextField.rac_textSignal,
                             copy_self.passwordTextField.rac_textSignal];
    
    RAC(self.loginButton, enabled) = [RACSignal combineLatest:signalArray reduce:^(NSString *userName, NSString *password) {
        return @(userName.length > 0 && password.length > 0);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
