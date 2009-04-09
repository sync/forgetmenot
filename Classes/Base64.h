//
//  Base64.h
//  CoOp
//
//  Created by Anthony Mittaz on 21/01/09.
//  Copyright 2009 Mocra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MBBase64)

+ (id)dataWithBase64EncodedString:(NSString *)string;     //  Padding '=' characters are optional. Whitespace is ignored.
- (NSString *)base64Encoding;

@end
