//
//  UIImage+Bundle.m
//  Demo
//
//  Created by KT--stc08 on 2019/3/27.
//  Copyright © 2019 KT--stc08. All rights reserved.
//

#import "UIImage+Bundle.h"

#import "HTCKeyboard.h"

@implementation UIImage (Bundle)



+(NSBundle*)getBundel
{
   static  NSBundle *imageBundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *bundle = [NSBundle bundleForClass:[HTCKeyboard class]];
        NSURL *url = [bundle URLForResource:@"HTCKeyboardRes" withExtension:@"bundle"];
         imageBundle = [NSBundle bundleWithURL:url];
    });
    
    return imageBundle;
}

+(UIImage*)getBundleImage:(NSString*)imageName
{
   return  [UIImage imageNamed:imageName inBundle:[self getBundel] compatibleWithTraitCollection:nil];
}

@end
