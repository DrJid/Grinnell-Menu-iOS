//
//  VenueViewController.m
//  DiningGrin
//
//  Created by Maijid  Moujaled on 11/24/11.
//  Copyright (c) 2011 Grinnell College. All rights reserved.
//


//To give us a background queue for JSON
#define kBgQueue dispatch_get_global_queue ( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

//Macro to give us the URL 
#define kDiningMenu [NSURL URLWithString:@"http://www.cs.grinnell.edu/~knolldug/parser/menu.php?mon=12&day=4&year=2011"]



#import "VenueViewController.h"
#import "Dish.h"
#import "Venue.h"
#import "SettingsViewController.h"




@implementation VenueViewController
{
    NSMutableArray *menuVenues;
    
    NSArray *menuVenueNamesFromJSON;
    NSMutableArray *realMenuFromJSON;
    
    
    
    Venue *platDuJourVenue;
    Venue *stirFryVenue;
    Venue *pastaVenue;
     
}

@synthesize venue;
@synthesize tableView = _tableView;




- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

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





//We add this method here because when the VenueviewController is waking up. Turning on screen. We would also like to take advantage of that and do some initialization of our own. i.e loading the items

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if ((self = [super initWithCoder:aDecoder])) {    
        
    /************** JSON SECTION ** Will abstract once working ******/ 


     
     
     /***************************************************************/ 
 /*   
    menuVenues = [[NSMutableArray alloc] initWithCapacity:20];
    
    stirFryVenue = [[Venue alloc] init];
    stirFryVenue.name = @"STIR FRY STATION";
    [menuVenues addObject:stirFryVenue];
    
    platDuJourVenue = [[Venue alloc] init];
    platDuJourVenue.name = @"PLAT DU JOUR";
    [menuVenues addObject:platDuJourVenue];
    
    pastaVenue = [[Venue alloc] init];
    pastaVenue.name = @"PASTA BAR";
    [menuVenues addObject:pastaVenue];

    
    NSLog(@"menuvenues count is %d", menuVenues.count);
 
    
    
   
       
       
       
        
        stirFryVenue.dishes = [[NSMutableArray alloc] init];
        pastaVenue.dishes = [[NSMutableArray alloc] init];
        platDuJourVenue.dishes = [[NSMutableArray alloc] init];

        
      
        Dish *dish;
        
        dish = [[Dish alloc] init];
        dish.name = @"Stir Fry Dish";
       // [venuedishes addObject:dish];
        [stirFryVenue.dishes addObject:dish];
        
        dish = [[Dish alloc] init];
        dish.name = @"Asian Noodles";
      //  [venuedishes addObject:dish];
        [pastaVenue.dishes addObject:dish];
        
        dish = [[Dish alloc] init];
        dish.name = @"Plat Du Jour Dish";
     //   [venuedishes addObject:dish];
        [platDuJourVenue.dishes addObject:dish];
        

       NSLog(@"Pasta Venue count is %d", pastaVenue.dishes.count);
       NSLog(@"Plat Du Jour count is %d", platDuJourVenue.dishes.count);
       NSLog(@"Stir Fry count is %d", stirFryVenue.dishes.count);

       
        //for every single venue in the menuvenues.. do something
        //It starts off with the first venue on the list. Here's it's the Honor G Grill.
        for (Venue *grinvenue in menuVenues) {
            //We create a dish
            Dish *dish = [[Dish alloc] init];
            dish.name = [NSString stringWithFormat:@"Dish for %@", grinvenue.name];
            
            //then finally we add this new dish to it's venue
            [grinvenue.dishes addObject:dish];
        }
       
      
    }
*/
        
    }
    return self;
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSData *data = [NSData dataWithContentsOfURL:kDiningMenu];
    
    NSError * error;
    //NSJSON takes data and then gives you back a founddation object. dict or array. 
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions //if you're not only reading but going to modify the objects after reading them, you'd want to pass in the right options. (NSJSONReadingMutablecontainers.. etc
                                                               error:&error];
    if ([NSJSONSerialization isValidJSONObject:jsonDict])
        NSLog(@"yes it's valid");
    
    else NSLog(@"No it's not valid");
    
    
    NSDictionary *mainMenu = [jsonDict objectForKey:@"DINNER"];// [(NSDictionary*) [jsonDict objectForKey:@"Lunch"] objectForKey:@"Waffle Bar"]; //2
    
    NSLog(@"Dinner: %@", mainMenu); //3
    
    //Let's put some data on our screen
    
    //1 Get the latest loan. 
    //    NSDictionary * loan = [latestloans objectAtIndex:0];
    
    //This is a dictionary of dictionaries. Each venue is a key in the main dictionary. Thus we will have to sort through each venue(dict) the main jsondict(dict) and create dish objects for each object that is in the venue. 
    NSLog(@"Count is %d", [mainMenu count]);
    
    menuVenueNamesFromJSON = [[NSArray alloc] init];
    menuVenueNamesFromJSON = [mainMenu allKeys];
    
    
    realMenuFromJSON = [[NSMutableArray alloc] initWithCapacity:10];
    
    NSLog(@"realMenuFromJSON count is %d", realMenuFromJSON.count);

    
    for (NSString *venuename in menuVenueNamesFromJSON) {
        Venue *gvenue = [[Venue alloc] init];
        gvenue.name = venuename;
        [realMenuFromJSON addObject:gvenue];
        NSLog(@"name of venue is %@", gvenue.name);
    }
    
    
    
    
    NSLog(@"The menuVenuesFromJSON count is %d", menuVenueNamesFromJSON.count);
    NSLog(@"realMenuFromJSON is %@", realMenuFromJSON);
    NSLog(@"realMenuFromJSON first object is %@", [realMenuFromJSON objectAtIndex:0]);
    
    
    
    

    
    
    
    for (Venue *gVenue in realMenuFromJSON) {
        
        //We create a dish
        //dish.name = [NSString stringWithFormat:@"Dish for %@", gVenue.name];
        gVenue.dishes = [[NSMutableArray alloc] initWithCapacity:10];

        NSArray *dishesInVenue = [mainMenu objectForKey:gVenue.name];
        
        for (int i = 0; i < dishesInVenue.count; i++) {
            Dish *dish = [[Dish alloc] init];

            NSDictionary *actualdish = [dishesInVenue objectAtIndex:i];
            
            dish.name = [actualdish  objectForKey:@"name"];
            
            if (![[actualdish objectForKey:@"vegan"] isEqualToString:@"false"]) 
                dish.vegan = YES;
            
            //then finally we add this new dish to it's venue
            [gVenue.dishes addObject:dish];
        }
       

        
        NSLog(@"The %@ count is now %d", gVenue.name, gVenue.dishes.count);
    }

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


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
   // Venue *grinvenue = [menuVenues objectAtIndex:indexPath.section];
    Venue *grinvenue = [realMenuFromJSON objectAtIndex:indexPath.section];


     Dish *dish = [grinvenue.dishes objectAtIndex:indexPath.row];
     
     cell.textLabel.text = dish.name;
     
     // accessory type
     cell.accessoryType = UITableViewCellAccessoryNone;
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
   // return [menuVenues count];

    return [realMenuFromJSON count];
    
}

