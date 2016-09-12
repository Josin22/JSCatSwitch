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
}

@property (strong, nonatomic) CAGradientLayer *bgGradientLayer;

@property (strong, nonatomic) NSArray *onColorArray;

@property (strong, nonatomic) NSArray *transitColorArray;

@property (strong, nonatomic) NSArray *offColorArray;

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
    
    _switchOnStatue = NO;

    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 5;
    self.layer.shadowOffset = CGSizeMake(3.0, 3.0);
    
    [self.layer addSublayer:self.bgGradientLayer];
    
    [self drawCat];

}

#pragma mark - lazy load

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
    catLayer.fillColor = [UIColor whiteColor].CGColor;
    
    [self.layer addSublayer:catLayer];
    
    UIBezierPath *catPath = [UIBezierPath bezierPath];
    catPath.lineCapStyle = kCGLineCapRound; //线条拐角
    catPath.lineJoinStyle = kCGLineJoinRound; //终点处理
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
 
    if (_switchOnStatue) {
        self.bgGradientLayer.colors = self.onColorArray;
    } else {
        self.bgGradientLayer.colors = self.offColorArray;
    }
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
