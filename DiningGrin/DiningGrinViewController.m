//
//  DiningGrinViewController.m
//  DiningGrin
//
//  Created by Maijid  Moujaled on 11/24/11.
//  Copyright (c) 2011 Grinnell College. All rights reserved.
//

#import "DiningGrinViewController.h"

@implementation DiningGrinViewController
@synthesize datePicker;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDatePicker:datePicker];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setDatePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)showVenues:(id)sender 
{

    
        UIAlertView *mealmessage = [[UIAlertView alloc] 
                             initWithTitle:@"Select Meal" 
                             message:nil
                             delegate:self 
                             cancelButtonTitle:@"Cancel" 
                             otherButtonTitles:@"Breakfast", @"Lunch", @"Dinner", nil
                             ];
        
        
        [mealmessage show];

    
}

#pragma mark UIAlertViewDelegate Methods
// Called when an alert button is tapped.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0)
    {
        //do nothing....
    }
    else{
        
        [self performSegueWithIdentifier:@"ShowVenueView" sender:nil];
        
        /*
        VenueView *venueView = 
        [[VenueView alloc] initWithNibName:@"VenueView" bundle:nil];
        [self.navigationController pushViewController:venueView animated:YES];
        [venueView release];*/
    }
}

#pragma mark --DatePicker Methods

-(void)setDatePicker:(UIDatePicker *)theDatePicker
{
    NSDate *now = [NSDate date]; 
    [theDatePicker setDate:now animated:YES];
    [theDatePicker setMinimumDate:now];
    
    //Set the maximum date based on the number of days past the current date that can be accessed.
    int days = 7;
    int range = 24 * 60 * 60 * days;
    NSDate *max = [[NSDate alloc] initWithTimeIntervalSinceNow:range];
    
    [theDatePicker setMaximumDate:max];
}

@end
