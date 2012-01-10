//
//  Filter.m
//  DiningGrin
//
//  Created by Maijid  Moujaled on 12/30/11.
//  Copyright (c) 2011 Grinnell College. All rights reserved.
//

#import "Filter.h"

@implementation Filter
@synthesize name, isChecked, isOn;

-(void)toggleCheck
{
    self.isChecked = !self.isChecked;    
}

-(void)toggleSwitch
{
    self.isOn = !self.isOn;
}
@end
