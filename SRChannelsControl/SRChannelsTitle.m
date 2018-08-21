//
//  SRChannelsTitle.m
//  SRChannelsControlDemo
//
//  Created by https://github.com/guowilling on 2017/8/16.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "SRChannelsTitle.h"
#import "SRChannelsTitleStyle.h"
#import "UIColor+SRChannelsControl.h"

@interface  SRChannelsTitle ()

@property (nonatomic, weak) UIScrollView *containerScrollView;

@property (nonatomic, copy) NSArray *titles;

@property (nonatomic, strong) SRChannelsTitleStyle *titleStyle;

@property (nonatomic, copy) NSMutableArray<UILabel *> *titleLabels;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, weak) UIView *bottomLine;

@property (nonatomic, weak) UIView *slider;

@end

@implementation SRChannelsTitle

#pragma mark - Lazy Load

- (NSMutableArray<UILabel *> *)titleLabels {
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles titleStyle:(SRChannelsTitleStyle *)titleStyle {
    if (self = [super initWithFrame:frame]) {
        _titles = titles;
        _titleStyle = titleStyle;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    [self setupContainerScrollView];
    
    [self setupTitleLabels];
    
    [self setupBottomLine];
    
    [self setupSlider];
}

- (void)setupContainerScrollView{
    UIScrollView *containerScrollView = [[UIScrollView alloc] init];
    containerScrollView.frame = self.bounds;
    containerScrollView.showsHorizontalScrollIndicator = NO;
    containerScrollView.scrollsToTop = NO;
    containerScrollView.layer.borderWidth = self.titleStyle.borderWidth;
    containerScrollView.layer.borderColor = self.titleStyle.borderColor.CGColor;
    containerScrollView.layer.cornerRadius = self.titleStyle.cornerRadius;
    [self addSubview:containerScrollView];
    _containerScrollView = containerScrollView;
}

- (void)setupTitleLabels {
    for (int i = 0; i < self.titles.count; i++) {
        NSString *title = self.titles[i];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        titleLabel.tag = i;
        titleLabel.font = self.titleStyle.titleFont;
        titleLabel.textColor = i == 0 ? self.titleStyle.titleSelectdColor : self.titleStyle.titleNormalColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapTitleLabel:)];
        titleLabel.userInteractionEnabled = YES;
        [titleLabel addGestureRecognizer:tapGes];
        [self.containerScrollView addSubview:titleLabel];
        [self.titleLabels addObject:titleLabel];
    }
    [self setupTitleLabelsFrame];
}

- (void)setupTitleLabelsFrame {
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelW = self.bounds.size.width / self.titleLabels.count;
    CGFloat labelH = self.bounds.size.height;
    for (int i = 0; i < self.titleLabels.count; i++) {
        UILabel *label = self.titleLabels[i];
        if (self.titleStyle.isScrollEnabled) {
            labelW = [self.titles[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName: self.titleStyle.titleFont}
                                                  context:nil].size.width;
            if (i == 0) {
                labelX = self.titleStyle.titleMargin * 0.5;
            } else {
                UILabel *preLabel = self.titleLabels[i - 1];
                labelX = CGRectGetMaxX(preLabel.frame) + self.titleStyle.titleMargin;
            }
        } else {
            labelX = labelW * i;
        }
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        if (self.titleStyle.isTitleScaling && i == 0) {
            label.transform = CGAffineTransformMakeScale(self.titleStyle.scaleRange, self.titleStyle.scaleRange);
        }
        
        if (self.titleStyle.isTitleSeparatorLineDisplayed) {
            if ( i != self.titles.count - 1) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(labelX + labelW - 0.5, 0, 1, self.titleStyle.titleHeight)];
                line.backgroundColor = [UIColor darkGrayColor];
                [_containerScrollView addSubview:line];
            }
        }
    }
    
    if (self.titleStyle.isScrollEnabled) {
        self.containerScrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.titleLabels.lastObject.frame) + self.titleStyle.titleMargin * 0.5, 0);
    }
}

