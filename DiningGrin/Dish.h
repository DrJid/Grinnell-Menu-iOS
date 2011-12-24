//
//  Dish.h
//  DiningGrin
//
//  Created by Maijid  Moujaled on 11/26/11.
//  Copyright (c) 2011 Grinnell College. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dish : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign ) BOOL ovolacto;
@property (nonatomic, assign) BOOL  vegan;
@property (nonatomic, assign) BOOL  hasNutrition;


//The dish itself needs to know whethere it's bee toggled to show or not? Just a question?? 
// -(void)toggled; ?? 

@end
