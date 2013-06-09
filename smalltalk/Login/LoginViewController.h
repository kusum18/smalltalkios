//
//  LoginViewController.h
//  smalltalk
//
//  Created by Prakash Nagarajan on 5/9/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "ViewController.h"
#import "HttpManager.h"

@interface LoginViewController : ViewController <HttpManagerDelegate,UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)performLogin:(id)sender;

- (void)openSession;

- (void)loginFailed;
- (IBAction)linkedInConnect:(id)sender;

@end
