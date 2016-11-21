//
//  JSCatSwitch.m
//  JSCatSwitchDemo
//
//  Created by 乔同新 on 16/9/8.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import "JSCatSwitch.h"
#import "ViewConst.h"

@interface JSCatSwitch (){

    id _target;
    SEL _action;
    NSTimer *_timer;
    BOOL _switchOnStatue;
    //
    UIBezierPath *rightPath;
    UIBezierPath *leftPath;
    //
    UIBezierPath *lineLeftPath;
    UIBezierPath *lineRightPath;
}

@property (strong, nonatomic) CAGradientLayer *bgGradientLayer;

@property (strong, nonatomic) NSArray *onColorArray;

@property (strong, nonatomic) NSArray *transitColorArray;

@property (strong, nonatomic) NSArray *offColorArray;
//左眼
@property (strong, nonatomic) CAShapeLayer *leftEyeLayer;
//右眼
@property (strong, nonatomic) CAShapeLayer *rightEyeLayer;
//嘴
@property (strong, nonatomic) CAShapeLayer *mouseLayer;

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
    
    [self drawCat];

}

#pragma mark - lazy load

- (CAShapeLayer *)leftEyeLayer{
    
    if (!_leftEyeLayer) {
        _leftEyeLayer = [CAShapeLayer layer];
        _leftEyeLayer.frame = self.bounds;
        _leftEyeLayer.lineCap = kCALineCapRound;
        _leftEyeLayer.lineJoin = kCALineJoinRound;
        _leftEyeLayer.lineWidth = 2;
        _leftEyeLayer.strokeColor = (__bridge CGColorRef _Nullable)(self.onColorArray[1]);
        _leftEyeLayer.fillColor = (__bridge CGColorRef _Nullable)(self.onColorArray[1]);
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
}


#pragma mark -  method



#pragma mark -  Draw Cat

- (void)drawCat{
    
    CAShapeLayer *catLayer = [CAShapeLayer layer];
    catLayer.frame = [self bounds];
    catLayer.lineJoin = kCALineJoinRound;
    catLayer.lineCap = kCALineCapRound;
    catLayer.fillColor = [UIColor whiteColor].CGColor;
    
    [self.layer addSublayer:catLayer];
    
    UIBezierPath *catPath = [UIBezierPath bezierPath];
    [catPath fill];
    
    CGFloat selfWidth = CGRectGetWidth(self.frame);
    CGFloat selfHeight = CGRectGetHeight(self.frame);
    
    CGFloat catHeadWidth = scale_catHead_width *selfWidth;
    CGFloat catWidth = scale_cat_width*selfWidth;
    CGFloat catHeight = scale_cat_height*selfHeight;
    
    CGFloat catLeftDownPointX = (selfWidth-catWidth)/2;
    CGFloat catLeftTopPointX = (selfWidth-catHeadWidth)/2;
    
    CGFloat kcatSpedc = 3;
    
    CGFloat catLeftTopY = selfHeight-catHeight;
    CGFloat catControllY = catLeftTopY+catHeight/2;
    
    CGPoint catLeftTopPoint = CGPointMake(catLeftTopPointX, catLeftTopY);
    CGPoint catRightTopPoint = CGPointMake(catLeftTopPointX+catHeadWidth, catLeftTopY);
    
    CGPoint startPoint = CGPointMake(catLeftDownPointX, selfHeight);
    CGPoint endPoint = CGPointMake(catLeftDownPointX+catWidth, selfHeight);
    //左边线
    [catPath moveToPoint:startPoint];
    [catPath addQuadCurveToPoint:catLeftTopPoint controlPoint:CGPointMake(catLeftDownPointX-kcatSpedc,catControllY)];
    
    CGFloat catHeadDownHeight = catHeight * scale_cat_head_down;
    CGFloat catHeadDownPiontX = catLeftDownPointX + catWidth/2;
    CGFloat catHeadDownPiontY = catLeftTopY + catHeadDownHeight;

    CGPoint catHeadHalfPiont = CGPointMake(catHeadDownPiontX, catHeadDownPiontY);
    //左边半拉头
    [catPath addCurveToPoint:catHeadHalfPiont controlPoint1:CGPointMake(catLeftTopPointX+10, catLeftTopY) controlPoint2:CGPointMake(catHeadHalfPiont.x-14, catHeadHalfPiont.y)];
    //右边半拉头
    [catPath addCurveToPoint:catRightTopPoint controlPoint1:CGPointMake(catHeadHalfPiont.x+14, catHeadHalfPiont.y) controlPoint2:CGPointMake(catRightTopPoint.x-10, catRightTopPoint.y)];
    //
    //右边线                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    [catPath addQuadCurveToPoint:endPoint controlPoint:CGPointMake(catLeftDownPointX+catWidth+kcatSpedc, catControllY)];
    [catPath closePath];
    catLayer.path = catPath.CGPath;
    
    CGFloat eyeRadius = 2.0;
    
    //左眼
    [catLayer addSublayer:self.leftEyeLayer];
    leftPath = [UIBezierPath bezierPath];
    [leftPath fill];
    
    CGFloat leftEyeX = catLeftDownPointX+catWidth/4;
    CGFloat leftEyeY = catLeftTopY+(CGRectGetHeight(self.bounds)-catLeftTopY)/3;
    [leftPath addArcWithCenter:CGPointMake(leftEyeX, leftEyeY) radius:eyeRadius startAngle:0 endAngle:M_PI*2  clockwise:YES];
    [leftPath closePath];
    self.leftEyeLayer.path = leftPath.CGPath;
    
    lineLeftPath = [UIBezierPath bezierPath];
    [lineLeftPath fill];
    [lineLeftPath moveToPoint:CGPointMake(leftEyeX-catWidth/8, leftEyeY)];
    [lineLeftPath addLineToPoint:CGPointMake(leftEyeX+catWidth/8, leftEyeY)];
    [lineLeftPath closePath];
    
    //右眼
    [catLayer addSublayer:self.rightEyeLayer];
    rightPath = [UIBezierPath bezierPath];
    [rightPath fill];
    
    CGFloat rightEyeX = catLeftDownPointX+catWidth*3/4;
    CGFloat rightEyeY = catLeftTopY+(CGRectGetHeight(self.bounds)-catLeftTopY)/3;
    [rightPath addArcWithCenter:CGPointMake(rightEyeX, rightEyeY) radius:eyeRadius startAngle:0 endAngle:M_PI*2  clockwise:YES];
    [rightPath closePath];
    self.rightEyeLayer.path = rightPath.CGPath;

    lineRightPath = [UIBezierPath bezierPath];
    [lineRightPath fill];
    [lineRightPath  moveToPoint:CGPointMake(rightEyeX-catWidth/8, rightEyeY)];
    [lineRightPath addLineToPoint:CGPointMake(rightEyeX+catWidth/8, rightEyeY)];
    [lineRightPath closePath];
    
    //嘴
    [catLayer addSublayer:self.mouseLayer];
    
    UIBezierPath *mousePath = [UIBezierPath bezierPath];
    CGFloat mouseStartX = leftEyeX+eyeRadius;
    CGFloat mouseStartY = leftEyeY+4*eyeRadius;
    CGFloat mouseW = (rightEyeX-leftEyeX)-2*eyeRadius;
    
    [mousePath moveToPoint:CGPointMake(mouseStartX, mouseStartY)];
    [mousePath addQuadCurveToPoint:CGPointMake(mouseW/2+mouseStartX, mouseStartY) controlPoint:CGPointMake(mouseStartX+mouseW/4, mouseStartY+mouseW/5)];
    [mousePath addQuadCurveToPoint:CGPointMake(mouseW+mouseStartX, mouseStartY) controlPoint:CGPointMake(mouseStartX+mouseW*3/4, mouseStartY+mouseW/5)];

//    [mousePath addCurveToPoint:CGPointMake(mouseW/2+mouseStartX, mouseStartY) controlPoint1:CGPointMake(mouseStartX+mouseW/4, mouseStartY+mouseW/4) controlPoint2:CGPointMake(mouseStartX+mouseW/4, mouseStartY-mouseW/4)];
    
    self.mouseLayer.path = mousePath.CGPath;
    
    
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
    _switchOnStatue = !_switchOnStatue;
    NSArray *leftValues = nil;
    NSArray *rightValues = nil;
    
    if (_switchOnStatue) {
        
        self.bgGradientLayer.colors = self.onColorArray;
        leftValues = @[(__bridge id)lineLeftPath.CGPath,(__bridge id)leftPath.CGPath];
        rightValues = @[(__bridge id)lineRightPath.CGPath,(__bridge id)rightPath.CGPath];
        
    } else {
        
        self.bgGradientLayer.colors = self.offColorArray;
        leftValues = @[(__bridge id)leftPath.CGPath,(__bridge id)lineLeftPath.CGPath];
        rightValues = @[(__bridge id)rightPath.CGPath,(__bridge id)lineRightPath.CGPath];

    }
    
    CAKeyframeAnimation *leftLineAniamtion = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    leftLineAniamtion.values = leftValues;
    leftLineAniamtion.duration = .5;
    leftLineAniamtion.removedOnCompletion = NO;
    leftLineAniamtion.fillMode = kCAFillModeForwards;
    [self.leftEyeLayer addAnimation:leftLineAniamtion forKey:@"leftAnimationKey"];
    
    CAKeyframeAnimation *rightLineAniamtion = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    rightLineAniamtion.values = rightValues;
    rightLineAniamtion.duration = .5;
    rightLineAniamtion.removedOnCompletion = NO;
    rightLineAniamtion.fillMode = kCAFillModeForwards;
    [self.rightEyeLayer addAnimation:rightLineAniamtion forKey:@"rightAnimationKey"];

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
