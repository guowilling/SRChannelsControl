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
            titleStyle.isScrollEnabled = true;
            titleStyle.isTitleScaling = true;
            titleStyle.isBottomLineDisplayed = false;
            titleStyle.isSliderDisplayed = false;
            break;
        case 1:
            titleStyle.isScrollEnabled = true;
            titleStyle.isTitleScaling = false;
            titleStyle.isBottomLineDisplayed = true;
            titleStyle.isSliderDisplayed = false;
            break;
        case 2:
            titleStyle.isScrollEnabled = true;
            titleStyle.isTitleScaling = false;
            titleStyle.isBottomLineDisplayed = false;
            titleStyle.isSliderDisplayed = true;
            break;
        case 3:
            titleStyle.isScrollEnabled = false;
            titleStyle.isTitleScaling = true;
            titleStyle.isBottomLineDisplayed = true;
            titleStyle.isSliderDisplayed = false;
            break;
        case 4:
            titleStyle.isScrollEnabled = false;
            titleStyle.isTitleScaling = true;
            titleStyle.isBottomLineDisplayed = false;
            titleStyle.isSliderDisplayed = true;
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:[[TestViewController alloc] initWithTitleStyle:titleStyle] animated:YES];
}

@end
