//
//  SubOneViewController.m
//  MyTabbarDemo
//
//  Created by 尤春芬 on 17/2/27.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "SubOneViewController.h"
#import "OneNextViewController.h"
#import "AppDelegate.h"
@interface SubOneViewController ()

@end

@implementation SubOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBarLeftWithImage:nil :@"返回"];

    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSLog(@"size-->%@",NSStringFromCGRect(self.view.frame));
    
    
}

-(void)showLeft:(UIButton *)sender{
    [self.tabBarController.navigationController popViewControllerAnimated:YES];

}

-(void)onClick{
    OneNextViewController *ycf = [[OneNextViewController alloc] init];
    ycf.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ycf animated:YES];
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
