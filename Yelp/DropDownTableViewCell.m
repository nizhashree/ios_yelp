//
//  DropDownTableViewCell.m
//  Yelp
//
//  Created by Nizha Shree Seenivasan on 10/30/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "DropDownTableViewCell.h"

@implementation DropDownTableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView.layer setBorderColor:[UIColor colorWithRed:0.66 green:0.59 blue:0.59 alpha:1.0].CGColor];
    [self.contentView.layer setBorderWidth:0.5f];
    self.contentView.layer.cornerRadius = 3;
    self.contentView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onSelection:(id)sender {
}
@end
