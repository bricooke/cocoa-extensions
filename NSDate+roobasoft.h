//
//  NSDate+roobasoft.h
//  Count It Off
//
//  Created by Brian Cooke on 10/24/08.
//  Copyright 2008 roobasoft, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSDate (roobasoft)
+ (NSDate *) midnight;
- (NSDate *) midnight;

+ (NSDate *) tomorrow;
- (NSDate *) tomorrow;

+ (NSDate *) yesterday;
- (NSDate *) yesterday;

- (NSString *) pretty;
@end
