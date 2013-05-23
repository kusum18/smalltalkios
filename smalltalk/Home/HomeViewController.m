//
//  HomeViewController.m
//  smalltalk
//
//  Created by Prakash Nagarajan on 5/9/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "HomeViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "Location.h"
#import "MyFeedViewController.h"
#import <CoreLocation/CoreLocation.h> 

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"Hi";
        self.tabBarItem.title = @"hello";
        self.tabBarItem.badgeValue = @"12";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self populateUserDetails];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)performLogout:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
}

- (IBAction)performLocationAction:(id)sender {
    CLLocationCoordinate2D coordinate = [Location getCurrentLocation];
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          coordinate.latitude,
          coordinate.longitude);
}

- (IBAction)showMyFeeds:(id)sender {
    MyFeedViewController *controller = [[MyFeedViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
        
        NSString *fbAccessToken = [[[FBSession activeSession] accessTokenData] accessToken];
        NSLog(@"Access token %@ \n",fbAccessToken);
        
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 NSLog(@"%@",user.name);
                 NSLog(@"%@",user.id);
                 NSLog(@"%@",user);
                 NSLog(@"%@",[user description]);
             }
         }];
    }
}


@end
