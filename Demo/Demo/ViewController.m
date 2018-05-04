//
//  ViewController.m
//  Demo
//
//  Created by KT--stc08 on 2018/5/4.
//  Copyright © 2018年 KT--stc08. All rights reserved.
//

#import "ViewController.h"
#import "HTCKeyboard.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HTCKeyboard *keyboard = [[HTCKeyboard alloc]initWithFrame:CGRectMake(0, 0, 375, 225+30)];
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(30, 30, 300, 300)];
    textField.placeholder = @"请输入xxxxx";
    textField.inputView = keyboard;
    [self.view addSubview:textField];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
