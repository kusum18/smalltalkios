//
//  AnswersParser.m
//  smalltalk
//
//  Created by App Jam on 5/25/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "AnswersParser.h"
#import "Constants.h"

@implementation AnswersParser

@synthesize delegate=_delegate;

-(id)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(void) getAllAnswersForQuestion:(NSInteger)qid{
//    HttpManager *handler = [[HttpManager alloc] init];
    [[HttpManager alloc] initWithURL:[NSURL URLWithString:AnswersURl] delegate:self];
    
}


//- (void) n:(HttpManager *)theConnection;
- (void) connectionDidFinish:(HttpManager *)theConnection{
    NSLog(@"s");
    
}
-(void) connectionDidFail:(HttpManager *)theConnection{
    NSLog(@"ss");    
}


@end
