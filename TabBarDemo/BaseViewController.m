//
//  BaseViewController.m
//  MorningNews
//
//  Created by May Peach & He Biao on 13-10-23.
//  Copyright (c) 2013年 Hebiao. All rights reserved.
//

#import "BaseViewController.h"
//#import "UINavigationBar+Awesome.h"

#import "UINavigationBar+BackGround.h"

#import <objc/runtime.h>

#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define RColor RGB(255, 102, 0)

@interface BaseViewController ()

@end

@implementation BaseViewController


-(instancetype)init{
    if (self == [super init]) {
        
        //    更改导航条的 标题颜色、字体大小。
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor redColor];
        shadow.shadowOffset = CGSizeMake(0, 0);
        NSDictionary *titleAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                          NSShadowAttributeName: shadow,
                                          NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0]};
        
        [[UINavigationBar appearance] setTitleTextAttributes:titleAttributes];
        
        [UINavigationBar appearance].backgroundColor = RColor;
        [[UINavigationBar appearance] setBarTintColor:RColor];
        [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    }
    
    return self;
}

//创建首页地图按钮
//创建首页地图按钮
-(void)createMainNavBtn:(NSString *)imageName :(NSString *)showName{
    
    UIButton *btnb = [UIButton buttonWithType : UIButtonTypeCustom];
    btnb.frame = CGRectMake (0, 0, 200, 44);
   
    btnb.imageEdgeInsets = UIEdgeInsetsMake(0,-20 , 0, 0);
    
    //            [btnb setBackgroundImage :[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btnb setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btnb.titleLabel.font=[UIFont boldSystemFontOfSize:14.f];
    [btnb setTitle:showName forState:UIControlStateNormal];
    [btnb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnb.showsTouchWhenHighlighted=YES;
    
    UIView *mapView=[[UIView alloc] initWithFrame:CGRectMake(0, 12, 15, 20)];
    mapView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"mapViewBg.png"]];
    [btnb addSubview:mapView];
    
    [btnb addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *ubar=[[UIBarButtonItem alloc] initWithCustomView :btnb];
    self.navigationItem.leftBarButtonItem = ubar;

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor whiteColor];
   self.navigationController.navigationBar.translucent = NO;//不加 否则view的高度从最顶部开始

    /**
     *  通用页面样式配置
     translucent 默认YES
     特别是extendedLayoutIncludesOpaqueBars，在iOS7.0后默认为YES，然而若UINavigationBar translucent属性为YES，则UINavigationController其topViewControll.view是包含UINavigationBar和UIStatusBar下面覆盖的那片区域的。但若translucent属性为NO，则除非设置controller的extendedLayoutIncludesOpaqueBars属性为YES，topViewControll.view都是不包含此区域的
     */
//    self.navigationController.navigationBar.translucent = NO;//否则view的高度从最顶部开始
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = NO;
//    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    //设置状态栏的字体颜色，除了如下设置，还需在plist中添加View controller-based status bar appearance设为NO
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];//白色
    
    
    //此方法是将nav上的蒙层去掉
    //方法一：导航栏背景是颜色值的
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithRed:255.0/255 green:102.0/255 blue:0.0 alpha:1]];
    
//    [self.navigationController.navigationBar YCFSetBackgroundColor:[UIColor colorWithRed:255.0/255 green:102.0/255 blue:0.0 alpha:1]];
    /*
     方法二：导航栏背景是图片的，那么需要到Awesome中
     [self setBackgroundImage:[UIImage imageNamed:@"navBg.png"] forBarMetrics:UIBarMetricsDefault];
    */
//    [self.navigationController.navigationBar lt_setBackgroundImage:[UIImage imageNamed:@"navBg.png"]];
    

    
//    NSLog(@"navigationbar subviews recursive description:\n\n%@\n\n",[self.navigationController.navigationBar performSelector:@selector(recursiveDescription)]);

    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/**
 *	@brief	获取设备屏幕宽度
 *
 *	@return	返回设备屏幕宽度
 */
-(CGFloat)returnBoundsWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}


