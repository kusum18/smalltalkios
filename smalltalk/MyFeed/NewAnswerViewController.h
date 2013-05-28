//
//  NewAnswerViewController.h
//  smalltalk
//
//  Created by App Jam on 5/27/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "ViewController.h"
#import "HttpManager.h"

@interface NewAnswerViewController : ViewController<HttpManagerDelegate>
{
    NSString *_question_id;
    NSString *_question_text;
}

@property (strong, nonatomic) NSString *question_id;
@property (strong, nonatomic) NSString *question_text;

@property (strong, nonatomic) IBOutlet UITextView *answertext;
@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
- (IBAction)postAnswer:(id)sender;
- (IBAction)back:(id)sender;

@end
