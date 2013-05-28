//
//  QA.h
//  smalltalk
//
//  Created by App Jam on 5/25/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QA : NSObject
{
    NSString *_postText;
    NSString *_userinfo;
    NSString *_userid;
    NSString *_postid;
    NSString *_count;
    NSString *_postTitle;
}

@property (nonatomic,retain) NSString *postText;
@property (nonatomic,retain) NSString *userinfo;
@property (nonatomic,retain) NSString *userid;
@property (nonatomic,retain) NSString *postid;
@property (nonatomic,retain) NSString *count;
@property (nonatomic,retain) NSString *postTitle;

@end
