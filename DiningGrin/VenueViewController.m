//
//  VenueViewController.m
//  DiningGrin
//
//  Created by Maijid  Moujaled on 11/24/11.
//  Copyright (c) 2011 Grinnell College. All rights reserved.
//


//To give us a background queue for JSON

//Macro to give us the URL 
#define kDiningMenu [NSURL URLWithString:@"http://www.cs.grinnell.edu/~knolldug/parser/menu.php?mon=12&day=7&year=2011"]



#import "VenueViewController.h"
#import "Dish.h"
#import "Venue.h"
#import "SettingsViewController.h"
//#import "Filter.h" I'm not using the filters class i created initially. The filter values are coming directly from the switches.
#import "NSArray+MutableDeepCopy.h"




@implementation VenueViewController
{
    NSMutableArray *menuVenues;
    
    NSArray *menuVenueNamesFromJSON;
    NSMutableArray *realMenuFromJSON;
    NSDictionary *jsonDict;
    NSMutableArray *filteredArray;
    NSDictionary *mainMenu;
    
    BOOL veganFilterIsOn;
    BOOL ovolactoFilterIsOn;
 
}

@synthesize venue;
@synthesize tableView = _tableView;
@synthesize menuChoice , mainURL;

- (void)initialiseFilters
{

    veganFilterIsOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"VeganSwitchValue"];
    ovolactoFilterIsOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"OvolactoSwitchValue"];
}

