//
//  PostsFeedParser.h
//  smalltalk
//
//  Created by App Jam on 5/27/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostsFeedParser : NSObject

+(NSArray *)getPostsArray:(NSData *)receivedData;

@end
