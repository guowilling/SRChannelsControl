//
//  UIColor+SRChannelsControl.m
//  SRChannelsControlDemo
//
//  Created by https://github.com/guowilling on 2017/8/16.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "UIColor+SRChannelsControl.h"

@implementation UIColor (SRChannelsControl)

+ (instancetype)sr_colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B {
    return [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:1.0];
}

+ (instancetype)sr_randomColor {
    return [self sr_colorWithR:arc4random_uniform(256) G:arc4random_uniform(256) B:arc4random_uniform(256)];
}

+ (NSArray<NSNumber *> *)sr_getRGBAValue:(UIColor *)color {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [color getRed:&r green:&g blue:&b alpha:&a];
    } else {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        r = components[0] * 255;
        g = components[1] * 255;
        b = components[2] * 255;
        a = components[3];
    }
    return @[@(r), @(g), @(b), @(a)];
}

@end
