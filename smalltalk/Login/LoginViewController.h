//
//  LoginViewController.h
//  smalltalk
//
//  Created by Prakash Nagarajan on 5/9/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "ViewController.h"

@interface LoginViewController : ViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)performLogin:(id)sender;

- (void)openSession;

- (void)loginFailed;

@end
