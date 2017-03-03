//
//  ArrayDataSource.m
//  Objccn_LightWeight_VC
//
//  Created by 尤春芬 on 17/3/3.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "ArrayDataSource.h"


@interface ArrayDataSource ()

@property(nonatomic, strong) NSArray *arrItems;

@property(nonatomic, copy) NSString *cellIdentifier;

@property(nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;

@end

@implementation ArrayDataSource

//配置cell和block
- (id)initWithCellIdentifier:(NSString *)aCellIdentifier configureBlock:(TableViewCellConfigureBlock)aConfigureBlock{
    
    self = [super init];
    
    if (self) {
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = [aConfigureBlock copy];
    }
    return self;
}

//配置数据源
- (void)initWithArrItems:(NSArray *)anItems{
    self.arrItems = anItems;
}

//获取每个cell对应的值
- (id)itemsAtIndexPath:(NSIndexPath *)indexPath{
    return self.arrItems[indexPath.row];
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //此处是复用了  可以从打印的数据看出
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    //    NSLog(@"cell --- >%@",cell);
    
    id item = [self itemsAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    
    return cell;
}

@end
