//
//  BaseViewController.h
//  MorningNews
//
//  Created by May Peach & He Biao on 13-10-23.
//  Copyright (c) 2013年 Hebiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

-(void)createBarLeftWithString:(NSString *)imageName :(NSString *)showName;

-(void)createBarLeftWithImage:(NSString *)imageName :(NSString *)showName;
-(void)showLeft:(UIButton *)sender;

-(void)createBarLeftWithString1:(NSString *)imageName :(NSString *)showName;

-(void)createBarRightWithImage:(NSString *)imageName :(NSString *)showName;
-(void)showRight:(UIButton *)sender;
- (UIWindow *)mainWindow;

-(void)createBarRightWithImage1:(NSString *)imageName :(NSString *)showName;


//得到当前View的Width
-(CGFloat)returnBoundsWidth;
//得到当前View的Height
-(CGFloat)returnBoundsHeight;

//星星等级
-(UIImageView *)getStarImageView:(float )Ox withOy:(float)Oy withOwidth:(float)Owidth withOheight:(float)Oheight withStarAverage:(int)Average;

//橘色星星等级
-(UIImageView *)getOragneStarImageView:(float )Ox withOy:(float)Oy withOwidth:(float)Owidth withOheight:(float)Oheight withStarAverage:(int)Average;

//2种颜色、字体不同大小的字符串
-(NSMutableAttributedString *)TwoColorString:(NSString *)string withFirstColor:(UIColor *)firstColor withSecondColor:(UIColor *)secondColor;
//2、字体不同大小的字符串
-(NSMutableAttributedString *)TwoFontSizeString:(NSString *)string andOneSize:(int)oneSize;

//创建首页地图按钮
-(void)createMainNavBtn:(NSString *)imageName :(NSString *)showName;


@end
