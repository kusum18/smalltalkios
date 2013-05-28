//
//  GeoPost.h
//  smalltalk
//
//  Created by App Jam on 5/27/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeoPost : NSObject
{
    NSString *_postId;
    NSString *_place;
    NSString *_postText;
    NSString *_userId;
    NSString *_username;
    NSString *_likes;
    NSString *_latitude;
    NSString *_longitude;
}

@property (nonatomic,retain) NSString *postId;
@property (nonatomic,retain) NSString *place;
@property (nonatomic,retain) NSString *postText;
@property (nonatomic,retain) NSString *userId;
@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *likes;
@property (nonatomic,retain) NSString *latitude;
@property (nonatomic,retain) NSString *longitude;

@end
