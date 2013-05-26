//
//  MentionViewController.h
//  smalltalk
//
//  Created by App Jam on 5/24/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "ViewController.h"
#import "FriendTag.h"

@interface MentionViewController : ViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *userlistTable;

@property (nonatomic,retain) id delegate;
- (IBAction)pop:(id)sender;

@end

@protocol MentionDelegate<NSObject>

-(void) addFriend:(FriendTag *)tag;

@end