-(void)resetFilters
{
    
    [filteredArray removeAllObjects];
    
    
    //and then re-create them
    
    for (NSString *venuename in menuVenueNamesFromJSON) {
        Venue *gvenue = [[Venue alloc] init];
        gvenue.name = venuename;
        [filteredArray addObject:gvenue];
        
    }
    

    
    //So for each Venue...
    for (Venue *gVenue in filteredArray) {
        
        //We create a dish
        gVenue.dishes = [[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *dishesInVenue = [mainMenu objectForKey:gVenue.name];
        
        for (int i = 0; i < dishesInVenue.count; i++) {
            Dish *dish = [[Dish alloc] init];
            
            //loop through for the number of dishes
            NSDictionary *actualdish = [dishesInVenue objectAtIndex:i];
            
            dish.name = [actualdish  objectForKey:@"name"];
            
            //Set the attributes for each dish. 
            if (![[actualdish objectForKey:@"vegan"] isEqualToString:@"false"]) 
                dish.vegan = YES;
            
            if (![[actualdish objectForKey:@"ovolacto"] isEqualToString:@"false"]) 
                dish.ovolacto = YES;
            
            if (![[actualdish objectForKey:@"halal"] isEqualToString:@"false"]) 
                dish.halal = YES;
            
            if (![[actualdish objectForKey:@"passover"] isEqualToString:@"false"]) 
                dish.passover = YES;
            
            if (![[actualdish objectForKey:@"nutrition"] isEqualToString:@"NIL"]) 
                dish.hasNutrition = YES;
            
            //then finally we add this new dish to it's venue
            [gVenue.dishes addObject:dish];
        }
    }
    
    

    
}

- (void)implementFilters
{

    NSLog(@"implement filters was just called");
    NSLog(@"VeganFilter value is %d", veganFilterIsOn);
    
    [self resetFilters];
    
    //If both filters are off, don't waste resources doing anything... 
    if (!veganFilterIsOn && !ovolactoFilterIsOn) {
        NSLog(@"resetting everything");
        [self.tableView reloadData];
        return;

    }
    
    
    
//The problem with these filters.. if both filters are on. the entire array will be empty.. coz they are currently mutually exclusive in the JSON.. which i think shouldn't be based on my understadning of ovolacto.. All vegan should be ovolacto right??         
    
    
    NSMutableArray *venuesToRemove = [[NSMutableArray alloc] init];

    for (Venue *eachVenue in filteredArray) {
        
        NSMutableArray *dishesToRemove = [[NSMutableArray alloc] init];
        
        for (Dish *eachDish in eachVenue.dishes) {
            
            if (veganFilterIsOn) {

                if (!eachDish.vegan) 
                    [dishesToRemove addObject:eachDish];
            }
            
            if (ovolactoFilterIsOn) {
                
                if (!eachDish.ovolacto) {
                    [dishesToRemove addObject:eachDish];
                }
            }
            
        }
        
        //If the dishes count is the same, then that venue need not exist at all.. so we remove it. 
        if (eachVenue.dishes.count == dishesToRemove.count) 
            [venuesToRemove addObject:eachVenue];
        
        
            [eachVenue.dishes removeObjectsInArray:dishesToRemove];
        
    }
    
    [filteredArray removeObjectsInArray:venuesToRemove];
    [self.tableView reloadData];

}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.


/*
 
 
 
 - (NSString *)documentsDirectory
 {
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 NSString *documentsDirectory = [paths objectAtIndex:0];
 return documentsDirectory;
 }
 
 - (NSString *)dataFilePath
 {
 return [[self documentsDirectory] stringByAppendingPathComponent:@"Menu.plist"];
 }
 
 
 - (void)saveDishes
 {
 NSMutableData *data = [[NSMutableData alloc] init];
 NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
 [archiver encodeObject:venuedishes forKey:@"VenueDishes"];
 [archiver finishEncoding];
 [data writeToFile:[self dataFilePath] atomically:YES];
 }
 
 - (void)loadDishes
 {
 NSString *path = [self dataFilePath];
 if ([[NSFileManager defaultManager] fileExistsAtPath:path])
 {
 NSData *data = [[NSData alloc] initWithContentsOfFile:path];
 NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
 venuedishes = [unarchiver decodeObjectForKey:@"VenueDishes"];
 [unarchiver finishDecoding];
 }
 else
 {
 venuedishes = [[NSMutableArray alloc] initWithCapacity:20];
 }
 }
 
 */


}


//We add this method here because when the VenueviewController is waking up. Turning on screen. We would also like to take advantage of that and do some initialization of our own. i.e loading the items


-(void)fetchData
{
    NSData *data = [NSData dataWithContentsOfURL:mainURL];
    
    NSError * error;
    //NSJSON takes data and then gives you back a founddation object. dict or array. 
    jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                               options:kNilOptions //if you're not only reading but going to modify the objects after reading them, you'd want to pass in the right options. (NSJSONReadingMutablecontainers.. etc
                                                 error:&error];

    
    
    NSString *key = [[NSString alloc] init];
    if ([self.menuChoice isEqualToString:@"Breakfast"]) {
        key = @"BREAKFAST";
    } else if ([self.menuChoice isEqualToString:@"Lunch"]) {
        key = @"LUNCH";
    } else if ([self.menuChoice isEqualToString:@"Dinner"]) {
        key = @"DINNER";
    } else if ([self.menuChoice isEqualToString:@"Outtakes"]) {
        key = @"OUTTAKES";
    }
    
    NSLog(@"Key is %@", key);
    
    mainMenu = [jsonDict objectForKey:key]; 
    

    
    
    //This is a dictionary of dictionaries. Each venue is a key in the main dictionary. Thus we will have to sort through each venue(dict) the main jsondict(dict) and create dish objects for each object that is in the venue. 
    //   NSLog(@"Count is %d", [mainMenu count]);
    
    menuVenueNamesFromJSON = [[NSArray alloc] init];
    menuVenueNamesFromJSON = [mainMenu allKeys];
    
    
    realMenuFromJSON = [[NSMutableArray alloc] initWithCapacity:10];
    filteredArray = [[NSMutableArray alloc] initWithCapacity:10];

    //   NSLog(@"realMenuFromJSON count is %d", realMenuFromJSON.count);
    
    
    //Here we make an fill up the realMenuFromJSON array to  contain all the venues. 
    for (NSString *venuename in menuVenueNamesFromJSON) {
        Venue *gvenue = [[Venue alloc] init];
        gvenue.name = venuename;
        [realMenuFromJSON addObject:gvenue];

    }
    
    
    
    
    //So for each Venue...
    for (Venue *gVenue in realMenuFromJSON) {
        
        //We create a dish
        gVenue.dishes = [[NSMutableArray alloc] initWithCapacity:10];
        
        NSArray *dishesInVenue = [mainMenu objectForKey:gVenue.name];
        
        for (int i = 0; i < dishesInVenue.count; i++) {
            Dish *dish = [[Dish alloc] init];
            
            //loop through for the number of dishes
            NSDictionary *actualdish = [dishesInVenue objectAtIndex:i];
            
            dish.name = [actualdish  objectForKey:@"name"];
            
            //Set the attributes for each dish. 
            if (![[actualdish objectForKey:@"vegan"] isEqualToString:@"false"]) 
                dish.vegan = YES;
            
            if (![[actualdish objectForKey:@"ovolacto"] isEqualToString:@"false"]) 
                dish.ovolacto = YES;
            
            if (![[actualdish objectForKey:@"halal"] isEqualToString:@"false"]) 
                dish.halal = YES;
            
            if (![[actualdish objectForKey:@"passover"] isEqualToString:@"false"]) 
                dish.passover = YES;
            
            if (![[actualdish objectForKey:@"nutrition"] isEqualToString:@"NIL"]) 
                dish.hasNutrition = YES;
            
            //then finally we add this new dish to it's venue
            [gVenue.dishes addObject:dish];
        }
    }
        

        
        //      NSLog(@"RealMenuFromJSON is %@", realMenuFromJSON) ;
      //  filteredArray = [[NSMutableArray alloc] init];
        filteredArray = [realMenuFromJSON mutableDeepCopy];
      //  filteredArray = [[NSMutableArray alloc] initWithArray:realMenuFromJSON];
        //      NSLog(@"Filtered Array is %@", filteredArray);
        
}    



