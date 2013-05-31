//
//  NewAnswerViewController.m
//  smalltalk
//
//  Created by App Jam on 5/27/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "NewAnswerViewController.h"
#import "plist.h"
#import "Constants.h"

@interface NewAnswerViewController ()

@end

@implementation NewAnswerViewController

@synthesize questionLabel,answertext,question_id=_question_id,question_text=_question_text;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.questionLabel setText:_question_text];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark user actions

- (IBAction)postAnswer:(id)sender {
    NSString *userid = [plist getValueforKey:C_UserId];
    NSString *data = [NSString stringWithFormat:@"user_id=%@&question_id=%@&answer_text=%@",userid,_question_id,answertext.text];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@"###"];
    [[HttpManager alloc] initWithPOSTURL:[NSURL URLWithString:newAnswerURL] delegate:self forPostData:data];
}

- (IBAction)back:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark http manager delegate

- (void) connectionDidFinish:(HttpManager *)theConnection{
    NSLog(@"New Answer: Posted");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) connectionDidFail:(HttpManager *)theConnection{
    NSLog(@"New Answer: Http error posting");
}

@end
