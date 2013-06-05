//
//  ProfileViewController.m
//  smalltalk
//
//  Created by App Jam on 5/23/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "ProfileViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "Constants.h"
#import "plist.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize loadingIcon;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"man.png"];
        self.tabBarItem.title=@"Profile";
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

- (IBAction)unlinkFacebook:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
}

#pragma mark table data delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        NSString *subs = [plist getValueforKey:C_Subscriptions];
        NSMutableArray *subscriptions = [subs componentsSeparatedByString:@","];
        if ([[subscriptions objectAtIndex:indexPath.row] caseInsensitiveCompare:@"0"]==NSOrderedSame) {
            [subscriptions replaceObjectAtIndex:indexPath.row withObject:@"1"];
        }else{
            [subscriptions replaceObjectAtIndex:indexPath.row withObject:@"0"];
        }
        subs = [subscriptions componentsJoinedByString:@","];
        [plist writeToPlistsetValue:subs forKey:C_Subscriptions];
        [tableView reloadData];
        NSString *bodydata = [NSString stringWithFormat:@"userid=%@&subscription=%@",[plist getValueforKey:C_UserId],subs];
        [[HttpManager alloc] initWithPOSTURL:[NSURL URLWithString:userSubscription] delegate:self forPostData:bodydata];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark table source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 2;
    }else if (section==1){
        return 5;
    }
    return 0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"ProfileView";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *subs = [[plist getValueforKey:C_Subscriptions] componentsSeparatedByString:@","];
    if(indexPath.section==1 && [[subs objectAtIndex:indexPath.row] caseInsensitiveCompare:@"1"]== NSOrderedSame){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType  = UITableViewCellAccessoryNone;
    }
    if(indexPath.section==0){
        NSArray *about = [NSArray arrayWithObjects:[plist getValueforKey:C_Name],[plist getValueforKey:C_Email], nil];
        [cell.textLabel setText:[about objectAtIndex:indexPath.row]];
    }else if(indexPath.section==1){
        NSArray *subscriptions = [NSArray arrayWithObjects:@"Sports",@"Movies",@"Technology",@"Places",@"Music", nil];
        [cell.textLabel setText:[subscriptions objectAtIndex:indexPath.row]];
    }

    cell.textLabel.numberOfLines = 0;
    [cell.textLabel sizeToFit];
    [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section    // fixed font style. use custom view (UILabel) if you want something different
{
    NSArray *sectionTitles = [NSArray arrayWithObjects:@"About",@"Subscriptions", nil];
    return [sectionTitles objectAtIndex:section];
}

//
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//
//}

#pragma mark http manager delegate


- (void) connectionDidFinish:(HttpManager *)theConnection{
    
}

-(void) connectionDidFail:(HttpManager *)theConnection{
    
}

@end
