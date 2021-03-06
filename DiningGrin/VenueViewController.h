//
//  VenueViewController.h
//  DiningGrin
//
//  Created by Maijid  Moujaled on 11/24/11.
//  Copyright (c) 2011 Grinnell College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"

@class Venue;
@interface VenueViewController : UIViewController <SettingsViewControllerDelegate,
                                                UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) Venue *venue;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString * menuChoice;
@property (nonatomic, strong) NSURL * mainURL;

- (void)initialiseFilters;
- (void)implementFilters;

@end
