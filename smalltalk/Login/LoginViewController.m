//
//  LoginViewController.m
//  smalltalk
//
//  Created by Prakash Nagarajan on 5/9/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "Constants.h"
#import "plist.h"

@interface LoginViewController ()
{
    NSDictionary<FBGraphUser> *profile;
    NSString *_fbAccessToken;
}

-(void) populateUserDetails;
-(void) getUserPermissions;
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

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            _fbAccessToken = [[[FBSession activeSession] accessTokenData] accessToken];
//            [self getUserPermissions];
            [self populateUserDetails];
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
//            [self.navController popToRootViewControllerAnimated:NO];
            
            [FBSession.activeSession closeAndClearTokenInformation];
            
//            [self showLoginView];
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSession
{
[FBSession openActiveSessionWithPublishPermissions: [NSArray arrayWithObjects: @"publish_stream", nil]
                                   defaultAudience: FBSessionDefaultAudienceEveryone
                                      allowLoginUI: YES
 
                                 completionHandler: ^(FBSession *session,
                                                      FBSessionState status,
                                                      NSError *error)
 {
     if (error)
     {
         NSLog(@"error");
     }
     else
     {
         [self sessionStateChanged:session state:status error:error];
     }
 }];

}

- (void) setUserDataStructure:(NSDictionary<FBGraphUser> *)user {
    profile = user;
    NSString *_deviceToken = [plist getValueforKey:C_Device_token];
    NSString *regUrl = newUserRegistration;
    NSString *uid =[plist getValueforKey:C_UserId];
    NSString *user_name = [user.name stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *fbid = user.id;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@/fb/%@/%@/%@",
                  regUrl,
                   uid,
                  user_name,
                  fbid,
                  _fbAccessToken,
                  _deviceToken]];
    [plist writeToPlistsetValue:user.name forKey:C_UserName];
    [[HttpManager alloc] initWithURL:url delegate:self];
}

- (void) connectionDidFinish:(HttpManager *)theConnection{
    NSError *error;
//    NSString *uid=[[NSString alloc] initWithData:theConnection.receivedData encoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:theConnection.receivedData options:kNilOptions error:&error];
    NSString  *uid = [dict objectForKey:@"user_id"];
    [plist writeToPlistsetValue:uid forKey:C_UserId];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) connectionDidFail:(HttpManager *)theConnection{
    
}

-(void) getUserPermissions{
    if (FBSession.activeSession.isOpen) {
        
            }
    [self populateUserDetails];
}

- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
        
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 [self setUserDataStructure:user];
             }
         }];
    }
}

- (IBAction)performLogin:(id)sender {
    [self.spinner startAnimating];
    [self openSession];
    NSLog(@"ss");
}
@end
