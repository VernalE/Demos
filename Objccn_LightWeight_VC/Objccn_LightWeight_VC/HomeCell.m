//
//  HomeCell.m
//  Objccn_LightWeight_VC
//
//  Created by 尤春芬 on 17/3/3.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "HomeCell.h"
#import <Masonry/Masonry.h>
@implementation HomeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat spaLeft = 20.0;
        CGFloat spaHeight = 20;
        CGFloat spaTop = 5.0;
        
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(spaLeft);
            make.right.equalTo(self.contentView.mas_right).mas_offset(-spaLeft);
            make.top.mas_offset(spaTop);
            make.height.mas_offset(spaHeight);
            
        }];
        
        
        _nameLabel = [UILabel new];
        [self.contentView addSubview:_nameLabel];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(spaLeft);
            make.right.equalTo(self.contentView.mas_right).mas_offset(-spaLeft);
            make.top.equalTo(self.timeLabel.mas_bottom);
            make.height.mas_offset(spaHeight);
            
        }];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
