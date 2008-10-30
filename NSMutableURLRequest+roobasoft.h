//
//  NSMutableURLRequest+roobasoft.h
//  Count It Off
//
//  Created by Brian Cooke on 10/30/08.
//  Copyright 2008 roobasoft, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableURLRequest (roobasoft) 
- (void) addPostData:(NSString *)postString;
- (void) addUsername:(NSString *)username andPassword:(NSString *)password;
@end
