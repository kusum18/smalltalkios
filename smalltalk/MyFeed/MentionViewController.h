//
//  MentionViewController.h
//  smalltalk
//
//  Created by App Jam on 5/24/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "ViewController.h"
#import "FriendTag.h"
#import "HttpManager.h"

@interface MentionViewController : ViewController<UITableViewDataSource,UITableViewDelegate,HttpManagerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *userlistTable;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *animator;

@property (nonatomic,retain) id delegate;

@property (nonatomic,retain) NSString *qid;

- (IBAction)pop:(id)sender;
- (IBAction)back:(id)sender;

@end

@protocol MentionDelegate<NSObject>

-(void) addFriend:(FriendTag *)tag;

@end
