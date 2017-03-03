//
//  ViewController.m
//  NSPredicateDemo
//
//  Created by 尤春芬 on 17/3/1.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *firstNames = @[ @"Alice", @"Bob", @"Charlie", @"Quentin" ];
    
    NSArray *lastNames = @[ @"Smith", @"Jones", @"Smith", @"Alberts" ];
    
    NSArray *ages = @[ @24, @27, @33, @31 ];
    
    NSMutableArray *peopleArray = [NSMutableArray array];
    
    [firstNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Person *person = [[Person alloc] init];
        person.firstName = firstNames[idx];
        person.lastName = lastNames[idx];
        person.age = ages[idx];
        [peopleArray addObject:person];
    }];
    
    NSPredicate *bobPredicate = [NSPredicate predicateWithFormat:@"firstName = 'Bob'"];
    
    NSLog(@"first name:%@",[peopleArray filteredArrayUsingPredicate:bobPredicate]);
    
    
    NSPredicate *lastPredicate = [NSPredicate predicateWithFormat:@"lastName = %@",@"Smith"];
    
    NSLog(@"last name:%@",[peopleArray filteredArrayUsingPredicate:lastPredicate]);
    
    NSPredicate *agePredicate = [NSPredicate predicateWithFormat:@"age >= 30"];
    
    NSLog(@"last name:%@",[peopleArray filteredArrayUsingPredicate:agePredicate]);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
