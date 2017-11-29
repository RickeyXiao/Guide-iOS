//
//  ViewController.m
//  Guide_UIVisualEffectView
//
//  Created by Mac on 2017/11/20.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) UIVisualEffectView *blurView;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAppResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAppBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleAppResignActive
{
    [self.view addSubview:self.blurView];
    self.blurView.frame = self.view.bounds;
}

- (void)handleAppBecomeActive
{
    [self.blurView removeFromSuperview];
}

- (UIVisualEffectView *)blurView
{
    if (!_blurView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
        _blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    }
    return _blurView;
}

@end
