//
//  SubTwoViewController.m
//  MyTabbarDemo
//
//  Created by 尤春芬 on 17/2/27.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "SubTwoViewController.h"

@interface SubTwoViewController ()

@end

@implementation SubTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBarLeftWithImage:nil :@"返回"];
    self.title = @"北极";
    
    self.view.backgroundColor = [UIColor yellowColor];
}

-(void)showLeft:(UIButton *)sender{
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
    
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
