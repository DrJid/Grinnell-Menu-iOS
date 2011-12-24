//
//  SettingsViewController.h
//  DiningGrin
//
//  Created by Maijid  Moujaled on 11/24/11.
//  Copyright (c) 2011 Grinnell College. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewController;

@protocol SettingsViewControllerDelegate <NSObject>

- (void)SettingsViewControllerDidCancel:(SettingsViewController *)controller;

- (void)SettingsDetailViewControllerDidFinishFiltering:(SettingsViewController *)controller;

@end

@interface SettingsViewController : UITableViewController


@property (nonatomic,weak) id <SettingsViewControllerDelegate> delegate;


@end
