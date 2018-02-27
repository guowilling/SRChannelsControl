//
//  UIColor+SRChannelsControl.h
//  SRChannelsControlDemo
//
//  Created by https://github.com/guowilling on 2017/8/16.
//  Copyright © 2017年 SR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SRChannelsControl)

+ (instancetype)sr_colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B;

+ (instancetype)sr_randomColor;

+ (NSArray<NSNumber *> *)sr_getRGBAValue:(UIColor *)color;

@end
