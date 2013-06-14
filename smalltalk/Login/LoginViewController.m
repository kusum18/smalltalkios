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

#define callLinkedWebView 1
#define callFBUpdate 2
#define callLinkedInUpdate 3
#define callNone -1

@interface LoginViewController ()
{
    NSDictionary<FBGraphUser> *profile;
    NSString *_fbAccessToken;
}

-(void) populateUserDetails;
-(void) getUserPermissions;
@end

@implementation LoginViewController

UIWebView *webview;

@synthesize spinner,webview,close;

int callStatus = callNone;

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

-(void) btnClick:(id)sender{
    if(!webview){
        
    }else{
        [webview removeFromSuperview];
        [(UIButton *)sender removeFromSuperview];
    }
}

- (IBAction)linkedInConnect:(id)sender {
    [self.webview setHidden:NO];
    [self.close setHidden:NO];
    NSString *fullURL = @"http://54.214.205.250/smalltalk/index.php/loginlinkedin";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webview loadRequest:requestObj];
    [webview sizeToFit];
    [webview setDelegate:self];
    callStatus = callLinkedWebView;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

-(NSString *)accessToken:(NSString *)html{
    NSArray *components = [html componentsSeparatedByString:@"access_token\":\""];
    NSString *temp = (NSString *)[components objectAtIndex:1];
    components = [temp componentsSeparatedByString:@"\""];
    temp = (NSString *)[components objectAtIndex:0];
    return temp;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *html = [webView stringByEvaluatingJavaScriptFromString: @"document.body.innerHTML"];
    NSLog(@"%@",html);
    
    if ([html rangeOfString:@"\"access_token\""].location!=NSNotFound) {
        [webView setHidden:YES];
        NSString *regUrl = newUserRegistration;
        NSString *uid =[plist getValueforKey:C_UserId];
        NSString *user_name = [[plist getValueforKey:C_Name] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSString *fbid = @"-1";
        NSString *accessToken ;
        NSString *deviceToken = [plist getValueforKey:C_Device_token];
        
        accessToken = [self accessToken:html];
        
        NSString *urlstring = [NSString stringWithFormat:@"%@/%@/%@/ln/%@/%@/%@",
                               regUrl,
                               uid,
                               user_name,
                               fbid,
                               accessToken,
                               deviceToken];
        [[HttpManager alloc] initWithURL:[NSURL URLWithString:urlstring] delegate:self];
        callStatus = callLinkedInUpdate;
    }
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

- (IBAction)closeWebview:(id)sender {
    [self.webview setHidden:YES];
    [self.close setHidden:YES];
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
    NSString *urlstring = [NSString stringWithFormat:@"%@/%@/%@/fb/%@/%@/%@",
                           regUrl,
                           uid,
                           user_name,
                           fbid,
                           _fbAccessToken,
                           _deviceToken];
    NSURL *url = [NSURL URLWithString:urlstring];
    NSLog(@"%@",urlstring);
    [plist writeToPlistsetValue:user.name forKey:C_Name];
    [plist writeToPlistsetValue:user.birthday forKey:C_Email];
    [[HttpManager alloc] initWithURL:url delegate:self];
}

- (void) connectionDidFinish:(HttpManager *)theConnection{
    
    if(callStatus == callLinkedInUpdate){
                [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSError *error;
        NSString *uid=[[NSString alloc] initWithData:theConnection.receivedData encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:theConnection.receivedData options:kNilOptions error:&error];
        uid = [dict objectForKey:@"user_id"];
        [plist writeToPlistsetValue:uid forKey:C_UserId];
    }
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
