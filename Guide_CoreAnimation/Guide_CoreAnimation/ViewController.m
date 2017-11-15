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
@property (nonatomic, strong) CAShapeLayer *waveLineLayer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureWaveLineLayer];
}

- (void)configureWaveLineLayer
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.containerView.bounds;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 1.0;
    [self.containerView.layer addSublayer:shapeLayer];
    shapeLayer.path = [self createWaveLinePath].CGPath;
    
    self.waveLineLayer = shapeLayer;
}

- (UIBezierPath *)createWaveLinePath
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 100.0)];
    [bezierPath addCurveToPoint:CGPointMake(200.0, 100.0) controlPoint1:CGPointMake(50.0, 50.0) controlPoint2:CGPointMake(150.0, 150.0)];
    return bezierPath;
}

- (IBAction)go:(id)sender
{
    [self.waveLineLayer removeAnimationForKey:kWaveLineLayerStrokeAnimationKey];
    CABasicAnimation *strokeAniamtion = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAniamtion.fromValue = @0;
    strokeAniamtion.toValue = @1.0;
    strokeAniamtion.duration = 1.0;
    strokeAniamtion.removedOnCompletion = NO;
    strokeAniamtion.fillMode = kCAFillModeForwards;
    [self.waveLineLayer addAnimation:strokeAniamtion forKey:kWaveLineLayerStrokeAnimationKey];
}

- (IBAction)stop:(id)sender
{
    self.waveLineLayer.strokeEnd = self.waveLineLayer.presentationLayer.strokeEnd;
    [self.waveLineLayer removeAnimationForKey:kWaveLineLayerStrokeAnimationKey];
}

@end
