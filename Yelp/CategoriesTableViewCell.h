//
//  CategoriesTableViewCell.h
//  Yelp
//
//  Created by Nizha Shree Seenivasan on 10/30/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoriesTableViewCell;
@protocol CategoriesTableViewCellDelegate <NSObject>

-(void) categoriesTableViewCell:(CategoriesTableViewCell *) categoriesTableViewCell didToggle:(BOOL) value;

@end
@interface CategoriesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *toggleCell;

@property (weak, nonatomic) IBOutlet UILabel *categoryNameCell;
@property (nonatomic, assign) BOOL on;
@property NSString* cellType;
- (IBAction)onToggleButtonChanged:(id)sender;

@property (nonatomic, weak) id<CategoriesTableViewCellDelegate> delegate;

-(void) setOn:(BOOL)on animated:(BOOL) animated;
@end
