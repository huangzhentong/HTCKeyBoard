//
//  HTCPopView.m
//  keyboard
//
//  Created by KT--stc08 on 2018/5/4.
//  Copyright © 2018年 货大大. All rights reserved.
//

#import "HTCPopView.h"
#import "HTCHeader.h"
@interface HTCPopView()
{

}
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong)UILabel *label;
@end

@implementation HTCPopView

+(instancetype)popView
{
    HTCPopView *popView = [[HTCPopView alloc] init];
    popView.textColor = [UIColor blackColor];
    UIImage *image = HTCLOAD_IMAGE(@"emoticon_keyboard_magnifier");
    popView.image = image;
    popView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    return popView;
}

-(UIImageView*)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        _imageView.contentMode = UIViewContentModeCenter;
        CGFloat space = 10 ;
        CGFloat width = self.frame.size.width - space*2;
        _imageView.frame = CGRectMake(space,space,  width, width);
    }
    return _imageView;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGFloat space = 5 ;
    CGFloat width = self.frame.size.width - space*2;
    self.imageView.frame = CGRectMake(space,space,  width, width);
    self.label.frame = CGRectMake(space,space,  width, width);
}
-(UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        [self addSubview:_label];
        _label.textAlignment = NSTextAlignmentCenter;
        CGFloat space = 5 ;
        CGFloat width = self.frame.size.width - space*2;
        _label.frame = CGRectMake(space,space,  width, width);
    }
    return _label;
}

-(void)setFont:(UIFont *)font
{
    self.label.font = font;
}
-(void)setTextColor:(UIColor *)textColor
{
    self.label.textColor = textColor;
}


-(void)showFrom:(UIView *)view withContent:(NSString *)content
{
    if (!view) return;
//    self.emoBtn.emotion = button.emotion;
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 计算出被点击的按钮在window中的frame
    CGRect btnFrame = [view convertRect:view.bounds toView:nil];
    
    CGRect rect = self.frame;
    rect.origin.y = CGRectGetMidY(btnFrame) - rect.size.height;
    self.frame  = rect;
    CGPoint point = self.center;
    point.x = CGRectGetMidX(btnFrame);
    self.center = point;
    if (CGRectGetMinX(self.frame) <=0) {
        rect.origin.x = 0;
        self.frame = rect;
    }
    else if(CGRectGetMaxX(self.frame) >= SCREEN_WIDTH)
    {
        rect.origin.x = SCREEN_WIDTH - rect.size.width - 0;
        self.frame = rect;
    }
    
    
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.label.hidden = YES;
        self.imageView.hidden = YES;
        if ([content isKindOfClass:[NSString class]]) {
//            self.label.transform = CGAffineTransformMakeTranslation(0, -30);
            self.label.text = content;
            self.label.hidden = NO;
        }
        else if([content isKindOfClass:[UIImage class]])
        {
//            self.imageView.transform = CGAffineTransformMakeTranslation(0, -30);
            self.imageView.image = (UIImage*)content;
            self.imageView.hidden = NO;
        }
       
    } completion:^(BOOL finished) {
        
    }];
}

@end
