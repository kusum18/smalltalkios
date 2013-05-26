//
//  PostItViewController.m
//  smalltalk
//
//  Created by App Jam on 5/24/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "PostItViewController.h"
#import "Location.h"
#import "Constants.h"

@interface PostItViewController ()

@end

@implementation PostItViewController

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
//    CLLocationCoordinate2D position = [Location getCurrentLocation];
    NSString *bodydata = [NSString stringWithFormat:@"id=1"];
    HttpManager *requester = [[HttpManager alloc] init];
    NSURL *url = [[NSURL alloc] initWithString:NotesSendReqUrl];
//    [requester initWithPostURL:url delegate:self withBody:bodydata];
//    [requester initWithURL:url delegate:self];
}

- (IBAction)clearNotes:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SendNotes:(id)sender {
    [self sendRequest];
}


- (void) connectionDidFail:(HttpManager *)theConnection withError:(NSError *)error{
    
}

- (void) connectionDidFinish:(HttpManager *)theConnection{
    NSMutableData *data =  theConnection.receivedData;
    NSLog(@"Start");
    NSLog(@"d %@",[[NSString alloc] initWithData:theConnection.receivedData encoding:NSASCIIStringEncoding]);
        NSLog(@"Start");
//        [self.navigationController popViewControllerAnimated:YES];
}

@end