/**
 *	@brief	获取设备屏幕高度
 *
 *	@return	返回设备屏幕高度
 */
-(CGFloat)returnBoundsHeight
{
    
//    return HeightScreen-44-screenY-49;
    return [UIScreen mainScreen].bounds.size.height;
}

-(UIImage *)imageWithColor:(UIColor *)color{
    

    CGRect rect = CGRectMake(0.0f, 0.0f, 320, 65);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


-(void)createBarLeftWithString:(NSString *)imageName :(NSString *)showName
{
    UIButton *btnb = [UIButton buttonWithType : UIButtonTypeCustom];
    btnb.frame = CGRectMake (0, 0, 44, 44);
//    [btnb setBackgroundImage :[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btnb setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    btnb.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    btnb.titleLabel.font=[UIFont boldSystemFontOfSize:14.f];
    [btnb setTitle:showName forState:UIControlStateNormal];
    [btnb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnb.showsTouchWhenHighlighted=YES;
    [btnb addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *ubar=[[UIBarButtonItem alloc] initWithCustomView :btnb];
    self.navigationItem.leftBarButtonItem = ubar;

}

-(void)leftBarCanUse{
    self.navigationItem.leftBarButtonItem.customView.userInteractionEnabled=YES;
}

-(void)leftBarCanNotUse{
    self.navigationItem.leftBarButtonItem.customView.userInteractionEnabled=NO;
}

-(void)createBarLeftWithString1:(NSString *)imageName :(NSString *)showName
{
  
    UIButton *btnb = [UIButton buttonWithType : UIButtonTypeCustom];
    btnb.frame = CGRectMake (0, 0, 44, 44);
   
    btnb.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
//     [btnb setBackgroundImage :[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btnb setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btnb.titleLabel.font=[UIFont boldSystemFontOfSize:14.f];
    [btnb setTitle:showName forState:UIControlStateNormal];
    [btnb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnb.showsTouchWhenHighlighted=YES;
    [btnb addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *ubar=[[UIBarButtonItem alloc] initWithCustomView :btnb];
    self.navigationItem.leftBarButtonItem = ubar;
    
}



/**
 *	@brief	创建导航条的返回按钮
 *
 *	@param 	imageName 	返回按钮的图片
 */
-(void)createBarLeftWithImage:(NSString *)imageName :(NSString *)showName
{
  
    UIButton *btnb = [UIButton buttonWithType : UIButtonTypeCustom];
    btnb.frame = CGRectMake (0, 0, 44, 44);
    btnb.imageEdgeInsets = UIEdgeInsetsMake(0,-20 , 0, 0);
  
//            [btnb setBackgroundImage :[UIImage imageNamed:imageName] forState:UIControlStateNormal];
   [btnb setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btnb.titleLabel.font=[UIFont boldSystemFontOfSize:14.f];
    [btnb setTitle:showName forState:UIControlStateNormal];
    [btnb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnb.showsTouchWhenHighlighted=YES;
    [btnb addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *ubar=[[UIBarButtonItem alloc] initWithCustomView :btnb];
    self.navigationItem.leftBarButtonItem = ubar;
   
}

/**
 *	@brief	返回事件
 *
 *	@param 	sender 	参数
 */
-(void)showLeft:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

/**

 *	@brief	创建导航条右边的按钮

 *

 *	@param 	imageName 	右边按钮的图片

 */

-(void)createBarRightWithImage:(NSString *)imageName :(NSString *)showName
{
    
    UIButton *btnb = [UIButton buttonWithType : UIButtonTypeCustom];
    btnb.frame = CGRectMake (0, 0, 44, 44);
    btnb.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    
    [btnb setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    [btnb setBackgroundImage :[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btnb.titleLabel.font=[UIFont boldSystemFontOfSize:14.f];
    [btnb setTitle:showName forState:UIControlStateNormal];
    [btnb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnb.showsTouchWhenHighlighted=YES;
    [btnb addTarget:self action:@selector(showRight:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *ubar=[[UIBarButtonItem alloc] initWithCustomView :btnb];
    self.navigationItem.rightBarButtonItem = ubar;
  
    
}


-(void)createBarRightWithImage1:(NSString *)imageName :(NSString *)showName
{
    
    UIButton *btnb = [UIButton buttonWithType : UIButtonTypeCustom];
    btnb.frame = CGRectMake (0, 0, 44, 44);
    btnb.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
//        btnb.frame = CGRectMake (0, 0, 44, -20);
    [btnb setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //    [btnb setBackgroundImage :[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    UIBarButtonItem *ubar=[[UIBarButtonItem alloc] initWithCustomView :btnb];
    self.navigationItem.rightBarButtonItem = ubar;
   
    
}


/**
 *	@brief	导航右边按钮事件
 *
 *	@param 	sender 	参数
 */
-(void)showRight:(UIButton *)sender{

}

- (UIWindow *)mainWindow
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}

//星星等级
-(UIImageView *)getStarImageView:(float )Ox withOy:(float)Oy withOwidth:(float)Owidth withOheight:(float)Oheight withStarAverage:(int)Average{
    
    UIImageView *stareLabel=[[UIImageView alloc] initWithFrame:CGRectMake(Ox, Oy, Owidth, Oheight)];
    
    switch (Average) {
        case 0:
            stareLabel.image=[UIImage imageNamed:@"stare0.png"];
            break;
        case 1:
            stareLabel.image=[UIImage imageNamed:@"stare1.png"];
            break;
        case 2:
            stareLabel.image=[UIImage imageNamed:@"stare2.png"];
            break;
        case 3:
            stareLabel.image=[UIImage imageNamed:@"stare3.png"];
            break;
        case 4:
            stareLabel.image=[UIImage imageNamed:@"stare4.png"];
            break;
        case 5:
            stareLabel.image=[UIImage imageNamed:@"stare5.png"];
            break;
        default:
            stareLabel.image=[UIImage imageNamed:@"stare5.png"];
            break;
    }
    
    return stareLabel ;
    
}


//橘色星星等级
-(UIImageView *)getOragneStarImageView:(float )Ox withOy:(float)Oy withOwidth:(float)Owidth withOheight:(float)Oheight withStarAverage:(int)Average{
    
    UIImageView *stareLabel=[[UIImageView alloc] initWithFrame:CGRectMake(Ox, Oy, Owidth, Oheight)];
    
    switch (Average) {
        case 0:
            stareLabel.image=[UIImage imageNamed:@"Orstare0.png"];
            break;
        case 1:
            stareLabel.image=[UIImage imageNamed:@"Orstare1.png"];
            break;
        case 2:
            stareLabel.image=[UIImage imageNamed:@"Orstare2.png"];
            break;
        case 3:
            stareLabel.image=[UIImage imageNamed:@"Orstare3.png"];
            break;
        case 4:
            stareLabel.image=[UIImage imageNamed:@"Orstare4.png"];
            break;
        case 5:
            stareLabel.image=[UIImage imageNamed:@"Orstare5.png"];
            break;
        default:
            stareLabel.image=[UIImage imageNamed:@"Orstare5.png"];
            break;
    }
    
    return stareLabel;
    
}


//2种颜色、字体不同大小的字符串
-(NSMutableAttributedString *)TwoColorString:(NSString *)string withFirstColor:(UIColor *)firstColor withSecondColor:(UIColor *)secondColor{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    
    
    //设置钱绿色色字体
    [str addAttribute:NSForegroundColorAttributeName value:firstColor range:NSMakeRange(0,5)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14.f] range:NSMakeRange(0, [str length])];
    
    
    //设置元 灰色字体
    [str addAttribute:NSForegroundColorAttributeName value:secondColor range:NSMakeRange(5,[str length]-5)];

    
    
    return str;
    
}

//2、字体不同大小的字符串
-(NSMutableAttributedString *)TwoFontSizeString:(NSString *)string andOneSize:(int)oneSize{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    
    
    //设置白色字体
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,[str length])];
    
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14.f] range:NSMakeRange(0, oneSize)];
    
    
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:11.f] range:NSMakeRange(oneSize,[str length]-oneSize)];
    
    
    return str;
    
}


-(void)dealloc{
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
