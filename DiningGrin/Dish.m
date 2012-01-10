//
//  Dish.m
//  DiningGrin
//
//  Created by Maijid  Moujaled on 11/26/11.
//  Copyright (c) 2011 Grinnell College. All rights reserved.
//

#import "Dish.h"

@implementation Dish

@synthesize name = _name;
@synthesize vegan, ovolacto, hasNutrition, halal, passover;


//If every single time the app is run, the dishes are pulled from the php file... do we need to decode/encode anything? 

//We encode each single object in the the dish class for saving. 
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"Name"];
    [encoder encodeBool:self.vegan forKey:@"Vegan"]; 
    [encoder encodeBool:self.ovolacto forKey:@"Ovolacto"]; 
    [encoder encodeBool:self.hasNutrition forKey:@"HasNutrition"]; 
}

//For loading, we do the exact opposite. Decode each object in the dish class. 
- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.name = [decoder decodeObjectForKey:@"Name"];
        self.vegan = [decoder decodeBoolForKey:@"Vegan"];
        self.ovolacto = [decoder decodeBoolForKey:@"Ovolacto"];
        self.hasNutrition = [decoder decodeBoolForKey:@"HasNutrition"];


    }
    return self;
}

-(id) copyWithZone: (NSZone *) zone {
    
    Dish *newDish = [[Dish allocWithZone:zone] init];
    newDish.name = self.name;
    newDish.ovolacto = self.ovolacto;
    newDish.hasNutrition = self.hasNutrition;
    newDish.halal = self.halal;
    newDish.passover = self.passover;
    
    return newDish;
 
}


@end
