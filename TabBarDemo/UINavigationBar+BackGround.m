//
//  UINavigationBar+BackGround.m
//  TabBarDemo
//
//  Created by 尤春芬 on 17/2/24.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "UINavigationBar+BackGround.h"
#import <objc/runtime.h>

static const char YCFOverlayKey;

@implementation UINavigationBar (BackGround)

- (UIView *)overlay{
    return objc_getAssociatedObject(self, &YCFOverlayKey);
}

- (void)setOverlay:(UIView *)overlay{
    objc_setAssociatedObject(self, &YCFOverlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)YCFSetBackgroundColor:(UIColor *)backgroundColor{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        UIView *backgroundView = [self KPGetBackgroundView];
        self.overlay = [[UIView alloc] initWithFrame:backgroundView.bounds];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [backgroundView insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)YCFSetBackgroundImage:(UIImage *)imageName{
    
    if (!self.overlay) {
        [self setBackgroundImage:imageName forBarMetrics:UIBarMetricsDefault];
        
        UIView *backgroundView = [self KPGetBackgroundView];
        self.overlay = [[UIView alloc] initWithFrame:backgroundView.bounds];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [backgroundView insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = [UIColor clearColor];
}


- (UIView*)KPGetBackgroundView{
    //iOS10之前为 _UINavigationBarBackground, iOS10为 _UIBarBackground
    //_UINavigationBarBackground实际为UIImageView子类，而_UIBarBackground是UIView子类
    //之前setBackgroundImage直接赋值给_UINavigationBarBackground，现在则是设置后为_UIBarBackground增加一个UIImageView子控件方式去呈现图片
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        UIView *_UIBackground;
        NSString *targetName = @"_UIBarBackground";
        Class _UIBarBackgroundClass = NSClassFromString(targetName);
        
        for (UIView *subview in self.subviews) {
            if ([subview isKindOfClass:_UIBarBackgroundClass.class]) {
                _UIBackground = subview;
                break;
            }
        }
        return _UIBackground;
    }
    else {
        UIView *_UINavigationBarBackground;
        NSString *targetName = @"_UINavigationBarBackground";
        Class _UINavigationBarBackgroundClass = NSClassFromString(targetName);
        
        for (UIView *subview in self.subviews) {
            if ([subview isKindOfClass:_UINavigationBarBackgroundClass.class]) {
                _UINavigationBarBackground = subview;
                break;
            }
        }
        return _UINavigationBarBackground;
    }
}

#pragma mark - shadow view

- (void)KPHideShadowImageOrNot:(BOOL)bHidden{
    UIView *bgView = [self KPGetBackgroundView];
    
    //shadowImage应该是只占一个像素，即1.0/scale
    for (UIView *subview in bgView.subviews) {
        if (CGRectGetHeight(subview.bounds) <= 1.0) {
            subview.hidden = bHidden;
        }
    }
}

@end
