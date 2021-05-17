//
//  MeteoriteTableViewCell.m
//  Talula X
//
//  Created by Diana Brnovik on 12/05/2021.
//

#import "MeteoriteTableViewCell.h"

NSString *const METEORITE_TABLEVIEW_CELL_IDENTIFIER = @"MeteoriteTableViewCell";

@implementation MeteoriteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
