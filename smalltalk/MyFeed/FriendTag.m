//
//  FriendTag.m
//  smalltalk
//
//  Created by App Jam on 5/25/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "FriendTag.h"

@implementation FriendTag

@synthesize name=_name,userid=_userid;

-(id) init{
    self = [super init];
    
    if(self){
        self.name = [[NSString alloc] init];
        self.userid = 0;
    }
    
    return self;
}


-(id) initWithFriend:(NSString *)name UserID:(NSInteger)userid{
    self = [super init];
    
    if(self){
        self.name = [[NSString alloc] initWithString:name];
        self.userid = userid;
    }
    
    return self;
}

@end
