//
//  DropDownTableViewCell.h
//  Yelp
//
//  Created by Nizha Shree Seenivasan on 10/30/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightImageButton;
- (IBAction)onSelection:(id)sender;

@end