- (void)setupBottomLine {
    if (!self.titleStyle.isBottomLineDisplayed) {
        return;
    }
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = self.titleStyle.bottomLineColor;
    bottomLine.frame = CGRectMake(self.titleLabels.firstObject.frame.origin.x,
                                  self.bounds.size.height - self.titleStyle.bottomLineHeight,
                                  self.titleLabels.firstObject.bounds.size.width,
                                  self.titleStyle.bottomLineHeight);
    [self.containerScrollView addSubview:bottomLine];
    _bottomLine = bottomLine;
}

- (void)setupSlider {
    if (!self.titleStyle.isSliderDisplayed) {
        return;
    }
    UIView *slider = [[UIView alloc] init];
    slider.backgroundColor = self.titleStyle.sliderColor;
    slider.alpha = self.titleStyle.sliderAlpha;
    CGFloat sliderW = 0;
    if (self.titleStyle.isScrollEnabled) {
        sliderW = self.titleLabels.firstObject.frame.size.width + self.titleStyle.titleMargin;
    } else {
        sliderW = self.titleLabels.firstObject.frame.size.width - 2 * self.titleStyle.sliderInset;
    }
    CGFloat sliderH = self.titleStyle.sliderHeight;
    slider.bounds = CGRectMake(0, 0, sliderW, sliderH);
    slider.center = self.titleLabels.firstObject.center;
    slider.layer.cornerRadius = self.titleStyle.sliderHeight * 0.5;
    slider.layer.masksToBounds = true;
    [self.containerScrollView addSubview:slider];
    _slider = slider;
}

#pragma mark - Monitor Methods

- (void)didTapTitleLabel:(UIGestureRecognizer *)tapGes {
    UILabel *currentLabel = (UILabel *)tapGes.view;
    if (self.currentIndex == currentLabel.tag) {
        return;
    }
    UILabel *lastLabel = self.titleLabels[self.currentIndex];
    lastLabel.textColor = self.titleStyle.titleNormalColor;
    currentLabel.textColor = self.titleStyle.titleSelectdColor;
    self.currentIndex = currentLabel.tag;
    
    if (self.titleStyle.isTitleScaling) {
        currentLabel.transform = lastLabel.transform;
        lastLabel.transform = CGAffineTransformIdentity;
    }

    if (self.titleStyle.isBottomLineDisplayed) {
        CGRect frame = self.bottomLine.frame;
        frame.origin.x = currentLabel.frame.origin.x;
        frame.size.width = currentLabel.frame.size.width;
        self.bottomLine.frame = frame;
    }
    
    if (self.titleStyle.isSliderDisplayed) {
        CGFloat sliderW = 0;
        if (self.titleStyle.isScrollEnabled) {
            sliderW = currentLabel.frame.size.width + self.titleStyle.titleMargin;
        } else {
            sliderW = currentLabel.frame.size.width - 2 * self.titleStyle.sliderInset;
        }
        CGRect frame = self.slider.frame;
        frame.size.width = sliderW;
        self.slider.frame = frame;
        self.slider.center = currentLabel.center;
    }

    if ([self.delegate respondsToSelector:@selector(channelsTitle:didSelectIndex:)]) {
        [self.delegate channelsTitle:self didSelectIndex:self.currentIndex];
    }
    
    [self adjustPosition:currentLabel];
}

#pragma mark - Assist Methods

