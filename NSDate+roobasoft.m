//
//  NSDate+roobasoft.m
//  Count It Off
//
//  Created by Brian Cooke on 10/24/08.
//  Copyright 2008 roobasoft, LLC. All rights reserved.
//

#import "NSDate+roobasoft.h"

@implementation NSDate (roobasoft)
+ (NSDate *) midnight
{
    return [[NSDate date] midnight];
}
- (NSDate *) midnight
{
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

+ (NSDate *) tomorrow
{
    return [[NSDate date] tomorrow];
}

- (NSDate *) tomorrow
{
    return [self addTimeInterval:(24*60*60)];
}

+ (NSDate *) yesterday
{
    return [[NSDate date] yesterday];
}

- (NSDate *) yesterday
{
    return [self addTimeInterval:(-24*60*60)];
}

- (NSString *) pretty
{
    // handle 'today' and 'yesterday'
    if ([[self midnight] compare:[NSDate midnight]] == NSOrderedSame)
    {
        return @"Today";
    }
    else if ([[self midnight] compare:[[NSDate yesterday] midnight]] == NSOrderedSame)
    {
        return @"Yesterday";
    }
    
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    return [NSString stringWithFormat:@"%@ %d", [[[[NSDateFormatter alloc] init] shortMonthSymbols] objectAtIndex:[comps month]-1], [comps day]];
}
@end
