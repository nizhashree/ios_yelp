//
//  BusinessTableViewCell.m
//  Yelp
//
//  Created by Nizha Shree Seenivasan on 10/28/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "BusinessTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface BusinessTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageUrl;
@property (weak, nonatomic) IBOutlet UILabel *TitleName;
@property (weak, nonatomic) IBOutlet UILabel *Address;
@property (weak, nonatomic) IBOutlet UILabel *Categories;
@property (weak, nonatomic) IBOutlet UILabel *Distance;
@property (weak, nonatomic) IBOutlet UILabel *Reviews;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageUrl;

@end
@implementation BusinessTableViewCell

- (void)awakeFromNib {
    self.TitleName.preferredMaxLayoutWidth = self.TitleName.frame.size.width;
    self.imageUrl.layer.cornerRadius = 3;
    self.imageUrl.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setBusiness:(YelpBusiness *)business{
    _business = business;
    [self.imageUrl setImageWithURL: business.imageUrl];
    self.TitleName.text = [NSString stringWithFormat:@"%@", business.name];
    self.Address.text = business.address;
    self.Categories.text = business.categories;
    self.Distance.text = business.distance;
    self.Reviews.text = [NSString stringWithFormat:@"%@ reviews", business.reviewCount];
    [self.ratingImageUrl setImageWithURL: business.ratingImageUrl];
}
- (void) layoutSubviews{
    [super layoutSubviews];
    self.TitleName.preferredMaxLayoutWidth = self.TitleName.frame.size.width;
}
@end
