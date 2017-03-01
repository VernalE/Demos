//
//  OneSubViewController.m
//  TabBarDemo
//
//  Created by 尤春芬 on 17/2/27.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "OneSubViewController.h"

#import "SubOneViewController.h"
#import "SubTwoViewController.h"

#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define RColor RGB(255, 102, 0)

@interface OneSubViewController ()

@end

@implementation OneSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self initTabBar];
    
}

/*
 初始化Tabbar
 */
/*
 初始化Tabbar
 */
- (void)initTabBar{
    
    SubOneViewController *h11 = [[SubOneViewController alloc] init];
    SubTwoViewController *h22 = [[SubTwoViewController alloc] init];
  
    
    NSArray *rootArray = [NSArray arrayWithObjects:h11,h22, nil];
    
    NSArray *nameArray = [NSArray arrayWithObjects:@"首页",@"签到", nil];
    
    h11.title = nameArray[0];
    h22.title = nameArray[1];
 
    NSMutableArray *vcArray = [NSMutableArray array];
    
    
    for (int index = 0; index < rootArray.count; index++) {
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootArray[index]];
        //tabBar未选中的image
        UIImage *normalImg = [[UIImage imageNamed:[NSString stringWithFormat:@"tabBar%d_no.png",index + 1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //tabBar已选中的image
        UIImage *selectImg = [[UIImage imageNamed:[NSString stringWithFormat:@"tabBar%d_yes.png",index+1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //设置tabBar显示的文字
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:nameArray[index] image:normalImg selectedImage:selectImg];
        
        nav.tabBarItem.tag = index +1;
        nav.tabBarItem.title = nameArray[index];
        [vcArray addObject:nav];
        
    }
    
    //tabbar未选中时文字的颜色，字体大小
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:14.0],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RColor,NSForegroundColorAttributeName,[UIFont systemFontOfSize:14.0],NSFontAttributeName, nil] forState:UIControlStateSelected];
    
    self.viewControllers = vcArray;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
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
