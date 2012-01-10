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

- (void)SettingsDetailViewControllerDidFinishFiltering:(SettingsViewController *)controller with:(BOOL)veganSwitchValue with:(BOOL)ovolactoSwitchValue;

@end

@interface SettingsViewController : UITableViewController


@property (nonatomic,weak) id <SettingsViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *filters;

@property (weak, nonatomic) IBOutlet UISwitch *veganSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *ovolactoSwitch;

@property BOOL veganSwitchValue;
@property BOOL ovolactoSwitchValue;


- (IBAction)switchChanged:(id)sender;


@end
