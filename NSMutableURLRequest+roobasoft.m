//
//  NSMutableURLRequest+roobasoft.m
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

#import "NSMutableURLRequest+roobasoft.h"
#import "NSData-Base64Extensions.h"

@implementation NSMutableURLRequest (roobasoft) 

- (void) addPostData:(NSString *)postString
{
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];

    [self setHTTPMethod:@"POST"];

    NSString *postLength = [[NSString alloc] initWithFormat:@"%d", [postData length]];
    [self setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [postLength release];
    
    [self setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self setHTTPBody:postData];
}

- (void) addUsername:(NSString *)username andPassword:(NSString *)password
{
    NSString *stringToEncode = [[NSString alloc] initWithFormat:@"%@:%@", username, password];
    NSString *encoded = [[stringToEncode dataUsingEncoding:NSUTF8StringEncoding] encodeBase64];
    NSString *to_pass = [[NSString alloc] initWithFormat:@"Basic %@", encoded];
    [self setValue:to_pass forHTTPHeaderField:@"Authorization"];
    
    [stringToEncode release];
    [to_pass release];
}
@end
