//
//  SRChannelsContent.h
//  SRChannelsControlDemo
//
//  Created by https://github.com/guowilling on 2017/8/16.
//  Copyright © 2017年 SR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRChannelsContent;

@protocol SRChannelsContentDelegate <NSObject>

- (void)channelsContent:(SRChannelsContent *)channelsContent scrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress;
- (void)channelsContent:(SRChannelsContent *)channelsContent didEndScrollAtIndex:(NSInteger)atIndex;

@end

@interface SRChannelsContent : UIView

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC;

@property (nonatomic, weak) id<SRChannelsContentDelegate> delegate;

- (void)didSelectIndex:(NSInteger)index;

@end
