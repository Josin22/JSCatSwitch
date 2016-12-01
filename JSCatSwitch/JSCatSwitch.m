//
//  JSCatSwitch.m
//  JSCatSwitchDemo
//
//  Created by 乔同新 on 16/9/8.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import "JSCatSwitch.h"
#import "DrawHelper.h"

@interface JSCatSwitch (){

    id _target;
    SEL _action;
    
    BOOL _switchOnStatue;
}

@property (strong, nonatomic) CAGradientLayer *bgGradientLayer;

@property (strong, nonatomic) NSArray *onColorArray;

@property (strong, nonatomic) NSArray *transitColorArray;

@property (strong, nonatomic) NSArray *offColorArray;

@property (strong, nonatomic) CAShapeLayer *catLayer;
//左眼
@property (strong, nonatomic) CAShapeLayer *leftEyeLayer;
//右眼
@property (strong, nonatomic) CAShapeLayer *rightEyeLayer;
//嘴
@property (strong, nonatomic) CAShapeLayer *mouseLayer;

@property (strong, nonatomic) CAShapeLayer *switchLineLayer;

@property (strong, nonatomic) CAShapeLayer *switchBallLayer;

@property (strong, nonatomic) DrawHelper *helper;

@end

@implementation JSCatSwitch

#pragma mark - life cycle

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self  initialize];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self  initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self  initialize];
    }
    return self;
}

#pragma mark - initialize

- (void) initialize{
    
    _switchOnStatue = YES;

    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 5;
    self.layer.shadowOffset = CGSizeMake(3.0, 3.0);
    [self.layer addSublayer:self.bgGradientLayer];
    
    self.helper = [[DrawHelper alloc]init];
    [self.helper drawCat:self.bounds];

    [self.layer addSublayer:self.catLayer];
    [self.catLayer addSublayer:self.switchLineLayer];
    [self.catLayer addSublayer:self.switchBallLayer];
    [self.catLayer addSublayer:self.leftEyeLayer];
    [self.catLayer addSublayer:self.rightEyeLayer];
    [self.catLayer addSublayer:self.mouseLayer];
}

#pragma mark - lazy load


- (CAShapeLayer *)catLayer{
    
    if (!_catLayer) {
        _catLayer = [CAShapeLayer layer];
        _catLayer.frame = self.bounds;
        _catLayer.lineJoin = kCALineJoinRound;
        _catLayer.lineCap = kCALineCapRound;
        _catLayer.fillColor = [UIColor whiteColor].CGColor;
        _catLayer.path = self.helper.catPath.CGPath;
    }
    return _catLayer;
}


- (CAShapeLayer *)switchLineLayer{
    
    if (!_switchLineLayer) {
        _switchLineLayer = [CAShapeLayer layer];
        _switchLineLayer.frame = [self bounds];
        _switchLineLayer.lineJoin = kCALineJoinRound;
        _switchLineLayer.lineWidth = 4;
        _switchLineLayer.strokeColor = [UIColor whiteColor].CGColor;
        _switchLineLayer.fillColor = [UIColor whiteColor].CGColor;
        //switch line
        _switchLineLayer.path = self.helper.switchLinePath.CGPath;
        
    }
    return _switchLineLayer;
}

- (CAShapeLayer *)switchBallLayer{
    
    if (!_switchBallLayer) {
        _switchBallLayer = [CAShapeLayer layer];
        _switchBallLayer.frame = [self bounds];
        _switchBallLayer.lineCap = kCALineCapRound;
        _switchBallLayer.lineJoin = kCALineJoinRound;
        _switchBallLayer.lineWidth = 4;
        _switchBallLayer.strokeColor = [UIColor whiteColor].CGColor;
        _switchBallLayer.fillColor = [UIColor whiteColor].CGColor;
        //switch ball
        _switchBallLayer.path = self.helper.switchLeftPath.CGPath;
    }
    return _switchBallLayer;
}

- (CAShapeLayer *)leftEyeLayer{
    
    if (!_leftEyeLayer) {
        _leftEyeLayer = [CAShapeLayer layer];
        _leftEyeLayer.frame = self.bounds;
        _leftEyeLayer.lineCap = kCALineCapRound;
        _leftEyeLayer.lineJoin = kCALineJoinRound;
        _leftEyeLayer.lineWidth = 2;
        _leftEyeLayer.strokeColor = (__bridge CGColorRef _Nullable)(self.onColorArray[1]);
        _leftEyeLayer.fillColor = (__bridge CGColorRef _Nullable)(self.onColorArray[1]);
        //左眼
        _leftEyeLayer.path = self.helper.leftPath.CGPath;
    }
    return _leftEyeLayer;
}

- (CAShapeLayer *)rightEyeLayer{
    
    if (!_rightEyeLayer) {
        _rightEyeLayer = [CAShapeLayer layer];
        _rightEyeLayer.frame = self.bounds;
        _rightEyeLayer.lineCap = kCALineCapRound;
        _rightEyeLayer.lineJoin = kCALineJoinRound;
        _rightEyeLayer.lineWidth = 2;
        _rightEyeLayer.strokeColor = (__bridge CGColorRef _Nullable)(self.onColorArray[1]);
        _rightEyeLayer.fillColor = (__bridge CGColorRef _Nullable)(self.onColorArray[1]);
        //右眼
        _rightEyeLayer.path = self.helper.rightPath.CGPath;
    }
    return _rightEyeLayer;
}

