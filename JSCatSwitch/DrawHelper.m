//
//  DrawHelper.m
//  JSCatSwitchDemo
//
//  Created by 乔同新 on 2016/12/1.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import "DrawHelper.h"

@implementation DrawHelper

- (void)drawCat:(CGRect)frame{
    
    self.catPath = [UIBezierPath bezierPath];
    [self.catPath fill];
    
    CGFloat selfWidth = CGRectGetWidth(frame);
    CGFloat selfHeight = CGRectGetHeight(frame);
    
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
    [self.catPath moveToPoint:startPoint];
    [self.catPath addQuadCurveToPoint:catLeftTopPoint controlPoint:CGPointMake(catLeftDownPointX-kcatSpedc,catControllY)];
    
    CGFloat catHeadDownHeight = catHeight * scale_cat_head_down;
    CGFloat catHeadDownPiontX = catLeftDownPointX + catWidth/2;
    CGFloat catHeadDownPiontY = catLeftTopY + catHeadDownHeight;
    
    CGPoint catHeadHalfPiont = CGPointMake(catHeadDownPiontX, catHeadDownPiontY);
    //左边半拉头
    [self.catPath addCurveToPoint:catHeadHalfPiont
               controlPoint1:CGPointMake(catLeftTopPointX+10, catLeftTopY)
               controlPoint2:CGPointMake(catHeadHalfPiont.x-14, catHeadHalfPiont.y)];
    //右边半拉头
    [self.catPath addCurveToPoint:catRightTopPoint
               controlPoint1:CGPointMake(catHeadHalfPiont.x+14, catHeadHalfPiont.y)
               controlPoint2:CGPointMake(catRightTopPoint.x-10, catRightTopPoint.y)];
    //
    //右边线
    [self.catPath addQuadCurveToPoint:endPoint
                    controlPoint:CGPointMake(catLeftDownPointX+catWidth+kcatSpedc, catControllY)];
    [self.catPath closePath];
    
    
    CGFloat eyeRadius = 2.0;
  
    self.leftPath = [UIBezierPath bezierPath];
    [self.leftPath fill];
    
    CGFloat leftEyeX = catLeftDownPointX+catWidth/4;
    CGFloat leftEyeY = catLeftTopY+(CGRectGetHeight(frame)-catLeftTopY)/3;
    [self.leftPath addArcWithCenter:CGPointMake(leftEyeX, leftEyeY)
                        radius:eyeRadius
                    startAngle:0
                      endAngle:M_PI*2
                     clockwise:YES];
    [self.leftPath closePath];
    
    
    self.linePointLeftPath = [UIBezierPath bezierPath];
    [self.linePointLeftPath fill];
    [self.linePointLeftPath moveToPoint:CGPointMake(leftEyeX-1, leftEyeY)];
    [self.linePointLeftPath addLineToPoint:CGPointMake(leftEyeX+1, leftEyeY)];
    [self.linePointLeftPath closePath];
    
    self.lineLeftPath = [UIBezierPath bezierPath];
    [self.lineLeftPath fill];
    [self.lineLeftPath moveToPoint:CGPointMake(leftEyeX-catWidth/9, leftEyeY)];
    [self.lineLeftPath addLineToPoint:CGPointMake(leftEyeX+catWidth/9, leftEyeY)];
    [self.lineLeftPath closePath];
    
    
    self.rightPath = [UIBezierPath bezierPath];
    [self.rightPath fill];
    
    CGFloat rightEyeX = catLeftDownPointX+catWidth*3/4;
    CGFloat rightEyeY = catLeftTopY+(CGRectGetHeight(frame)-catLeftTopY)/3;
    [self.rightPath addArcWithCenter:CGPointMake(rightEyeX, rightEyeY)
                         radius:eyeRadius
                     startAngle:0
                       endAngle:M_PI*2
                      clockwise:YES];
    [self.rightPath closePath];
    
    
    self.linePointRightPath = [UIBezierPath bezierPath];
    [self.linePointRightPath fill];
    [self.linePointRightPath moveToPoint:CGPointMake(rightEyeX-1, rightEyeY)];
    [self.linePointRightPath addLineToPoint:CGPointMake(rightEyeX+1, rightEyeY)];
    [self.linePointRightPath closePath];
    
    self.lineRightPath = [UIBezierPath bezierPath];
    [self.lineRightPath fill];
    [self.lineRightPath  moveToPoint:CGPointMake(rightEyeX-catWidth/9, rightEyeY)];
    [self.lineRightPath addLineToPoint:CGPointMake(rightEyeX+catWidth/9, rightEyeY)];
    [self.lineRightPath closePath];
    

    
    self.mousePath = [UIBezierPath bezierPath];
    CGFloat mouseStartX = leftEyeX+eyeRadius;
    CGFloat mouseStartY = leftEyeY+4*eyeRadius;
    CGFloat mouseW = (rightEyeX-leftEyeX)-2*eyeRadius;
    
    [self.mousePath moveToPoint:CGPointMake(mouseStartX, mouseStartY)];
    
    [self.mousePath addQuadCurveToPoint:CGPointMake(mouseW/2+mouseStartX, mouseStartY)
                      controlPoint:CGPointMake(mouseStartX+mouseW/4, mouseStartY+mouseW/5)];
    
    [self.mousePath addQuadCurveToPoint:CGPointMake(mouseW+mouseStartX, mouseStartY)
                      controlPoint:CGPointMake(mouseStartX+mouseW*3/4, mouseStartY+mouseW/5)];
    
    //    [mousePath addCurveToPoint:CGPointMake(mouseW/2+m ouseStartX, mouseStartY) controlPoint1:CGPointMake(mouseStartX+mouseW/4, mouseStartY+mouseW/4) controlPoint2:CGPointMake(mouseStartX+mouseW/4, mouseStartY-mouseW/4)];

    
    CGFloat switchLineWidth = selfWidth*scale_cat_switch_width;
    
    CGFloat switchLineX = (selfWidth-switchLineWidth)/2;
    CGFloat switchLineY = selfHeight*scale_cat_switch_Y;
    
    self.switchLinePath = [UIBezierPath bezierPath];
    [self.switchLinePath moveToPoint:CGPointMake(switchLineX, switchLineY)];
    [self.switchLinePath addLineToPoint:CGPointMake(switchLineX+switchLineWidth, switchLineY)];
    [self.switchLinePath closePath];
    
    
    CGFloat ballRadius = switchLineWidth*scale_cat_switch_radius;
    
    self.switchLeftPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(switchLineX-ballRadius, switchLineY-ballRadius, 2*ballRadius, 2*ballRadius)];
    [self.switchLeftPath closePath];

    self.switchMiddlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(switchLineX+switchLineWidth/2-15,  switchLineY-ballRadius+4, 2*ballRadius+30, 2*ballRadius-8)];
    [self.switchMiddlePath closePath];
    
    self.switchRightPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(switchLineX+switchLineWidth-ballRadius,  switchLineY-ballRadius, 2*ballRadius, 2*ballRadius)];
    [self.switchRightPath closePath];
}

- (CAKeyframeAnimation *)createKeyframeAniamtionWithValue:(NSArray *)value{
    
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyframeAnimation.values  = value;
    keyframeAnimation.duration = .3;
    keyframeAnimation.removedOnCompletion = NO;
    keyframeAnimation.fillMode = kCAFillModeForwards;
    return keyframeAnimation;
}

@end
