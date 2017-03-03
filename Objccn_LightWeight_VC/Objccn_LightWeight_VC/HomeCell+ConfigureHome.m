//
//  HomeCell+ConfigureHome.m
//  Objccn_LightWeight_VC
//
//  Created by 尤春芬 on 17/3/3.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "HomeCell+ConfigureHome.h"
#import "HomeModel.h"

@implementation HomeCell (ConfigureHome)

- (void)configureDetail:(HomeModel *)model{
    self.timeLabel.text = model.time;
    self.nameLabel.text = model.name;
}

@end
