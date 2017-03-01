//
//  SubOneViewController.m
//  TabBarDemo
//
//  Created by 尤春芬 on 17/2/27.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "SubOneViewController.h"
#import "OneNextViewController.h"

@interface SubOneViewController ()

@end

@implementation SubOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor magentaColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

-(void)onClick{
    OneNextViewController *ycf = [[OneNextViewController alloc] init];
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
