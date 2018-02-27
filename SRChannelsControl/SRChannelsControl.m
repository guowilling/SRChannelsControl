//
//  SRChannelsControl.m
//  SRChannelsControlDemo
//
//  Created by https://github.com/guowilling on 2017/8/16.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "SRChannelsControl.h"
#import "SRChannelsTitleStyle.h"
#import "SRChannelsTitle.h"
#import "SRChannelsContent.h"
#import "UIColor+SRChannelsControl.h"

@interface SRChannelsControl () <SRChannelsTitleDelegate, SRChannelsContentDelegate>

@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, strong) SRChannelsTitleStyle *titleStyle;

@property (nonatomic, copy) NSArray *childVCs;
@property (nonatomic, strong) UIViewController *parentVC;

@property (nonatomic, weak) SRChannelsTitle *channelsTitle;
@property (nonatomic, weak) SRChannelsContent *channelsContent;

@end

@implementation SRChannelsControl

+ (instancetype)channelsControlWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles titleStyle:(SRChannelsTitleStyle *)titleStyle childVCs:(NSArray<UIViewController *> *)childVCs parentVC:(UIViewController *)parentVC {
    
    SRChannelsControl *channelsControl = [[SRChannelsControl alloc] initWithFrame:frame titles:titles titleStyle:titleStyle childVCs:childVCs parentVC:parentVC];
    return channelsControl;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles titleStyle:(SRChannelsTitleStyle *)titleStyle childVCs:(NSArray<UIViewController *> *)childVCs parentVC:(UIViewController *)parentVC {
    
    if (self = [super initWithFrame:frame]) {
        _titles = titles;
        _titleStyle = titleStyle;
        _childVCs = childVCs;
        _parentVC = parentVC;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    CGRect titleFrame = CGRectMake(0, 0, self.bounds.size.width, self.titleStyle.titleHeight);
    SRChannelsTitle *channelsTitle = [[SRChannelsTitle alloc] initWithFrame:titleFrame titles:self.titles titleStyle:self.titleStyle];
    channelsTitle.delegate = self;
    [self addSubview:channelsTitle];
    _channelsTitle = channelsTitle;
    
    CGRect contentFrame = CGRectMake(0, CGRectGetMaxY(titleFrame), self.bounds.size.width, self.bounds.size.height - self.titleStyle.titleHeight);
    SRChannelsContent *channelsContent = [[SRChannelsContent alloc] initWithFrame:contentFrame childVCs:self.childVCs parentVC:self.parentVC];
    channelsContent.delegate = self;
    [self addSubview:channelsContent];
    _channelsContent = channelsContent;
}

#pragma mark - SRChannelsTitleDelegate

- (void)channelsTitle:(SRChannelsTitle *)channelsTitle didSelectIndex:(NSInteger)index {
    
    [self.channelsContent didSelectIndex:index];
}

#pragma mark - SRChannelsContentDelegate

- (void)channelsContent:(SRChannelsContent *)channelsContent scrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    
    [self.channelsTitle scrollFromIndex:fromIndex toIndex:toIndex progress:progress];
}

- (void)channelsContent:(SRChannelsContent *)channelsContent didEndScrollAtIndex:(NSInteger)atIndex {
    
    [self.channelsTitle didEndScrollAtIndex:atIndex];
}

@end
