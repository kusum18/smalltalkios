//
//  AnswersParser.h
//  smalltalk
//
//  Created by App Jam on 5/25/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpManager.h"

@protocol AnswersParserDelegate;

@interface AnswersParser : NSObject<HttpManagerDelegate>
{
    id<AnswersParserDelegate> _delegate;
}

@property (nonatomic,retain) id delegate;

-(void) getAllAnswersForQuestion:(NSInteger)qid;


@end

@protocol AnswersParserDelegate<NSObject>

-(void) answersList:(NSArray *)answers;

@end
