//
//  TestViewController.m
//  SRChannelsControlDemo
//
//  Created by Willing Guo on 2017/8/18.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "TestViewController.h"
#import "SRChannelsControl.h"
#import "SRChannelsTitleStyle.h"
#import "UIColor+SRChannelsControl.h"

@interface TestViewController ()

@property (nonatomic, strong) SRChannelsTitleStyle *titleStyle;

@end

@implementation TestViewController

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (instancetype)initWithTitleStyle:(SRChannelsTitleStyle *)titleStyle {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _titleStyle = titleStyle;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *titles;
    if (self.titleStyle.isScrollEnabled) {
        titles = @[@"Title1", @"Title2", @"Title3", @"Title4", @"Title5", @"Title6", @"Title7", @"Title8", @"Title999"];
    } else {
        titles = @[@"Title1", @"Title2", @"Title3", @"Title4", @"Title5"];
    }
    CGRect channelsControlFrame = CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height - 44);
    
    NSMutableArray *childVCs = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor sr_randomColor];
        [childVCs addObject:vc];
    }
    SRChannelsControl *channelsControl = [SRChannelsControl channelsControlWithFrame:channelsControlFrame titles:titles titleStyle:self.titleStyle childVCs:childVCs parentVC:self];
    [self.view addSubview:channelsControl];
}

@end
