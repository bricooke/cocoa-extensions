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

@interface NSDate (private_roobasoft)
- (NSDate *) nextDay:(NSInteger)weekdayUnit;
@end


@implementation NSDate (roobasoft)

#ifdef DEBUG
// tomfoolery
//+ (id) date
//{
//    return [NSDate dateWithTimeIntervalSinceNow:(60*60*24*(1))];
//}
#endif


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

+ (NSDate *) justBeforeMidnight
{
    return [[NSDate date] justBeforeMidnight];
}

- (NSDate *) justBeforeMidnight
{
    return [NSDate dateWithTimeIntervalSince1970:[[self midnight] timeIntervalSince1970]-60];
}

+ (NSDate *) addDays:(NSInteger)days
{
    return [[NSDate date] addDays:days];
}

- (NSDate *) addDays:(NSInteger)days
{
    NSDate *t = [self addTimeInterval:days * (24*60*60)];
    
    // handle day light saving changes!
    // if the hour is different we were adjusted. adjust back.
    NSDateComponents *self_comps = [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:self];
    NSDateComponents *future_comps = [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:t];
    
    if ([future_comps hour] != [self_comps hour])
    {
        t = [t addTimeInterval:(60*60)*[future_comps hour] - [self_comps hour]];
    }
    return t;
    
}

+ (NSDate *) tomorrow
{
    return [[NSDate date] tomorrow];
}

- (NSDate *) tomorrow
{
    return [self addDays:1];
}

+ (NSDate *) yesterday
{
    return [[NSDate date] yesterday];
}

- (NSDate *) yesterday
{
    return [self addTimeInterval:(-24*60*60)];
}

+ (NSDate *) friday
{
    return [[NSDate date] friday];
}

- (NSDate *) friday
{
    return [self nextDay:6];
}

+ (NSDate *) saturday
{
    return [[NSDate date] saturday];
}

- (NSDate *) saturday
{
    return [self nextDay:7];
}

- (NSDate *) nextDay:(NSInteger)weekdayUnit
{
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit) fromDate:self];
    
    if (weekdayUnit-[comps weekday] <= 0)
        [comps setDay:7 + [comps day] + weekdayUnit - [comps weekday]];
    else
        [comps setDay:[comps day] + weekdayUnit - [comps weekday]];
    
    return [[NSCalendar currentCalendar] dateFromComponents:comps];        
}


+ (NSDate *) nextWeekday
{
    return [[NSDate date] nextWeekday];
}

- (NSDate *) nextWeekday
{
    // is it a friday or a saturday?
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:(NSWeekdayCalendarUnit) fromDate:self];
    
    if ([comps weekday] == 6)
    {
        // add 3 days to get us to 12:00, monday
        // sat, sun, mon.noon
        return [[self addDays:3] noon];
    }
    else if ([comps weekday] == 7)
    {
        return [[self addDays:2] noon];
    }
    else
    {
        return [[self addDays:1] noon];
    }
}

- (NSString *) pretty
{
    return [self prettyWithYear:NO];
}

- (NSString *)prettyWithYear:(BOOL)withYear
{
    return [self prettyWithYear:withYear yesterdaySupport:YES];
}

- (NSString *) prettyWithYear:(BOOL)withYear yesterdaySupport:(BOOL)yesterdaySupport
{
    return [self prettyWithYear:withYear yesterdaySupport:yesterdaySupport longFormat:NO];
}

- (NSString *) prettyWithYear:(BOOL)withYear yesterdaySupport:(BOOL)yesterdaySupport longFormat:(BOOL)longFormat
{
    // handle 'today' and 'yesterday'
    if ([[self midnight] compare:[NSDate midnight]] == NSOrderedSame)
    {
        return @"Today";
    }
    else if (yesterdaySupport && [[self midnight] compare:[[NSDate yesterday] midnight]] == NSOrderedSame)
    {
        return @"Yesterday";
    }
    
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit fromDate:self];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSString *ret = nil;
    
    if (longFormat)
    {
        [dateFormatter setDateStyle:NSDateFormatterFullStyle];
        ret = [dateFormatter stringFromDate:self];
    }
    else
    {
        if (withYear)
        {
            ret = [NSString stringWithFormat:@"%@ %d, %d", [[dateFormatter shortMonthSymbols] objectAtIndex:[comps month]-1], [comps day], [comps year]];
        }
        else
        {
            ret = [NSString stringWithFormat:@"%@ %d", [[dateFormatter shortMonthSymbols] objectAtIndex:[comps month]-1], [comps day]];        
        }
    }
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

- (NSInteger) daysTill:(NSDate *)otherDate
{
    return (NSInteger)(([[otherDate midnight] timeIntervalSince1970] - [[self midnight] timeIntervalSince1970]) / (24*60*60));
}

+ (NSDate *) noon
{
    return [[NSDate date] noon];
}

- (NSDate *) noon
{
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:self];

    return [[[NSCalendar currentCalendar] dateFromComponents:comps] addTimeInterval:12*60*60];
}

@end
