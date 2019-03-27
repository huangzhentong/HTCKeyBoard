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
    NSBundle *bundle = [NSBundle bundleForClass:[HTCKeyboard class]];
    NSURL *url = [bundle URLForResource:@"HTCKeyboardRes" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    
    return imageBundle;
}
+(UIImage*)getBundleImage:(NSString*)imageName withType:(NSString*)type
{
    NSString *path = [[self getBundel] pathForResource:imageName ofType:type];
    
    return [UIImage imageWithContentsOfFile:path];
}
+(UIImage*)getBundleImage:(NSString*)imageName
{
    return [self getBundleImage:imageName withType:@"png"];
}

@end
