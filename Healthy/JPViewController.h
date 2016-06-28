//
//  JPViewController.h
//  Healthy
//
//  Created by YinXun-Yu on 16/6/22.
//  Copyright © 2016年 YinXun-Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SDCycleScrollView.h"

@interface JPViewController : UIViewController<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *start;

- (IBAction)start:(UIButton *)sender;


- (IBAction)stop:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

- (IBAction)getbushu:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *bushu;
@property (weak, nonatomic) IBOutlet UITextField *getbut;


- (IBAction)erweima:(UIButton *)sender;
@end
