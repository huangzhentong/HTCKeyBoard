//
//  HTCKeyboard.h
//  keyboard
//
//  Created by 货大大 on 16/3/28.
//  Copyright © 2016年 货大大. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTCKeyboard : UIInputView<UITextInputDelegate>

//按钮背景颜色
@property(nonatomic,copy)UIColor *btnNormalBackGroundColor;
@property(nonatomic,copy)UIColor *btnHighlightedBackGroundColor;
@property(nonatomic,copy)UIColor *btnDisabledBackGroundColor;
//按钮字体颜色
@property(nonatomic,copy)UIColor *btnNormalColor;
@property(nonatomic,copy)UIColor *btnHighlightedColor;
@property(nonatomic,copy)UIColor *btnDisabledColor;
@property(nonatomic,copy)UIFont *font;
//@property (nonatomic,assign) BOOL isAutoScroll;
@end
