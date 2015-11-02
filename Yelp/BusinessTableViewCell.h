//
//  BusinessTableViewCell.h
//  Yelp
//
//  Created by Nizha Shree Seenivasan on 10/28/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpBusiness.h"

@interface BusinessTableViewCell : UITableViewCell
@property (strong, nonatomic) YelpBusiness* business;
@end
