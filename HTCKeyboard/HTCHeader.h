//
//  HTCHeader.h
//  keyboard
//
//  Created by KT--stc08 on 2018/5/4.
//  Copyright © 2018年 货大大. All rights reserved.
//

#ifndef HTCHeader_h
#define HTCHeader_h
#import "UIImage+Bundle.h"

#endif /* HTCHeader_h */

#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT  CGRectGetHeight([UIScreen mainScreen].bounds)



#define HTCBUNDLE_NAME   @"HTCKeyboardRes.bundle"
#define HTCBUNDLE_PATH   [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:HTCBUNDLE_NAME]
#define HTCBUNDLE        [NSBundle bundleWithPath:HTCBUNDLE_PATH]

//#define HTCLOAD_IMAGE(imageName) [UIImage imageWithContentsOfFile:[HTCBUNDLE_PATH stringByAppendingPathComponent:imageName]]
#define HTCLOAD_IMAGE(imageName) [UIImage getBundleImage:imageName]


//NSBundle *bundle = [NSBundle bundleForClass:[SVProgressHUD class]];
//NSURL *url = [bundle URLForResource:@"SVProgressHUD" withExtension:@"bundle"];
//NSBundle *imageBundle = [NSBundle bundleWithURL:url];
//
//NSString *path = [imageBundle pathForResource:@"angle-mask" ofType:@"png"];

