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
#import "SubThreeViewController.h"
#import "SubFourViewController.h"

#import "UIButton+ImageTitleSpacing.h"

#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define RColor RGB(255, 102, 0)

@interface OneSubViewController (){
    UIView *tabBgView;
}

@property(nonatomic, strong) SubOneViewController *oneVC;

@property(nonatomic, strong) SubTwoViewController *twoVC;

@property(nonatomic, strong) SubThreeViewController *threeVC;

@property(nonatomic, strong) SubFourViewController *fourVC;

@property (nonatomic ,strong) UIViewController *currentVC;

@end

@implementation OneSubViewController

-(SubOneViewController *)oneVC{
    
    if (_oneVC == nil) {
        _oneVC = [[SubOneViewController alloc] init];
        _oneVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-49);
    }
    return _oneVC;
}



-(SubTwoViewController *)twoVC{
    
    if (_twoVC == nil) {
        _twoVC = [[SubTwoViewController alloc] init];
        _twoVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-49);
    }
    return _twoVC;
}



-(SubThreeViewController *)threeVC{
    
    if (_threeVC == nil) {
        _threeVC = [[SubThreeViewController alloc] init];
        _threeVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-49);
    }
    return _threeVC;
}

-(SubFourViewController *)fourVC{
    
    if (_fourVC == nil) {
        _fourVC = [[SubFourViewController alloc] init];
         _fourVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-49);
    }
    return _fourVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.oneVC];

    [self.view addSubview:_oneVC.view];
    
    self.currentVC = _oneVC;
    
  
    tabBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-49-64,CGRectGetWidth(self.view.frame) , 49)];
    tabBgView.backgroundColor = [UIColor colorWithRed:249.0/255 green:249.0/255 blue:249.0/255 alpha:1.0];
    [self.view addSubview:tabBgView];
    

     NSArray *nameArray = [NSArray arrayWithObjects:@"首页",@"签到",@"日报",@"我的", nil];
    
    
    CGFloat spaWidth = CGRectGetWidth(self.view.frame) / 4.0;
    
     CGFloat btnSpa = -20;
    
    for (int  i = 0; i< 4; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(spaWidth*i, 0, spaWidth, 49)];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabBar%d_no.png",i + 1]] forState:UIControlStateNormal];
        
         [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabBar%d_yes.png",i + 1]] forState:UIControlStateSelected];
        [btn setTitle:nameArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [btn setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor: RColor forState:UIControlStateSelected];
        
        if (i == 0) {
            btn.selected  = YES;
        }
        
         [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:btnSpa];
        
        [tabBgView addSubview:btn];
    }
    
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0.5)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [tabBgView addSubview:lineLabel];
   
    
}

-(void)onClick:(UIButton *)sender{
    sender.selected = YES;
    
    for (int i = 0; i<4; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:100+i];
        if (i != sender.tag - 100) {
            btn.selected = NO;
        }
    }
    
    if ((self.currentVC == self.oneVC && sender.tag == 100)||(self.currentVC == self.twoVC && sender.tag == 101) || (self.currentVC == self.threeVC && sender.tag == 102) || (self.currentVC == self.twoVC && sender.tag == 1013)) {
        return;
    }
    
    switch (sender.tag) {
            
        case 100:
             [self replaceController:self.currentVC newController:self.oneVC];
            break;
        case 101:

             [self replaceController:self.currentVC newController:self.twoVC];
            break;
        case 102:

             [self replaceController:self.currentVC newController:self.threeVC];
            break;
        case 103:

            [self replaceController:self.currentVC newController:self.fourVC];
            break;
            
        default:
            break;
    }
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *            着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间
     *  options                 动画效果
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
            
        }else{
            
            self.currentVC = oldController;
            
        }
    }];
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
