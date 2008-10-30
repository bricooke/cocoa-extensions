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
