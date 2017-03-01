//
//  LabColor.m
//  KVODemo
//
//  Created by 尤春芬 on 17/2/20.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "LabColor.h"

@implementation LabColor

- (id)init{
    
    self = [super init];
    
    if (self) {
        self.lComponent = 11;
        self.aComponent = 20;
        self.bComponent = 33;
    }
    
    return self;
}

//greenComponent 依赖于lComponent和aComponent
- (double)greenComponent{
    
    return self.lComponent + self.aComponent;
}

- (double)redComponent{
    
    return self.lComponent;
}

- (double)blueComponent{
    
    return self.lComponent + self.bComponent;;
}


- (UIColor *)color{
    
    return [UIColor colorWithRed:self.redComponent * 0.01 green:self.greenComponent * 0.01 blue:self.blueComponent * 0.01 alpha:1.];
}
//方式一：Foundation 框架提供的表示属性依赖的机制
+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key{
    
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    
    if ([key isEqualToString:@"redComponent"]) {
        NSSet *affectingKey = [NSSet setWithObject:@"lComponent"];
        
        return [keyPaths setByAddingObjectsFromSet:affectingKey];
    }
    
    if ([key isEqualToString:@"greenComponent"]) {
        NSSet *affectingKey = [NSSet setWithObjects:@"lComponent",@"aComponent", nil];
        return [keyPaths setByAddingObjectsFromSet:affectingKey];
    }
    
    if ([key isEqualToString:@"blueComponent"]) {
        NSSet *affectingKey = [NSSet setWithObjects:@"lComponent",@"bComponent", nil];
        return [keyPaths setByAddingObjectsFromSet:affectingKey];
    }
    
    if ([key isEqualToString:@"color"]) {
        
        NSSet *affectingKey = [NSSet setWithObjects:@"redComponent",@"greenComponent",@"blueComponent", nil];
        return [keyPaths setByAddingObjectsFromSet:affectingKey];
    }
    
    return keyPaths;
}
//方式二：Foundation 框架提供的表示属性依赖的机制:更详细的如下 每个依赖的属性一个个的写出来
/*+ (NSSet *)keyPathsForValuesAffectingRedComponent{
    return [NSSet setWithObject:@"lComponent"];
}

+ (NSSet *)keyPathsForValuesAffectingGreenComponent{
    
    return [NSSet setWithObjects:@"lComponent",@"aComponent", nil];
}

+ (NSSet *)keyPathsForValuesAffectingBlueComponent{
    return [NSSet setWithObjects:@"lComponent",@"bComponent", nil];
}

+ (NSSet *)keyPathsForValuesAffectingColor{
    return [NSSet setWithObjects:@"redComponent",@"greenComponent",@"blueComponent", nil];
}*/
//在修改了lComponent的值后，手动触发通知告知
+ (BOOL)automaticallyNotifiesObserversOfLComponent{
    return NO;
}
//我们只应该在关闭了自动调用的时候我们才需要在 setter 方法里手动调用 -willChangeValueForKey: 和 -didChangeValueForKey:。
- (void)setLComponent:(double)lComponent{
    if (_lComponent == lComponent) {
        return;
    }
    
    [self willChangeValueForKey:@"lComponent"];
    _lComponent = lComponent;
    [self didChangeValueForKey:@"lComponent"];
}
@end
