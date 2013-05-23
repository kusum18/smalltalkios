//
//  TBViewController.m
//  smalltalk
//
//  Created by App Jam on 5/23/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "TBViewController.h"
#import "MyFeedViewController.h"
#import "NotificationsViewController.h"
#import "GeoPostItViewController.h"
#import "ProfileViewController.h"

@interface TBViewController ()
-(void) loadAllViews;

@end

@implementation TBViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self loadAllViews];
        [self setSelectedIndex:0];
        [self setHidesBottomBarWhenPushed:YES];
        
    }
    return self;
}

-(void) loadAllViews{
    MyFeedViewController *feed = [[MyFeedViewController alloc] init];
    NotificationsViewController *notify = [[NotificationsViewController alloc] init];
    GeoPostItViewController *geo = [[GeoPostItViewController alloc] init];
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    [self setViewControllers:[NSArray arrayWithObjects:feed,notify,geo,profile, nil]];
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

@end
