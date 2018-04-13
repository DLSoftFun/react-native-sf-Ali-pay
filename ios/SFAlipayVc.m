//
//  SFAlipay.m
//  SFAlipay
//
//  Created by LZW on 2018/4/12.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "SFAlipayVc.h"
#import "SFAlipay/SFAlipay.h"
@interface SFAlipayVc ()

@end

@implementation SFAlipayVc

- (void)viewDidLoad {
    [super viewDidLoad];
  UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
  btn.backgroundColor = [UIColor greenColor];
  [self.view addSubview:btn];
  [btn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchDown];
  
  self.view.backgroundColor = [UIColor redColor];
  
}
-(void)pay{
//  SFAlipay * AP = [SFAlipay new];
//  [AP pay];
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

@end
