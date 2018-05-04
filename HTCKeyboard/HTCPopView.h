//
//  HTCPopView.h
//  keyboard
//
//  Created by KT--stc08 on 2018/5/4.
//  Copyright © 2018年 货大大. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HTCPopView : UIImageView
@property(nonatomic,copy)UIFont *font;
@property(nonatomic,copy)UIColor *textColor;
+(instancetype)popView;
-(void)showFrom:(UIView *)view withContent:(id)content;
@end
