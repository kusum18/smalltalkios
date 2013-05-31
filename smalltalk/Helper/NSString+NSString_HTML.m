//
//  NSString+NSString_HTML.m
//  smalltalk
//
//  Created by App Jam on 5/31/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "NSString+NSString_HTML.h"

@implementation NSString (NSString_HTML)

- (NSString *) encodeString{
    return [self stringByReplacingOccurrencesOfString:@"\n" withString:@"###"];
}

- (NSString *) decodeString{
    return [self stringByReplacingOccurrencesOfString:@"###" withString:@"\n"];
}

@end