- (NSString *)tableView:(UITableView *)tableView 
titleForHeaderInSection:(NSInteger)section
{
    //Get each section from the menuvenues array and change the header to match it. 
 //   Venue *grinvenue = [menuVenues objectAtIndex:section];

    
    Venue * grinvenue = [realMenuFromJSON objectAtIndex:section];
    return grinvenue.name;
    
}



- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
{
   // Venue *grinvenue = [menuVenues objectAtIndex:section];
    Venue *grinvenue = [realMenuFromJSON objectAtIndex:section];
    

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

- (void)SettingsViewControllerDidCancel:(SettingsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//This is a diagnostic thing! Not related at all! 


-(void)SettingsDetailViewControllerDidFinishFiltering:(SettingsViewController *)controller
{
    //Implement the filtering methods here when ready. 
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"FlipToFilters"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        SettingsViewController *controller = (SettingsViewController *)navigationController.topViewController;
        controller.delegate = self;
    }
}

- (IBAction)changeMeal:(id)sender 
{
  UIAlertView *mealmessage = [[UIAlertView alloc] 
  initWithTitle:@"Select Meal" 
  message:nil
  delegate:self 
  cancelButtonTitle:@"Cancel" 
  otherButtonTitles:@"Breakfast", @"Lunch", @"Dinner", nil
  ];
  
  
  [mealmessage show];
//    [self saveDishes];
  /*
    
    //I'm gonna make change meal just add something to the list. for learning sake. 
    
    Dish *dish;
    
    dish = [[Dish alloc] init];
    dish.name = @"ChangeMeal Soup";
    
    int newRowIndex = [venuedishes count];
    
    [venuedishes addObject:dish];
    
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexpath];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
 */   
}

@end
