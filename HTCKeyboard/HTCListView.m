//
//  HTCListView.m
//  keyboard
//
//  Created by KT--stc08 on 2018/5/4.
//  Copyright © 2018年 货大大. All rights reserved.
//

#import "HTCListView.h"
#import "HTCPopView.h"

#import "HTCHeader.h"

@interface HTCListView()
@property(nonatomic,strong)NSMutableDictionary *btnDic;                 //按钮字典
@property(nonatomic,strong)NSMutableArray *unClickArray;                //不可点击数组
@property(nonatomic,strong)HTCPopView *popView;
@property(nonatomic,weak)UIButton *lastBtn;
@end

@implementation HTCListView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.btnDic = [NSMutableDictionary new];
        self.unClickArray = [NSMutableArray array];
        [self setupUI];
    }
    return self;
}
-(void)setDisabledArray:(NSArray *)disabledArray
{
    
    for (UIButton *button in self.unClickArray) {
        button.enabled = YES;
        [button setBackgroundColor:self.btnNormalBackGroundColor?:[UIColor whiteColor]];
    }
    
    for (NSString *key in disabledArray) {
        UIButton *button = self.btnDic[key];
        if (button) {
            button.enabled = NO;
            [button setBackgroundColor:self.btnDisabledBackGroundColor?:[UIColor lightGrayColor]];
            [self.unClickArray addObject:button];
        }
    }
}
-(HTCPopView*)popView
{
    if (!_popView) {
        _popView = [HTCPopView popView];
    }
    return _popView;
}




#pragma mark - setBtnStatue
-(void)setBtnNormalColor:(UIColor *)btnNormalColor
{
    _btnNormalColor = [btnNormalColor copy];
    for (UIButton *button in self.btnDic.allValues) {
        [button setTitleColor:btnNormalColor forState:UIControlStateNormal];
    }
}

-(void)setBtnDisabledColor:(UIColor *)btnDisabledColor
{
    _btnDisabledColor = [btnDisabledColor copy];
    for (UIButton *button in self.btnDic.allValues) {
        [button setTitleColor:btnDisabledColor forState:UIControlStateDisabled];
    }
}
-(void)setBtnHighlightedColor:(UIColor *)btnHighlightedColor
{
    _btnHighlightedColor = [btnHighlightedColor copy];
    for (UIButton *button in self.btnDic.allValues) {
        [button setTitleColor:btnHighlightedColor forState:UIControlStateHighlighted];
    }
}
-(void)setBtnNormalBackGroundColor:(UIColor *)btnNormalBackGroundColor
{
    _btnNormalBackGroundColor = [btnNormalBackGroundColor copy];
    for (UIButton *button in self.btnDic.allValues) {
        [button setBackgroundColor:btnNormalBackGroundColor];
    }
}


-(void)setFont:(UIFont *)font
{
    _font = [font copy];
    for (UIButton *button in self.btnDic.allValues) {
        button.titleLabel.font = font;
    }
}

-(void)setupUI{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)];
    [self addGestureRecognizer:longPress];
}

-(void)setGroupArray:(NSArray *)groupArray
{
    _groupArray = [groupArray copy];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    int row = 10;
    int space = 5 ;
    CGFloat width = (SCREEN_WIDTH -(row+1)*space)/row;
    float height = (CGRectGetHeight(self.frame) -14  -(groupArray.count-1)*space) / groupArray.count ;
    
    NSInteger line = 0;
    for (NSArray *array in groupArray ) {
        CGFloat x = space + (row - array.count)*width/2;
        CGFloat y = space + (height+space)*line;
        
        for (int i = 0; i<array.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:self.btnNormalBackGroundColor?:[UIColor whiteColor]];
            [button setTitleColor: self.btnNormalColor?: [UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor: self.btnHighlightedColor?: [UIColor blackColor] forState:UIControlStateHighlighted];
            [button setTitleColor: self.btnDisabledColor?: [UIColor blackColor] forState:UIControlStateDisabled];
            button.titleLabel.font = self.font?:[UIFont systemFontOfSize:15];
            [button addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:nil];
            button.frame = CGRectMake(x + (width+space)*i, y + 0.5, width - 0.5 , height - 0.5);
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds = YES;
            NSString *string = array[i];
            if ([string isEqualToString:@""]) {
                [button setImage:HTCLOAD_IMAGE(@"ic_keyboard_backspace_small") forState:UIControlStateNormal];
                [button addTarget:self action:@selector(buttonBackspace:) forControlEvents:UIControlEventTouchUpInside];
                CGRect rect = button.frame;
                rect.size.width += 10;
                
                button.frame  =  rect;
            }else{
                [button setTitle:array[i] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(buttonInput:) forControlEvents:UIControlEventTouchUpInside];
            }
            [self addSubview:button];
            [dic setObject:button forKey:string];
        }
        line ++ ;
    }
    self.btnDic = dic;
}
-(void)buttonBackspace:(UIButton*)button
{
    if (self.backSpaceBtnEvent) {
        self.backSpaceBtnEvent(button);
    }
    button.backgroundColor = self.btnNormalBackGroundColor?:[UIColor whiteColor];
}

-(void)buttonInput:(UIButton*)button
{
    if (self.buttonInputEvent) {
        self.buttonInputEvent(button);
    }
    button.backgroundColor = self.btnNormalBackGroundColor?:[UIColor whiteColor];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"highlighted"]) {
        if ([object isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)object;
            BOOL isHighlighted = [change[@"new"] boolValue];
            [button setBackgroundColor:isHighlighted?(self.btnHighlightedBackGroundColor?:[UIColor lightGrayColor]):(self.btnNormalBackGroundColor?:[UIColor whiteColor])];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
-(void)dealloc
{
    [self.btnDic.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeObserver:self forKeyPath:@"highlighted" context:nil];
    }];
}
  

- (void)longPressPageView:(UILongPressGestureRecognizer *)longPress
{
    CGPoint location = [longPress locationInView:longPress.view];
    UIButton *button = [self buttonWithLocation:location];
    
    switch (longPress.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self.popView removeFromSuperview];

            if (button && button.enabled) {
                if (button.titleLabel.text == nil) {
                    [self buttonBackspace:button];
                }
                else
                {
                    [self buttonInput:button];
                }
                button.highlighted = false;
            }
            else
            {
                if (self.lastBtn.enabled) {
                    self.lastBtn.highlighted = false;
                }
            }
             self.lastBtn = nil;
            break;
            
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged: {
       
            id content;
            NSString * text = button.titleLabel.text;
            if (text.length>0) {
                content = text;
            }
            else
            {
                content = button.imageView.image;
            }
            if (self.lastBtn == nil) {
                self.lastBtn = button;
            }
            else if (self.lastBtn != button) {
                if (self.lastBtn.enabled) {
                    self.lastBtn.highlighted = false;
                }
                self.lastBtn = button;
            }
            if (button.enabled) {
                button.highlighted = true;
            }
            
            [self.popView showFrom:button withContent:content];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 根据手指位置所在的表情按钮
- (UIButton *)buttonWithLocation:(CGPoint)location
{
    for (UIButton *button in self.btnDic.allValues) {
        if (CGRectContainsPoint(button.frame, location)) {
//            if (button.enabled == NO) {
//                return nil;
//            }
            return button;
        }
    }
    return nil;
}



@end
