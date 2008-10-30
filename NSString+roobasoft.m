//
//  NSString+roobasoft.m
//  Count It Off
//
//  Created by Brian Cooke on 10/30/08.
//  Copyright 2008 roobasoft, LLC. All rights reserved.
//

#import "NSString+roobasoft.h"


@implementation NSString(roobasoft)

- (NSString *)urlEncode
{
    NSString *result = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("?=&+"), kCFStringEncodingUTF8);
    return [result autorelease];
}

@end
