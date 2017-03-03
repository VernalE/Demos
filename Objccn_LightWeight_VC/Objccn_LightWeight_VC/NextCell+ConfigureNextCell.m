//
//  NextCell+ConfigureNextCell.m
//  Objccn_LightWeight_VC
//
//  Created by 尤春芬 on 17/3/3.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "NextCell+ConfigureNextCell.h"
#import "NextModel.h"



@implementation NextCell (ConfigureNextCell)

-(void)configureNext:(NextModel *)model{
    self.titleLabel.text = model.title;
    self.timeLabel.text  = model.time;
    self.nameLabel.text  = model.name;
}
@end
