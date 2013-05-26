//
//  GeoPostItViewController.h
//  smalltalk
//
//  Created by App Jam on 5/23/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "ViewController.h"

@interface GeoPostItViewController : ViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *notesTable;

- (IBAction)write:(id)sender;
@end
