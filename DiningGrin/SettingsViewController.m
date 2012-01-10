//
//  SettingsViewController.m
//  DiningGrin
//
//  Created by Maijid  Moujaled on 11/24/11.
//  Copyright (c) 2011 Grinnell College. All rights reserved.
//

#import "SettingsViewController.h"
#import "Filter.h"


@implementation SettingsViewController
@synthesize delegate = _delegate;
@synthesize filters;
@synthesize veganSwitch;
@synthesize ovolactoSwitch;
@synthesize veganSwitchValue;
@synthesize ovolactoSwitchValue;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)cancel:(id)sender 
{
    [self.delegate SettingsViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender 
{
     veganSwitchValue = veganSwitch.isOn;
     ovolactoSwitchValue = ovolactoSwitch.isOn;
    
    NSLog(@"veganswitchvalue in settignsview is %d", veganSwitchValue);
    
    [[NSUserDefaults standardUserDefaults]  setBool:veganSwitchValue forKey:@"VeganSwitchValue"]; 
    [[NSUserDefaults standardUserDefaults]  setBool:ovolactoSwitchValue forKey:@"OvolactoSwitchValue"];  

    
    [self.delegate SettingsDetailViewControllerDidFinishFiltering:self with:veganSwitchValue with:ovolactoSwitchValue];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    veganSwitchValue = [[NSUserDefaults standardUserDefaults] boolForKey:@"VeganSwitchValue"];
    ovolactoSwitchValue = [[NSUserDefaults standardUserDefaults] boolForKey:@"OvolactoSwitchValue"];
    
    [veganSwitch setOn:veganSwitchValue];
    veganSwitch.onTintColor = [UIColor redColor];
    [ovolactoSwitch setOn:ovolactoSwitchValue];

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setVeganSwitch:nil];
    [self setOvolactoSwitch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



  
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return nil;
}

- (IBAction)switchChanged:(id)sender
{
    if (sender == veganSwitch) {
        
        BOOL setting = veganSwitch.isOn;
        //Do something.
        //get vegan switch value
        //Set the model using the current value of vegan switch. 
    }
    
    if (sender == ovolactoSwitch) {
        //Do something
    }
}
@end
