//
//  Venue.h
//  DiningGrin
//
//  Created by Maijid  Moujaled on 11/26/11.
//  Copyright (c) 2011 Grinnell College. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venue : NSObject <NSCopying>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *dishes;

@end
