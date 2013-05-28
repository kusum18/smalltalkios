//
//  PostItViewController.m
//  smalltalk
//
//  Created by App Jam on 5/24/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "PostItViewController.h"
#import "Location.h"
#import "plist.h"
#import "Constants.h"
#import <CoreLocation/CoreLocation.h>


@interface PostItViewController ()
- (CLLocationCoordinate2D ) getCurrentLocation;
@end

@implementation PostItViewController

@synthesize place,postText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

-(void) sendRequest{
    CLLocationCoordinate2D position = [self getCurrentLocation];
    NSString *user_id = [plist getValueforKey:C_UserId];
    NSString *latitude = [NSString stringWithFormat:@"%.4f",position.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%.4f",position.longitude];
    NSString *bodydata = [NSString stringWithFormat:@"user_id=%@&lat=%@&long=%@&place=%@",user_id,latitude,longitude,self.place.text,self.postText.text];
    NSURL *url = [[NSURL alloc] initWithString:NotesSendReqUrl];
    [[HttpManager alloc] initWithPOSTURL:url delegate:self forPostData:bodydata];
//    [requester initWithPostURL:url delegate:self withBody:bodydata];
//    [requester initWithURL:url delegate:self];
}

- (IBAction)clearNotes:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SendNotes:(id)sender {
    [self sendRequest];
}


- (void) connectionDidFail:(HttpManager *)theConnection{
    NSLog(@"Error: New geo post");
}

- (void) connectionDidFinish:(HttpManager *)theConnection{
    NSMutableData *data =  theConnection.receivedData;
    NSLog(@"Start");
    NSLog(@"d %@",[[NSString alloc] initWithData:theConnection.receivedData encoding:NSASCIIStringEncoding]);
        NSLog(@"Start");
//        [self.navigationController popViewControllerAnimated:YES];
}


- (CLLocationCoordinate2D ) getCurrentLocation{
    CLLocationManager *locationManager;
    
    if (!locationManager) {
        //        [self initializeLocationManager];
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
        
    }else{
        //        [locationManager startUpdatingLocation];
    }
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    [locationManager stopUpdatingLocation];
    return coordinate;
    
}


@end
