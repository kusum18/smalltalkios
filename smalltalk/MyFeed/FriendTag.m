//
//  FriendTag.m
//  smalltalk
//
//  Created by App Jam on 5/25/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "FriendTag.h"

@implementation FriendTag

@synthesize name=_name,userid=_userid,lstatus=_lstatus,fstatus=_fstatus;

-(id) init{
    self = [super init];
    
    if(self){
        self.name = @"";
        self.userid = @"" ;
    }
    
    return self;
}


-(id) initWithFriend:(NSString *)name UserID:(NSString *)userid{
    self = [super init];
    
    if(self){
        self.name = name;
        self.userid = userid;
    }
    
    return self;
}

@end
