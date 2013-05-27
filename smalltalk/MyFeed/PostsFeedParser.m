//
//  PostsFeedParser.m
//  smalltalk
//
//  Created by App Jam on 5/27/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "PostsFeedParser.h"

@implementation PostsFeedParser

+(NSArray *)getPostsArray:(NSData *)receivedData{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:&error];
    NSArray *objs = [dict objectForKey:@"questions"];
    [_posts removeAllObjects];
    for (NSDictionary *posts in objs) {
        QA *qa = [[QA alloc] init];
        qa.count = [[posts objectForKey:@"count"] intValue];
        qa.postText = [posts objectForKey:@"post_text"];
        qa.userinfo = [posts objectForKey:@"user_info"];
        qa.postid = [[posts objectForKey:@"id"] intValue];
        [_posts addObject:qa];
    }

    
}

@end
