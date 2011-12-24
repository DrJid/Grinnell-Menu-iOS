//
//  DiningGrinViewController.m
//  DiningGrin
//
//  Created by Maijid  Moujaled on 11/24/11.
//  Copyright (c) 2011 Grinnell College. All rights reserved.
//



#define kDiningMenu [NSURL URLWithString:@"http://www.cs.grinnell.edu/~knolldug/parser/menu.php?mon=12&day=7&year=2011"]

#import "DiningGrinViewController.h"
#import "VenueViewController.h"

@implementation DiningGrinViewController
{
    NSDictionary *jsonDict;
}

@synthesize datePicker;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}



-(void)fetchprelimdata
{
    NSData *data = [NSData dataWithContentsOfURL:kDiningMenu];
    
    NSError * error;
    //NSJSON takes data and then gives you back a founddation object. dict or array. 
    jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                               options:kNilOptions 
                                                 error:&error];

}




#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDatePicker:datePicker];
    [self fetchprelimdata];
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
                            otherButtonTitles:nil
                             ];
        
    //Need to find out if it's possible to completely remove text from JSON output when menu is not present. in other words.. Need Dugan!! This way, we can remove the button when no meal is present. 
    
    if ([jsonDict objectForKey:@"BREAKFAST"]) {
        [mealmessage addButtonWithTitle:@"Breakfast"];
    }
    
    if ([jsonDict objectForKey:@"LUNCH"]) {
        [mealmessage addButtonWithTitle:@"Lunch"];
    }
    if ( [jsonDict objectForKey:@"DINNER"]) {
        [mealmessage addButtonWithTitle:@"Dinner"];
    }
    if ([jsonDict objectForKey:@"OUTTAKES"]) {
        [mealmessage addButtonWithTitle:@"Outtakes"];
    }
        
        [mealmessage show];

    
}

#pragma mark UIAlertViewDelegate Methods


- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *titlePressed = [alertView buttonTitleAtIndex:buttonIndex];
    
    if (buttonIndex == 0) {
        return;
    }
    else 
        [self performSegueWithIdentifier:@"ShowVenueView" sender:titlePressed];
}

#pragma mark --DatePicker Methods


//I'm disabling the forward datePicker so we can test with past dates. Dec 01 - Dec 15 .. Still need to implement this though

/*
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
*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowVenueView"]) {
        VenueViewController *controller = segue.destinationViewController;
        controller.menuChoice = sender;
        
    }
}


@end