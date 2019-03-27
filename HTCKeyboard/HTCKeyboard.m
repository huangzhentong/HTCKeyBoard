//
//  HTCKeyboard.m
//  keyboard
//
//  Created by 货大大 on 16/3/28.
//  Copyright © 2016年 货大大. All rights reserved.
//

#import "HTCKeyboard.h"
#import "HTCHeader.h"
#import "HTCListView.h"
/*********************************************************************/


static __weak id currentFirstResponder;
@implementation UIResponder(FirstResponder)


+ (id)currentFirstResponder
{
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(ZZZ_findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}
#pragma clang diagnostic pop

- (void)ZZZ_findFirstResponder:(id)sender
{
    currentFirstResponder = self;
}

@end


/*********************************************************************/




@interface HTCKeyboard()

@property (nonatomic,strong)HTCListView *provinceView;
@property (nonatomic,strong)HTCListView *letterView;
@property (nonatomic,weak) id <UIKeyInput> keyInput;


@end

@implementation HTCKeyboard

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame inputViewStyle:UIInputViewStyleDefault];
    if (self) {
        
        [self initKeyboard];
  
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame inputViewStyle:(UIInputViewStyle)inputViewStyle{
    self = [super initWithFrame:frame inputViewStyle:inputViewStyle];
    if (self) {
        
    }
    return self;
}


- (void)initKeyboard{
    
    NSArray *provinceArray = @[@[@"京",@"沪",@"粤",@"津",@"冀",@"豫",@"云",@"辽",@"黑",@"湘"],
                               @[@"皖",@"鲁",@"新",@"苏",@"浙",@"赣",@"鄂",@"桂",@"甘"],
                               @[@"晋",@"蒙",@"陕",@"吉",@"闽",@"贵",@"渝",@"川"],
                               @[@"青",@"藏",@"琼",@"宁",@"使",@""]];
    self.provinceView.groupArray = provinceArray;

    
    NSArray *letterArray = @[@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"],
                             @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"O",@"P",@"A"],
                             @[@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"X",@"Z"],
                             @[@"C",@"V",@"B",@"N",@"M",@"港",@"澳",@"学",@""]];

    self.letterView.groupArray = letterArray;
    
    __weak typeof(self) weakSelf  = self;
    void(^buttonInputBlock)(UIButton *button) = ^(UIButton *button){
        [weakSelf buttonInput:button];
    };
    self.provinceView.buttonInputEvent = buttonInputBlock;
    self.letterView.buttonInputEvent = buttonInputBlock;
    
    void(^backSpaceBlock)(UIButton *button) = ^(UIButton *button){
        [weakSelf buttonBackspace:button];
    };
    self.provinceView.backSpaceBtnEvent  = backSpaceBlock;
    self.letterView.backSpaceBtnEvent = backSpaceBlock;
    
    
   
    [self changeButtonSelectWithIndex:0];
}




- (void)handleToolButton:(UIButton *)sender{
    [self changeButtonSelectWithIndex:sender.tag];
}


- (id<UIKeyInput>)keyInput
{
    id <UIKeyInput> keyInput = _keyInput;
    if (keyInput) {
        return keyInput;
    }
    
    keyInput = [UIResponder currentFirstResponder];
    if (![keyInput conformsToProtocol:@protocol(UITextInput)]) {
        return nil;
    }
    _keyInput = keyInput;
    
    return keyInput;
}


- (void)dismissKeyboard:(UIButton *)sender
{
    UIResponder *firstResponder = self.keyInput;
    if (firstResponder) {
        [firstResponder resignFirstResponder];
    }
}


- (void)buttonInput:(UIButton *)sender{
    
    id <UIKeyInput>keyInput = self.keyInput;
    
    NSString *text = [self getInputString];
    if (text )
    {
        if ([text containsString:@"港"]||[text containsString:@"学"]||[text containsString:@"澳"]) {
            return;
        }
    }
    
    [keyInput insertText:sender.titleLabel.text];
    [self updateKeyBoard:keyInput];
    
    

     {
        unichar c = [sender.titleLabel.text characterAtIndex:0];
        if (c > 0x4e00 && c < 0x9FFF) {//汉字Unicode编码
            [self changeButtonSelectWithIndex:1];
        }
    }
}