- (void)adjustPosition:(UILabel *)tapLabel {
    if (!self.titleStyle.isScrollEnabled) {
        return;
    }
    CGFloat offsetX = tapLabel.center.x - self.containerScrollView.bounds.size.width * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    CGFloat maxOffset = self.containerScrollView.contentSize.width - self.bounds.size.width;
    if (offsetX > maxOffset) {
        offsetX = maxOffset;
    }
    [self.containerScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - Public Methods

- (void)scrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    UILabel *lastLabel = self.titleLabels[fromIndex];
    UILabel *toLabel = self.titleLabels[toIndex];
    
    NSArray<NSNumber *> *normalRGB = [UIColor sr_getRGBAValue:self.titleStyle.titleNormalColor];
    NSArray<NSNumber *> *selectedRGB = [UIColor sr_getRGBAValue:self.titleStyle.titleSelectdColor];
    NSArray<NSNumber *> *deltaRGB = @[@(selectedRGB[0].floatValue - normalRGB[0].floatValue),
                                      @(selectedRGB[1].floatValue - normalRGB[1].floatValue),
                                      @(selectedRGB[2].floatValue - normalRGB[2].floatValue)];
    lastLabel.textColor = [UIColor sr_colorWithR:selectedRGB[0].floatValue - deltaRGB[0].floatValue * progress
                                               G:selectedRGB[1].floatValue - deltaRGB[1].floatValue * progress
                                               B:selectedRGB[2].floatValue - deltaRGB[2].floatValue * progress];
    toLabel.textColor = [UIColor sr_colorWithR:normalRGB[0].floatValue + deltaRGB[0].floatValue * progress
                                             G:normalRGB[1].floatValue + deltaRGB[1].floatValue * progress
                                             B:normalRGB[2].floatValue + deltaRGB[2].floatValue * progress];
    
    if (self.titleStyle.isBottomLineDisplayed) {
        CGFloat deltaX = toLabel.frame.origin.x - lastLabel.frame.origin.x;
        CGFloat deltaW = toLabel.frame.size.width - lastLabel.frame.size.width;
        CGRect frame = self.bottomLine.frame;
        frame.origin.x = lastLabel.frame.origin.x + deltaX * progress;
        frame.size.width = lastLabel.frame.size.width + deltaW * progress;
        self.bottomLine.frame = frame;
    }
    
    if (self.titleStyle.isTitleScaling) {
        CGFloat deltaScale = self.titleStyle.scaleRange - 1.0;
        lastLabel.transform = CGAffineTransformMakeScale(self.titleStyle.scaleRange - deltaScale * progress,
                                                         self.titleStyle.scaleRange - deltaScale * progress);
        toLabel.transform = CGAffineTransformMakeScale(1.0 + deltaScale * progress, 1.0 + deltaScale * progress);
    }
    
    if (self.titleStyle.isSliderDisplayed) {
        CGFloat lastWidth = self.titleStyle.isScrollEnabled ? (lastLabel.frame.size.width + self.titleStyle.titleMargin) : (lastLabel.frame.size.width - 2 * self.titleStyle.sliderInset);
        CGFloat toWidth = self.titleStyle.isScrollEnabled ? (toLabel.frame.size.width + self.titleStyle.titleMargin) : (toLabel.frame.size.width - 2 * self.titleStyle.sliderInset);
        CGFloat deltaW = toWidth - lastWidth;
        CGFloat deltaX = toLabel.center.x - lastLabel.center.x;
        
        CGRect frame = self.frame;
        frame.size.width = lastWidth + deltaW * progress;
        
        self.frame = frame;
        CGPoint center = self.slider.center;
        center.x = lastLabel.center.x + deltaX * progress;
        self.slider.center = center;
    }
}

- (void)didEndScrollAtIndex:(NSInteger)atIndex {
    UILabel *lastLabel = self.titleLabels[self.currentIndex];
    lastLabel.textColor = self.titleStyle.titleNormalColor;
    lastLabel.backgroundColor = [UIColor clearColor];
    
    UILabel *atLabel = self.titleLabels[atIndex];
    atLabel.textColor = self.titleStyle.titleSelectdColor;
    atLabel.backgroundColor = self.titleStyle.titleSelectdBgColor;
    
    self.currentIndex = atIndex;
    
    [self adjustPosition:atLabel];
}

@end
