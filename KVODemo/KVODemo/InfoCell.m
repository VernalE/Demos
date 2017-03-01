//
//  InfoCell.m
//  KVODemo
//
//  Created by 尤春芬 on 17/2/21.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "InfoCell.h"

@implementation InfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat spaLeft = 20.0;
        CGFloat spaTop = 5.0;
        
        CGFloat spaWidth = self.frame.size.width;
        CGFloat spaW = 100;
        CGFloat spaHeight = 30;
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(spaLeft, spaTop, spaW, spaHeight)];
        [self.contentView addSubview:_nameLabel];
        
        
        _nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(spaLeft+spaW, spaTop, spaW, spaHeight)];
        [self.contentView addSubview:_nicknameLabel];
        
        _emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(spaLeft, spaTop + spaHeight, spaWidth - spaLeft*2, spaHeight)];
        [self.contentView addSubview:_emailLabel];
        
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(spaLeft, spaTop + spaHeight*2, spaWidth - spaLeft*2, spaHeight)];
        [self.contentView addSubview:_cityLabel];
        
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
