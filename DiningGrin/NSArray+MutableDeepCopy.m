//
//  NSArray+MutableDeepCopy.m
//  DiningGrin
//
//  Created by Maijid  Moujaled on 1/9/12.
//  Copyright (c) 2012 Grinnell College. All rights reserved.
//

#import "NSArray+MutableDeepCopy.h"

@implementation NSArray (MutableDeepCopy)

-(NSMutableArray *)mutableDeepCopy
{
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:self.count];
    
    for (id object in self) {
        id oneValue  = object;
        id oneCopy = nil;
        
        if ([oneValue respondsToSelector:@selector(mutableDeepCopy)]) 
            oneCopy = [oneValue mutableDeepCopy];
        
        
        else if ([oneValue respondsToSelector:@selector(mutableCopy)])
            oneCopy = [oneValue mutableCopy];
        
        if (oneCopy == nil) 
            oneCopy = [oneValue copy];
        
        
    [returnArray addObject:object];
        
    }
        return returnArray;
}

@end
