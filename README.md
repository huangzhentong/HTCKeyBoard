# HTCKeyBoard
一个车牌号输入键盘
使用方式
 HTCKeyboard *keyboard = [[HTCKeyboard alloc]initWithFrame:CGRectMake(0, 0, 375, 225+30)];
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(30, 30, 300, 300)];
    textField.placeholder = @"请输入xxxxx";
    textField.inputView = keyboard;
