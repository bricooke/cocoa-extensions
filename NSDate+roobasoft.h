//
//  NSDate+roobasoft.h
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

#import <UIKit/UIKit.h>


@interface NSDate (roobasoft)
+ (void)     setMidnightOffset:(NSInteger)offset; 
                                // how many hours into the next day
                                // should be considered 'today'

+ (NSDate *) midnight;
- (NSDate *) midnight;
+ (NSDate *) justBeforeMidnight;
- (NSDate *) justBeforeMidnight;

+ (NSDate *) addDays:(NSInteger)days;
- (NSDate *) addDays:(NSInteger)days;

+ (NSDate *) tomorrow;
- (NSDate *) tomorrow;

+ (NSDate *) yesterday;
- (NSDate *) yesterday;

- (NSString *) pretty;
- (NSString *) prettyWithYear:(BOOL)withYear;
- (NSString *) prettyWithYear:(BOOL)withYear yesterdaySupport:(BOOL)yesterdaySupport;
- (NSString *) prettyWithYear:(BOOL)withYear yesterdaySupport:(BOOL)yesterdaySupport longFormat:(BOOL)longFormat;

- (NSString *) description;

- (NSInteger) daysTill:(NSDate *)otherDate;

+ (NSDate *) nextWeekday;
- (NSDate *) nextWeekday;

+ (NSDate *) noon;
- (NSDate *) noon;

+ (NSDate *) friday;
- (NSDate *) friday;

+ (NSDate *) saturday;
- (NSDate *) saturday;


@end
