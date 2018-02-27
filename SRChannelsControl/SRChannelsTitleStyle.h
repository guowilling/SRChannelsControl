//
//  SRChannelsTitleStyle.h
//  SRChannelsControlDemo
//
//  Created by https://github.com/guowilling on 2017/8/16.
//  Copyright © 2017年 SR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRChannelsTitleStyle : NSObject

@property (nonatomic, assign) BOOL isNavigationTitleView;

@property (nonatomic, assign) BOOL isScrollEnabled;

@property (nonatomic, assign) CGFloat  titleHeight;
@property (nonatomic, assign) CGFloat  titleWitdh;
@property (nonatomic, assign) CGFloat  titleMargin;
@property (nonatomic, strong) UIFont  *titleFont;
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectdColor;
@property (nonatomic, strong) UIColor *titleSelectdBgColor;

@property (nonatomic, assign) BOOL isTitleSeparatorLineDisplayed;

@property (nonatomic, assign) BOOL    isTitleScaling;
@property (nonatomic, assign) CGFloat scaleRange;

@property (nonatomic, assign) BOOL     isBottomLineDisplayed;
@property (nonatomic, strong) UIColor *bottomLineColor;
@property (nonatomic, assign) CGFloat  bottomLineHeight;

@property (nonatomic, assign) BOOL     isSliderDisplayed;
@property (nonatomic, strong) UIColor *sliderColor;
@property (nonatomic, assign) CGFloat  sliderAlpha;
@property (nonatomic, assign) CGFloat  sliderHeight;
@property (nonatomic, assign) CGFloat  sliderInset;

@property (nonatomic, assign) UIColor *borderColor;
@property (nonatomic, assign) CGFloat  borderWidth;
@property (nonatomic, assign) CGFloat  cornerRadius;

@property (nonatomic, assign) CGFloat contentY;

+ (instancetype)defaultChannelsTitleStyle;

@end
