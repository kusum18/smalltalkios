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
@property (strong, nonatomic) IBOutlet UITableView *postTable;
- (IBAction)goBack:(id)sender;
- (IBAction)writeAnswer:(id)sender;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loader;
@end
