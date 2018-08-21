//
//  ViewController.m
//  SRChannelsControlDemo
//
//  Created by Willing Guo on 2017/8/18.
//  Copyright © 2017年 SR. All rights reserved.
//

#import "ViewController.h"
#import "SRChannelsContent.h"
#import "SRChannelsTitleStyle.h"
#import "UIColor+SRChannelsControl.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    SRChannelsTitleStyle *titleStyle = [SRChannelsTitleStyle defaultChannelsTitleStyle];
    switch (row) {
        case 0:
            titleStyle.isScrollEnabled = YES;
            titleStyle.isTitleScaling = YES;
            titleStyle.isBottomLineDisplayed = NO;
            titleStyle.isSliderDisplayed = NO;
            break;
        case 1:
            titleStyle.isScrollEnabled = YES;
            titleStyle.isTitleScaling = NO;
            titleStyle.isBottomLineDisplayed = YES;
            titleStyle.isSliderDisplayed = NO;
            break;
        case 2:
            titleStyle.isScrollEnabled = YES;
            titleStyle.isTitleScaling = NO;
            titleStyle.isBottomLineDisplayed = NO;
            titleStyle.isSliderDisplayed = YES;
            break;
        case 3:
            titleStyle.isScrollEnabled = NO;
            titleStyle.isTitleScaling = YES;
            titleStyle.isBottomLineDisplayed = YES;
            titleStyle.isSliderDisplayed = NO;
            break;
        case 4:
            titleStyle.isScrollEnabled = NO;
            titleStyle.isTitleScaling = YES;
            titleStyle.isBottomLineDisplayed = NO;
            titleStyle.isSliderDisplayed = YES;
            break;
        case 5:
            titleStyle.isScrollEnabled = NO;
            titleStyle.isNavigationTitleView = YES;
            titleStyle.isTitleSeparatorLineDisplayed = YES;
            titleStyle.titleWitdh = 240;
            titleStyle.titleHeight = 36;
            titleStyle.borderWidth = 1;
            titleStyle.borderColor = [UIColor blackColor];
            titleStyle.cornerRadius = 5;
            break;
    }
    [self.navigationController pushViewController:[[TestViewController alloc] initWithTitleStyle:titleStyle] animated:YES];
}

@end
