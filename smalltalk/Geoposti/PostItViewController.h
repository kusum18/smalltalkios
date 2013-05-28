//
//  PostItViewController.h
//  smalltalk
//
//  Created by App Jam on 5/24/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "ViewController.h"
#import "HttpManager.h"

@interface PostItViewController : ViewController<HttpManagerDelegate>
- (IBAction)clearNotes:(id)sender;
- (IBAction)SendNotes:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *place;
@property (strong, nonatomic) IBOutlet UITextView *postText;
@end
