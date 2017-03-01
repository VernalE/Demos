//
//  LabColor.h
//  KVODemo
//
//  Created by 尤春芬 on 17/2/20.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LabColor : NSObject

@property(nonatomic, assign) double lComponent;

@property(nonatomic, assign) double aComponent;

@property(nonatomic, assign) double bComponent;

@property(nonatomic,readonly,assign) double redComponent;

@property(nonatomic,readonly,assign) double greenComponent;

@property(nonatomic,readonly,assign) double blueComponent;

@property(nonatomic,strong,readonly) UIColor *color;

@end
