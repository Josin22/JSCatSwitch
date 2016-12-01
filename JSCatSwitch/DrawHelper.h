//
//  DrawHelper.h
//  JSCatSwitchDemo
//
//  Created by 乔同新 on 2016/12/1.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define XNColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

static CGFloat  scale_swtich_bg_wh = 430.00/570.00;

static CGFloat scale_cat_width = 140.00/570.00;

static CGFloat scale_catHead_width = 107.00/570.00;

static CGFloat scale_cat_height = 168.00/430.00;

static CGFloat scale_line_width = 154.00/570.00;

static CGFloat scale_circle_radius = 60.00/570.00;

static CGFloat  scale_cat_head_down =  30.00/168.00;

static CGFloat scale_cat_leftEye_x = 48.00/140.00;

static CGFloat scale_cat_leftEye_y = 68.00/168.00;

static CGFloat  scale_cat_switch_width = 187.00/570.00;

static CGFloat  scale_cat_switch_Y = 135.00/430.00;

static CGFloat scale_cat_switch_radius = 31.00/187.00;

@interface DrawHelper : NSObject

@property (nonatomic, strong) UIBezierPath *catPath;
//
@property (nonatomic, strong) UIBezierPath *mousePath;
@property (nonatomic, strong) UIBezierPath *switchLinePath;

@property (nonatomic, strong) UIBezierPath *rightPath;
@property (nonatomic, strong) UIBezierPath *leftPath;
//
@property (nonatomic, strong) UIBezierPath *lineLeftPath;
@property (nonatomic, strong) UIBezierPath *linePointLeftPath;
@property (nonatomic, strong) UIBezierPath *lineRightPath;
@property (nonatomic, strong) UIBezierPath *linePointRightPath;

@property (nonatomic, strong) UIBezierPath *switchLeftPath;
@property (nonatomic, strong) UIBezierPath *switchMiddlePath;
@property (nonatomic, strong) UIBezierPath *switchRightPath;

- (void)drawCat:(CGRect)frame;

- (CAKeyframeAnimation *)createKeyframeAniamtionWithValue:(NSArray *)value;

@end
