//
//  SRChannelsTitleStyle.m
//  SRChannelsControlDemo
//
//  Created by https://github.com/guowilling on 2017/8/16.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "SRChannelsTitleStyle.h"
#import "UIColor+SRChannelsControl.h"

@implementation SRChannelsTitleStyle

+ (instancetype)defaultChannelsTitleStyle {
    SRChannelsTitleStyle *style = [[SRChannelsTitleStyle alloc] init];
    style.isNavigationTitleView = NO;
    style.isScrollEnabled = NO;
    
    style.titleHeight = 44.0;
    style.titleWitdh = 0;
    style.titleMargin = 20.0;
    style.titleFont = [UIFont systemFontOfSize:15.0];
    style.titleNormalColor = [UIColor sr_colorWithR:0 G:0 B:0];
    style.titleSelectdColor = [UIColor sr_colorWithR:255 G:0 B:0];
    style.titleSelectdBgColor = [UIColor clearColor];
    
    style.isTitleSeparatorLineDisplayed = NO;
    
    style.isTitleScaling = NO;
    style.scaleRange = 1.2;
    
    style.isBottomLineDisplayed = NO;
    style.bottomLineColor = [UIColor orangeColor];
    style.bottomLineHeight = 2;
    
    style.isSliderDisplayed = NO;
    style.sliderColor = [UIColor blackColor];
    style.sliderAlpha = 0.1;
    style.sliderHeight = 25;
    style.sliderInset = 10;
    
    style.borderColor = [UIColor clearColor];
    style.borderWidth = 0;
    style.cornerRadius = 0;
    
    style.contentY = 0;
    
    return style;
}

@end
