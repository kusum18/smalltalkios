//
//  PostsFeed.m
//  smalltalk
//
//  Created by App Jam on 5/27/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "PostsFeed.h"

@implementation PostsFeed

@synthesize postText=_postText,postId=_postId,postTitle=_postTitle;

-(id) init{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(id) initWithPostId:(NSString *)pID PostText:(NSString *)pText 

@end
