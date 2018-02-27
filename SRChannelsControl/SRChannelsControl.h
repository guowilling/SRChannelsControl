//
//  SRChannelsControl.h
//  SRChannelsControlDemo
//
//  Created by https://github.com/guowilling on 2017/8/16.
//  Copyright © 2017年 SR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRChannelsTitleStyle;

@interface SRChannelsControl : UIView

+ (instancetype)channelsControlWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles titleStyle:(SRChannelsTitleStyle *)titleStyle childVCs:(NSArray<UIViewController *> *)childVCs parentVC:(UIViewController *)parentVC;

@end
