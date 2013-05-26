//
//  FriendTag.h
//  smalltalk
//
//  Created by App Jam on 5/25/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendTag : NSObject
{
    NSString *_name;
    NSInteger _userid;
}

-(id) initWithFriend:(NSString *)_name UserID:(NSInteger)_userid;

@property (nonatomic,retain) NSString *name;

@property (nonatomic,readwrite) NSInteger userid;

@end