- (CAShapeLayer *)mouseLayer{
    
    if (!_mouseLayer) {
        _mouseLayer = [CAShapeLayer layer];
        _mouseLayer.frame = self.bounds;
        _mouseLayer.fillColor = [UIColor clearColor].CGColor;
        _mouseLayer.lineWidth = 2;
        _mouseLayer.lineCap = kCALineCapRound;
        _mouseLayer.lineJoin = kCALineJoinRound;
        _mouseLayer.strokeColor = (__bridge CGColorRef _Nullable)(self.onColorArray[1]);
        //嘴
        self.mouseLayer.path = self.helper.mousePath.CGPath;
    }
    return _mouseLayer;
}

- (CAGradientLayer*)bgGradientLayer{
    
    if (!_bgGradientLayer) {
        _bgGradientLayer = [CAGradientLayer layer];
        _bgGradientLayer.frame = self.bounds;
        _bgGradientLayer.cornerRadius =  5;
        _bgGradientLayer.startPoint = CGPointMake(1, 0);
        _bgGradientLayer.endPoint = CGPointMake(0, 1);
        _bgGradientLayer.colors = self.onColorArray;
        _bgGradientLayer.locations = @[@(0.0f) ,@(0.5f),@(1.0f)];
    }
    
    return _bgGradientLayer;
}


- (NSArray *)onColorArray{

    if (!_onColorArray) {
        _onColorArray = [NSArray array];
        _onColorArray = @[
                          (__bridge id)XNColor(54, 185, 254, 1).CGColor,
                          (__bridge id)XNColor(54, 151, 255, 1).CGColor,
                          (__bridge id)XNColor(54, 112, 255, 1).CGColor
                          ];
    }
    return _onColorArray;
}

- (NSArray *)offColorArray{
    
    if (!_offColorArray) {
        _offColorArray = [NSArray array];
        _offColorArray = @[
                           //末色
                           (__bridge id)XNColor(233, 71, 165, 1).CGColor,
                           (__bridge id)XNColor(233, 71, 139, 1).CGColor,
                           (__bridge id)XNColor(233, 71, 114, 1).CGColor
                          ];
    }
    return _offColorArray;
}


#pragma mark -  override getter / setter

- (BOOL)isOn{
    
    return _switchOnStatue;
}

- (void)setIsOn:(BOOL)isOn{
    
    _switchOnStatue = isOn;
    
    [self switchClick];
}


#pragma mark - Hit

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesEnded:touches withEvent:event];
    
//    /* 判断点击区域是否在圆内 */
//    CGPoint point = [[touches anyObject] locationInView:self];
//    point = [self.layer convertPoint:point toLayer:self.maskCircleLayer];
//    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:self.maskCircleLayer.path];
//    if ([path containsPoint:point]) {
//        
//    }
    [self switchClick];
}

- (void)switchClick{
    
    _switchOnStatue = !_switchOnStatue;
    NSArray *leftValues = nil;
    NSArray *rightValues = nil;
    NSArray *ballValue = nil;
    CGColorRef onColor = (__bridge CGColorRef _Nullable)(self.onColorArray[1]);
    CGColorRef offColor = (__bridge CGColorRef _Nullable)(self.offColorArray[1]);
    
    if (_switchOnStatue) {
        
        self.bgGradientLayer.colors = self.onColorArray;
        leftValues = @[(__bridge id)self.helper.lineLeftPath.CGPath,(__bridge id)self.helper.linePointLeftPath.CGPath,(__bridge id)self.helper.leftPath.CGPath];
        rightValues = @[(__bridge id)self.helper.lineRightPath.CGPath,(__bridge id)self.helper.linePointRightPath.CGPath,(__bridge id)self.helper.rightPath.CGPath];
        self.leftEyeLayer.strokeColor = onColor;
        self.rightEyeLayer.strokeColor = onColor;
        self.mouseLayer.strokeColor = onColor;
        ballValue = @[(__bridge id)self.helper.switchRightPath.CGPath,(__bridge id)self.helper.switchMiddlePath.CGPath,(__bridge id)self.helper.switchLeftPath.CGPath];
        
    } else {
        
        self.bgGradientLayer.colors = self.offColorArray;
        leftValues = @[(__bridge id)self.helper.leftPath.CGPath,(__bridge id)self.helper.linePointLeftPath.CGPath,(__bridge id)self.helper.lineLeftPath.CGPath];
        rightValues = @[(__bridge id)self.helper.rightPath.CGPath,(__bridge id)self.helper.linePointRightPath.CGPath,(__bridge id)self.helper.lineRightPath.CGPath];
        self.leftEyeLayer.strokeColor = offColor;
        self.rightEyeLayer.strokeColor = offColor;
        self.mouseLayer.strokeColor = offColor;
        ballValue = @[(__bridge id)self.helper.switchLeftPath.CGPath,(__bridge id)self.helper.switchMiddlePath.CGPath,(__bridge id)self.helper.switchRightPath.CGPath];
    }
    
    
    [self.leftEyeLayer addAnimation:[self.helper createKeyframeAniamtionWithValue:leftValues] forKey:@"leftAnimationKey"];
    
    [self.rightEyeLayer addAnimation:[self.helper createKeyframeAniamtionWithValue:rightValues] forKey:@"rightAnimationKey"];
    
    [self.switchBallLayer addAnimation:[self.helper createKeyframeAniamtionWithValue:ballValue] forKey:@"moveAnimationKey"];

}


#pragma mark - delegate

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag{
    
    
}

#pragma mark - override

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    
    _target  = target;
    _action = action;
}

@end
