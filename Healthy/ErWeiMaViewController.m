//
//  ErWeiMaViewController.m
//  Healthy
//
//  Created by YinXun-Yu on 16/6/24.
//  Copyright © 2016年 YinXun-Yu. All rights reserved.
//

#import "ErWeiMaViewController.h"
#import "UIView+Toast.h"
#import "UIImage+Coro_QrcodeBuilder.h"

@interface ErWeiMaViewController ()<UIAlertViewDelegate>

@end

@implementation ErWeiMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tabBarItem.title = @"二维码生成";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)geterweima:(UIButton *)sender {

    NSLog(@"当前点击第几个button%ld",(long)sender.tag);
    if ([self.textfiled.text length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"内容不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if (sender.tag == 0) {
            self.image.image = [UIImage coro_createQRCodeWithText:self.textfiled.text size:self.image.frame.size.width];
    }else if (sender.tag == 1){
            self.image.image = [UIImage coro_createQRCodeWithText:self.textfiled.text size:self.image.frame.size.width centerImage:[UIImage imageNamed:@"120"]];
    }else if (sender.tag == 2){
            self.image.image = [UIImage coro_createQRCodeWithText:self.textfiled.text size:self.image.frame.size.width AndTransformColorWithRed:110.0f andGreen:120.0f andBlue:87.0f];
    }else if (sender.tag == 3){
        self.image.image = [UIImage coro_createQRCodeWithText:self.textfiled.text size:self.image.frame.size.width centerImage:[UIImage imageNamed:@"121"] AndTransformColorWithRed:1.0f andGreen:10.0f andBlue:124.0f];
    }
 



    
    
}
@end
