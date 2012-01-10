//
//  Filter.h
//  DiningGrin
//
//  Created by Maijid  Moujaled on 12/30/11.
//  Copyright (c) 2011 Grinnell College. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filter : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL isChecked;
@property (nonatomic, assign) BOOL isOn;

-(void)toggleCheck;

@end
