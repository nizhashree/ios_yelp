//
//  SettingsViewController.h
//  Yelp
//
//  Created by Nizha Shree Seenivasan on 10/29/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewController;
@protocol SettingsViewControllerDelegate <NSObject>

-(void) settingsViewController:(SettingsViewController *) settingsViewController didChangeFilters:(NSDictionary*) filters;

@end

@interface SettingsViewController : UIViewController
@property (nonatomic, weak) id<SettingsViewControllerDelegate> delegate;
@end
