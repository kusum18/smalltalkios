//
//  PostsFeed.h
//  smalltalk
//
//  Created by App Jam on 5/27/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostsFeed : NSObject
{
    NSString *_postId;
    NSString *_postText;
    NSString *_postTitle;
    NSString *_username;
}

@property (nonatomic,retain) NSString *postId;
@property (nonatomic,retain) NSString *postText;
@property (nonatomic,retain) NSString *postTitle;
@property (nonatomic,retain) NSString *username;

@end