- (void)buttonBackspace:(UIButton *)sender{
    id <UIKeyInput> keyInput = self.keyInput;
    
    [keyInput deleteBackward];
    [self updateKeyBoard:keyInput];
    if([keyInput isKindOfClass:[UITextField class]])
    {
        UITextField *textfield = keyInput;
        [self changeButtonSelectWithIndex: textfield.text.length == 0 ? 0:1];
    }
}





//色值
- (UIColor *)getColor:(NSString *)hexColor{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt: &red ];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt: &green ];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red / 255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1];
}




#pragma mark - 更新键盘修改哪些铵钮不可点击

-(void)updateKeyBoard:(id<UIKeyInput>)input
{
    NSString *string = [self getInputString];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"港",@"澳",@"学", nil];
    
    if (string.length == 0) {
        
    }
    else if(string.length == 1)
    {
        [array addObjectsFromArray: @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"]];
    }
    else if(string.length<6)
    {
        [array addObject:@"O"];
    }
    else
    {
        [array removeAllObjects];
        [array addObject:@"O"];
    }
    self.letterView.disabledArray = array;
}

-(NSString*)getInputString
{
    NSString *text = nil;
    if ([self.keyInput isKindOfClass:[UITextField class]]) {
        text = [(UITextField *)self.keyInput text];
    }
    else if([self.keyInput isKindOfClass:[UITextView class]])
    {
        text = [(UITextView *)self.keyInput text];
    }
    return text;
}


#pragma mark - scrollView delegate


- (void)changeButtonSelectWithIndex:(NSInteger)index{
    
 
    if (index == 0) {
        self.provinceView.hidden = NO;
    }else if(index == 1){
        self.provinceView.hidden = YES;
    }
    self.letterView.hidden = !self.provinceView.hidden;
}


#pragma mark getter


- (HTCListView *)provinceView{
    if (!_provinceView) {
        _provinceView = [[HTCListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
        [self addSubview:_provinceView];
    }
    return _provinceView;
}


- (HTCListView *)letterView{
    if (!_letterView) {
        _letterView = [[HTCListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
       
        [self addSubview:_letterView];
    }
    return _letterView;
}



#pragma mark btn
-(void)setBtnNormalBackGroundColor:(UIColor *)btnNormalBackGroundColor
{
  
    [self.provinceView performSelector:_cmd withObject:btnNormalBackGroundColor];
    [self.letterView performSelector:_cmd withObject:btnNormalBackGroundColor];
    
}
-(void)setBtnHighlightedBackGroundColor:(UIColor *)btnHighlightedBackGroundColor
{
    [self.provinceView performSelector:_cmd withObject:btnHighlightedBackGroundColor];
    [self.letterView performSelector:_cmd withObject:btnHighlightedBackGroundColor];
}
-(void)setBtnDisabledBackGroundColor:(UIColor *)btnDisabledBackGroundColor
{
    [self.provinceView performSelector:_cmd withObject:btnDisabledBackGroundColor];
    [self.letterView performSelector:_cmd withObject:btnDisabledBackGroundColor];
}
-(void)setBtnNormalColor:(UIColor *)btnNormalColor
{
    [self.provinceView performSelector:_cmd withObject:btnNormalColor];
    [self.letterView performSelector:_cmd withObject:btnNormalColor];
}
-(void)setBtnHighlightedColor:(UIColor *)btnHighlightedColor
{
    [self.provinceView performSelector:_cmd withObject:btnHighlightedColor];
    [self.letterView performSelector:_cmd withObject:btnHighlightedColor];
}
-(void)setBtnDisabledColor:(UIColor *)btnDisabledColor
{
    [self.provinceView performSelector:_cmd withObject:btnDisabledColor];
    [self.letterView performSelector:_cmd withObject:btnDisabledColor];
}
-(void)setFont:(UIFont *)font
{
    [self.provinceView performSelector:_cmd withObject:font];
    [self.letterView performSelector:_cmd withObject:font];
}



@end





