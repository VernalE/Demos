//
//  ViewController.m
//  TabBarDemo
//
//  Created by 尤春芬 on 17/2/23.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "ViewController.h"

#import "HomeOneViewController.h"
#import "HomeTwoViewController.h"
#import "HomeThreeViewController.h"
#import "HomeFourViewController.h"


#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define RColor RGB(255, 102, 0)


@interface ViewController ()<UITabBarControllerDelegate>

@property(nonatomic,strong) UITabBarController *tabBarController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化导航栏
//    [self initNavBgImage];
    
//    [self initNavBgColor];
    
    //初始化Tabbar
    [self initTabBar];
}
/*
 初始化颜色导航栏
 */
-(void)initNavBgColor{

    //    更改导航条的 标题颜色、字体大小。
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowOffset = CGSizeMake(0, 0);
    NSDictionary *titleAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                      NSShadowAttributeName: shadow,
                                      NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0]};
    
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttributes];
    [UINavigationBar appearance].backgroundColor = RColor;
    [[UINavigationBar appearance] setBarTintColor:RColor];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
}


/*
 初始化图片导航栏
 */
-(void)initNavBgImage{
    
    //    更改导航条的 标题颜色、字体大小。
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowOffset = CGSizeMake(0, 0);
    NSDictionary *titleAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                      NSShadowAttributeName: shadow,
                                      NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0]};
    
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttributes];
    
    [UINavigationBar appearance].backgroundColor = [UIColor clearColor];
    [[UINavigationBar appearance] setBarTintColor:[UIColor clearColor]];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBg.png"] forBarMetrics:UIBarMetricsDefault];
}

/*
 初始化Tabbar
 */
- (void)initTabBar{
    
    HomeOneViewController *h1 = [[HomeOneViewController alloc] init];
    HomeTwoViewController *h2 = [[HomeTwoViewController alloc] init];
    HomeThreeViewController *h3 = [[HomeThreeViewController alloc] init];
    HomeFourViewController *h4 = [[HomeFourViewController alloc] init];
    
    
    NSArray *rootArray = [NSArray arrayWithObjects:h1,h2,h3,h4, nil];
    
    NSArray *nameArray = [NSArray arrayWithObjects:@"首页",@"签到",@"日报",@"我的", nil];
    
    h1.title = nameArray[0];
    h2.title = nameArray[1];
    h3.title = nameArray[2];
    h4.title = nameArray[3];
    
    NSMutableArray *vcArray = [NSMutableArray array];
    
    
    for (int index = 0; index < rootArray.count; index++) {
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootArray[index]];
        //tabBar未选中的image
        UIImage *normalImg = [[UIImage imageNamed:[NSString stringWithFormat:@"tabBar%d_no.png",index + 1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSLog(@"%@",[NSString stringWithFormat:@"tabBar%d_no.png",index + 1]);
        
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
    
     self.tabBarController.viewControllers = vcArray;
    _tabBarController.view.frame = self.view.frame;
    _tabBarController.view.backgroundColor = [UIColor whiteColor];
    

    [self.view addSubview:_tabBarController.view];
    
}

-(UITabBarController *)tabBarController{
    
    if (_tabBarController == nil) {
        _tabBarController = [[UITabBarController alloc] init];
    }
    
    return _tabBarController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
