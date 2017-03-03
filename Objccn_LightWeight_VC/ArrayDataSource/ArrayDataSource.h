//
//  ArrayDataSource.h
//  Objccn_LightWeight_VC
//
//  Created by 尤春芬 on 17/3/3.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^TableViewCellConfigureBlock)(id cell, id model);

@interface ArrayDataSource : NSObject<UITableViewDataSource>

//配置cell和block
- (id)initWithCellIdentifier:(NSString *)aCellIdentifier configureBlock:(TableViewCellConfigureBlock)aConfigureBlock;

//配置数据源
- (void)initWithArrItems:(NSArray *)anItems;

//获取每个cell对应的值
- (id)itemsAtIndexPath:(NSIndexPath *)indexPath;

@end
