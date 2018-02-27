//
//  SRChannelsTitle.h
//  SRChannelsControlDemo
//
//  Created by https://github.com/guowilling on 2017/8/16.
//  Copyright © 2017年 SR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRChannelsTitleStyle, SRChannelsTitle;

@protocol SRChannelsTitleDelegate <NSObject>

- (void)channelsTitle:(SRChannelsTitle *)channelsTitle didSelectIndex:(NSInteger)index;

@end

@interface SRChannelsTitle : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles titleStyle:(SRChannelsTitleStyle *)titleStyle;

@property (nonatomic, weak) id<SRChannelsTitleDelegate> delegate;

- (void)scrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress;

- (void)didEndScrollAtIndex:(NSInteger)atIndex;

@end
