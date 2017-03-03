//
//  Person.m
//  NSPredicateDemo
//
//  Created by 尤春芬 on 17/3/1.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "Person.h"

@implementation Person

-(NSString *)description{
    
    return [NSString stringWithFormat:@"%@ %@",self.firstName,self.lastName];
}

@end