#pragma mark - View lifecycle




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    NSLog(@"View did load was called");
    [super viewDidLoad];
    [self initialiseFilters];
    [self fetchData];
    [self implementFilters];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:NO];
    NSLog(@"View will appear was called");
    [self implementFilters];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





#pragma mark - Table view data source

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    // Venue *grinvenue = [menuVenues objectAtIndex:indexPath.section];
    Venue *grinvenue = [filteredArray objectAtIndex:indexPath.section];
    
    
    Dish *dish = [grinvenue.dishes objectAtIndex:indexPath.row];
    
    cell.textLabel.text = dish.name;
    
    
    // accessory type
    if (dish.hasNutrition) {
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
    } else cell.accessoryType = UITableViewCellAccessoryNone;
    
    // selection style type
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (dish.vegan) {
        NSLog(@"Dish is vegan");
    }
    else NSLog(@"Dish is NOT vegan.... sorry.");
    
    
    if (dish.ovolacto) {
        NSLog(@"Dish is ovolacto");
    }
    else NSLog(@"Dish is NOT ovolacto.... sorry.");
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    // return [menuVenues count];
    
    return [filteredArray count];
    
}

- (NSString *)tableView:(UITableView *)tableView 
titleForHeaderInSection:(NSInteger)section
{
    //Get each section from the menuvenues array and change the header to match it. 
    //   Venue *grinvenue = [menuVenues objectAtIndex:section];
    
    
    Venue * grinvenue = [filteredArray objectAtIndex:section];
    if (grinvenue.dishes.count > 0) {
        return grinvenue.name;
    }
    else return nil;
    
}



- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
{
    // Venue *grinvenue = [menuVenues objectAtIndex:section];
    Venue *grinvenue = [filteredArray objectAtIndex:section];
    
    
    return [grinvenue.dishes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"DishCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell... 
    [self configureCell:cell atIndexPath:indexPath];
    
    
    
    return cell;
}




#pragma mark - SettingsViewController Delegate Methods

- (void)SettingsViewControllerDidCancel:(SettingsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Here is how we pass data from the settings screen to this screen. The value of the switches is sent to this screen throught this protocol method. And used to set the filter booleans and subsequently, the view will be reloaded when the filter is implemented.

-(void)SettingsDetailViewControllerDidFinishFiltering:(SettingsViewController *)controller with:(BOOL)veganSwitchValue with:(BOOL)ovolactoSwitchValue
{
    veganFilterIsOn = veganSwitchValue;
    ovolactoFilterIsOn = ovolactoSwitchValue;

   // NSLog(@"veganswitchvalue is %d", veganSwitchValue);
   // NSLog(@"veganFilterison is %d", veganFilterIsOn);

    [self implementFilters];
    [self dismissViewControllerAnimated:YES completion:nil];

}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"FlipToFilters"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        SettingsViewController *controller = (SettingsViewController *)navigationController.topViewController;
        controller.delegate = self;
        
        controller.veganSwitchValue = veganFilterIsOn;
        controller.ovolactoSwitchValue = ovolactoFilterIsOn;
        
    }
}

- (IBAction)changeMeal:(id)sender 
{
    
    
    UIAlertView *mealmessage = [[UIAlertView alloc] 
                                initWithTitle:@"Select Meal" 
                                message:nil
                                delegate:self 
                                cancelButtonTitle:@"Cancel" 
                                otherButtonTitles:nil
                                ];
    
    //Completely remove text from JSON output when menu is not present. in other words.. Removes the button from the alert view if no meal is present for that day.    
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
// Called when an alert button is tapped.


- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *titlePressed = [alertView buttonTitleAtIndex:buttonIndex];
    
    if (buttonIndex == 0) {
        return;
    }
    else 
        self.menuChoice = titlePressed;
    
    
    [self fetchData];
    [self implementFilters];
}


@end
