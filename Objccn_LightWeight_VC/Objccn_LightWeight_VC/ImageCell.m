//
//  ImageCell.m
//  Objccn_LightWeight_VC
//
//  Created by 尤春芬 on 17/3/3.
//  Copyright © 2017年 Yuna. All rights reserved.
//

#import "ImageCell.h"
#import <Masonry/Masonry.h>

@implementation ImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat spaLeft = 20.0;
        
        CGFloat spaTop = 5.0;
        
        
        _imgView = [UIImageView new];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView];
        
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(spaLeft);
            make.right.equalTo(self.contentView.mas_right).mas_offset(-spaLeft);
            make.top.mas_offset(spaTop);
            make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(-spaTop);
            
            
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
