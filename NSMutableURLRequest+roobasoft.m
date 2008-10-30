//
//  NSMutableURLRequest+roobasoft.m
//  Count It Off
//
//  Created by Brian Cooke on 10/30/08.
//  Copyright 2008 roobasoft, LLC. All rights reserved.
//

#import "NSMutableURLRequest+roobasoft.h"


@implementation NSMutableURLRequest (roobasoft) 

- (void) addPostData:(NSString *)postString
{
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];

    [self setHTTPMethod:@"POST"];

    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    [self setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [self setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self setHTTPBody:postData];
}

- (void) addUsername:(NSString *)username andPassword:(NSString *)password
{
    NSString *encoded = [[[NSString stringWithFormat:@"%@:%@", username, password] dataUsingEncoding:NSUTF8StringEncoding] encodeBase64];
    [self setValue:[NSString stringWithFormat:@"Basic %@", encoded] forHTTPHeaderField:@"Authorization"];    
}
@end
