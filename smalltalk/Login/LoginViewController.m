//
//  LoginViewController.m
//  smalltalk
//
//  Created by Prakash Nagarajan on 5/9/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize spinner;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loginFailed{
    [self.spinner stopAnimating];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)performLogin:(id)sender {
    [self.spinner startAnimating];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
}
@end
