//
//  QAViewController.h
//  smalltalk
//
//  Created by App Jam on 5/25/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "ViewController.h"
#import "HttpManager.h"

@interface QAViewController : ViewController<UITableViewDelegate,UITableViewDataSource,HttpManagerDelegate>
{
    NSString *_question_id;
}
@property (strong, nonatomic) IBOutlet UIButton *writeButton;
@property (strong, nonatomic) IBOutlet UILabel *noAnswerLabel;

@property (strong, nonatomic) IBOutlet UIButton *acceptedAnswer;
@property (strong, nonatomic) IBOutlet UILabel *AnswerText;
@property (nonatomic,retain) NSString *question_id;
@property (strong, nonatomic) IBOutlet UITableView *postTable;

- (IBAction)goBack:(id)sender;
- (IBAction)writeAnswer:(id)sender;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loader;

-(void) acceptAnswer:(NSInteger)row;

@end
