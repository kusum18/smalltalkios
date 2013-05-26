//
//  MyFeedViewController.h
//  smalltalk
//
//  Created by App Jam on 5/10/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "ViewController.h"
#import "HttpManager.h"


@interface MyFeedViewController : ViewController<UITableViewDataSource,UITableViewDelegate,HttpManagerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *postsTableView;
- (IBAction)WriteQuestion:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *feedTable;
@end
