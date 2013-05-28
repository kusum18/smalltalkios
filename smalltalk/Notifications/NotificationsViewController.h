//
//  NotificationsViewController.h
//  smalltalk
//
//  Created by App Jam on 5/23/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "ViewController.h"
#import "HttpManager.h"

@interface NotificationsViewController : ViewController<HttpManagerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *notificationsTable;
@end
