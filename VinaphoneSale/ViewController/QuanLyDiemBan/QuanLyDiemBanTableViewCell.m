//
//  QuanLyDiemBanTableViewCell.m
//  VinaphoneSale
//
//  Created by Mac on 8/1/14.
//  Copyright (c) 2014 Vinaphone. All rights reserved.
//

#import "QuanLyDiemBanTableViewCell.h"

@implementation QuanLyDiemBanTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}
@end
