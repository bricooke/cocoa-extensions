//
//  NSDate+roobasoft.m
// Copyright (c) 2008 roobasoft, LLC
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

#import "NSDate+roobasoft.h"

// needs tests!

static int midnight_offset = 0;

@implementation NSDate (roobasoft)
+ (void) setMidnightOffset:(NSInteger)offset
{
    midnight_offset = offset;
}

+ (NSDate *) midnight
{
    return [[NSDate date] midnight];
}
- (NSDate *) midnight
{    
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self];
    // if it's not midnight_offset hours into the day, it's yesterday
    if ([comps hour] < midnight_offset)
    {
        return [[[self yesterday] addTimeInterval:(midnight_offset*60*60)+1] midnight];
    }
    else
    {
        comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
        return [[[NSCalendar currentCalendar] dateFromComponents:comps] addTimeInterval:midnight_offset*60*60];        
    }
}

+ (NSDate *) tomorrow
{
    return [[NSDate date] tomorrow];
}

- (NSDate *) tomorrow
{
    NSDate *t = [self addTimeInterval:(24*60*60)];
    
    // handle day light saving changes!
    // if the hour is different we were adjusted. adjust back.
    NSDateComponents *self_comps = [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:self];
    NSDateComponents *tomorrow_comps = [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:t];
    
    if ([tomorrow_comps hour] != [self_comps hour])
    {
        t = [t addTimeInterval:(60*60)*[tomorrow_comps hour] - [self_comps hour]];
    }
    return t;
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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *ret = [NSString stringWithFormat:@"%@ %d", [[dateFormatter shortMonthSymbols] objectAtIndex:[comps month]-1], [comps day]];
    [dateFormatter release];
    return ret;
}

- (NSString *) description
{
    [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"y-M-d H:m:sZ"];
    NSString *ret = [formatter stringFromDate:self];
    [formatter release];
        
    return ret;
}
@end
