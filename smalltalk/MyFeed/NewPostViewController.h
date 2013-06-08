//
//  QAViewController.h
//  smalltalk
//
//  Created by App Jam on 5/23/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "ViewController.h"
#import "FriendTag.h"

@interface NewPostViewController : ViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIPopoverControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *goBack;
- (IBAction)moveBack:(id)sender;

- (IBAction)pushMentions:(id)sender;
- (IBAction)addCategories:(id)sender;

-(void) setCategories:(NSMutableArray *)categories;

@property (strong, nonatomic) IBOutlet UITableView *taggedFriendsTable;
@property (strong, nonatomic) IBOutlet UILabel *nofriendsLabel;
@property (strong, nonatomic) IBOutlet UIButton *phoneBookLabel;
- (IBAction)tagFriends:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *categories;

@property (strong, nonatomic) IBOutlet UITextView *postDetail;
@property (strong, nonatomic) IBOutlet UITextField *postTitleLabel;
@end
