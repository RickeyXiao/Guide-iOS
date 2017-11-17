//
//  ViewController.m
//  Guide_CoreAnimation
//
//  Created by Mac on 2017/11/15.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import "ViewController.h"

static NSString * const kWaveLineLayerStrokeAnimationKey = @"StrokeAnimation";

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, strong) CAShapeLayer *contentLayer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureContentLayer];
}

- (void)configureContentLayer
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.containerView.bounds;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 1.0;
    [self.containerView.layer addSublayer:shapeLayer];
    
    shapeLayer.path = [self createTrianglePath].CGPath;

    self.contentLayer = shapeLayer;
}

- (UIBezierPath *)createTrianglePath
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(100.0, 50.0)];
    [bezierPath addLineToPoint:CGPointMake(50.0, 150.0)];
    [bezierPath addLineToPoint:CGPointMake(150.0, 150.0)];
    [bezierPath closePath];
    return bezierPath;
}

- (IBAction)go:(id)sender
{
    [self.contentLayer removeAnimationForKey:kWaveLineLayerStrokeAnimationKey];
    CABasicAnimation *strokeAniamtion = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAniamtion.fromValue = @0;
    strokeAniamtion.toValue = @1.0;
    strokeAniamtion.duration = 2.0;
    strokeAniamtion.removedOnCompletion = NO;
    strokeAniamtion.fillMode = kCAFillModeForwards;
    [self.contentLayer addAnimation:strokeAniamtion forKey:kWaveLineLayerStrokeAnimationKey];
}

- (IBAction)stop:(id)sender
{
    self.contentLayer.strokeEnd = self.contentLayer.presentationLayer.strokeEnd;
    [self.contentLayer removeAnimationForKey:kWaveLineLayerStrokeAnimationKey];
}

@end
