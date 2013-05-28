//
//  QA.m
//  smalltalk
//
//  Created by App Jam on 5/25/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "QA.h"

@implementation QA

@synthesize postText=_postText,userinfo=_userinfo,userid=_userid,count=_count,postid=_postid;
@synthesize postTitle=_postTitle;


-(id) init{
    self = [super init];
    
    if(self){
        
    }
    
    return self;
}

-(id) initForUser:(NSString *)username withUserId:(NSString *)userid forPost:(NSString *)postid withText:(NSString *)data andLikes:(NSString *)count
{
    self = [super init];
    
    if(self){
        _userinfo = username;
        _postText = data;
        _userid = userid;
        _count = count;
        _postid = postid;
        
    }
    
    return self;
}

@end
