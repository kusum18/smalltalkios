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
    NSString *_userid;
    NSString *_lstatus;
    NSString *_fstatus;
}

-(id) initWithFriend:(NSString *)_name UserID:(NSString *)_userid;

@property (nonatomic,retain) NSString *name;

@property (nonatomic,readwrite) NSString *userid;

@property (nonatomic,retain) NSString *lstatus;

@property (nonatomic,retain) NSString *fstatus;

@end
