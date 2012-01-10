//
//  Venue.m
//  DiningGrin
//
//  Created by Maijid  Moujaled on 11/26/11.
//  Copyright (c) 2011 Grinnell College. All rights reserved.
//

#import "Venue.h"

@implementation Venue
@synthesize name = _name;
@synthesize dishes = _dishes;



-(id) copyWithZone: (NSZone *) zone {
    
    Venue *newVenue = [[Venue allocWithZone:zone] init];
    
    newVenue.name = self.name;
    newVenue.dishes = [NSMutableArray arrayWithArray:self.dishes];

    return newVenue;
    
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    Venue *newVenue = [[Venue allocWithZone:zone] init];
    
    newVenue.name = self.name;
    newVenue.dishes = [NSMutableArray arrayWithArray:self.dishes];
    
    return newVenue;
}


/*

- (id)init
{
    if ((self = [super init]))
    {
        self.dishes = [[NSMutableArray alloc] initWithCapacity:20];
    }
    
    return self;
}



- (NSMutableArray *)dishes
{
    //We allocate it in the getter so as to init it and not send it to nil. 
    if (_dishes == nil)
        _dishes = [[NSMutableArray alloc] initWithCapacity:20];
    
    return _dishes;
}

 */
@end
