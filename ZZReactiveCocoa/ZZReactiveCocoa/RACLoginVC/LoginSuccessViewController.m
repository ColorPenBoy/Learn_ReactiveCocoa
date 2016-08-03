//
//  LoginSuccessViewController.m
//  ZZReactiveCocoa
//
//  Created by colorPen on 15/11/26.
//  Copyright © 2015年 Bobo. All rights reserved.
//

#import "LoginSuccessViewController.h"

@interface LoginSuccessViewController ()

@property (strong, nonatomic) IBOutlet UILabel *userInfoLabel;

@end

@implementation LoginSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _userInfoLabel.text = [NSString stringWithFormat:@"用户名：%@,  密码：%@", _userName, _password];
}

- (IBAction)tapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
