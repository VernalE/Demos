//
//  NextCell.m
//  Objccn_LightWeight_VC
//
//  Created by 尤春芬 on 17/3/3.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "NextCell.h"
#import <Masonry/Masonry.h>

@implementation NextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat spaLeft = 20.0;
        CGFloat spaHeight = 20;
        CGFloat spaTop = 5.0;
        CGFloat spawidth = 100.0;

        
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(spaLeft);
            make.width.mas_offset(spawidth);
            make.top.mas_offset(spaTop);
            make.height.mas_offset(spaHeight);
            
        }];

        
        
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right);
            make.right.equalTo(self.contentView.mas_right).mas_offset(-spaLeft);
            make.top.mas_offset(spaTop);
            make.height.mas_offset(spaHeight);
            
        }];
        
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_nameLabel];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(spaLeft);
            make.right.equalTo(self.contentView.mas_right).mas_offset(-spaLeft);
            make.top.equalTo(self.titleLabel.mas_bottom);
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
