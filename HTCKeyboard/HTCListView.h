//
//  HTCListView.h
//  keyboard
//
//  Created by KT--stc08 on 2018/5/4.
//  Copyright © 2018年 货大大. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTCListView : UIView
@property(nonatomic,copy)NSArray *groupArray;
@property(nonatomic,copy)NSArray *disabledArray;
@property(nonatomic,copy)void(^backSpaceBtnEvent)(UIButton *button);
@property(nonatomic,copy)void(^buttonInputEvent)(UIButton *button);
//按钮背景颜色
@property(nonatomic,copy)UIColor *btnNormalBackGroundColor;
@property(nonatomic,copy)UIColor *btnHighlightedBackGroundColor;
@property(nonatomic,copy)UIColor *btnDisabledBackGroundColor;
//按钮字体颜色
@property(nonatomic,copy)UIColor *btnNormalColor;
@property(nonatomic,copy)UIColor *btnHighlightedColor;
@property(nonatomic,copy)UIColor *btnDisabledColor;
@property(nonatomic,copy)UIFont *font;
@end
