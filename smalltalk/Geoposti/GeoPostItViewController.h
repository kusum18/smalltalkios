//
//  GeoPostItViewController.h
//  smalltalk
//
//  Created by App Jam on 5/23/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "ViewController.h"
#import "HttpManager.h"

@interface GeoPostItViewController : ViewController<UITableViewDataSource,UITableViewDelegate,HttpManagerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *notesTable;

- (IBAction)write:(id)sender;
@end
