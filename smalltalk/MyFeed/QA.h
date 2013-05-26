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
    NSInteger _userid;
    NSInteger _postid;
    NSInteger _count;
}

@property (nonatomic,retain) NSString *postText;
@property (nonatomic,retain) NSString *userinfo;
@property (nonatomic,readwrite) NSInteger userid;
@property (nonatomic,readwrite) NSInteger postid;
@property (nonatomic,readwrite) NSInteger count;

@end
