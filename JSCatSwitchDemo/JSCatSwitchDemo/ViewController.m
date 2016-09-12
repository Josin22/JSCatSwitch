//
//  ViewController.m
//  JSCatSwitchDemo
//
//  Created by 乔同新 on 16/9/8.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import "ViewController.h"
#import "JSCatSwitch.h"
#import "ViewConst.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat screenWidth = CGRectGetWidth(self.view.frame);
    CGFloat screenHeight = CGRectGetHeight(self.view.frame);
    CGFloat catSwitchWidth = screenWidth*3/4;
    CGFloat catSwitchHeight = catSwitchWidth*scale_swtich_bg_wh;;
    
    [self.view addSubview:({
        
        JSCatSwitch *catSwitch = [[JSCatSwitch alloc] initWithFrame:CGRectMake(screenWidth/2-catSwitchWidth/2, screenHeight/2-catSwitchHeight/2, catSwitchWidth, catSwitchHeight)];
        catSwitch;
        
    })];
}



@end
