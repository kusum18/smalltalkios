//
//  MentionViewController.m
//  smalltalk
//
//  Created by App Jam on 5/24/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "MentionViewController.h"
#import "FriendTag.h"
#import "plist.h"
#import "Constants.h"

@interface MentionViewController ()

@property (nonatomic,retain) NSMutableArray *friendsList;
@property (nonatomic,retain) NSMutableArray *tagged;

-(void) getfriendsList;

@end

@implementation MentionViewController

@synthesize  tagged=_tagged,friendsList=_friendsList,delegate;
NSMutableArray *friendsList;

@synthesize userlistTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _tagged = [[NSMutableArray alloc] init];
        _friendsList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getfriendsList];
//    FriendTag *tag = [[FriendTag alloc] initWithFriend:@"Sahitya" UserID:11222];
//    [_friendsList addObject:tag];
    
    [userlistTable reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_friendsList count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"QuestionCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (!cell) {
        
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    FriendTag *tag= [_friendsList objectAtIndex:indexPath.row];
    cell.textLabel.text = [tag name];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}

-(void) getfriendsList{
    NSString *uid = [plist getValueforKey:C_UserId];
    NSString *url = [NSString stringWithFormat:@"%@/%@",friendsListURL,uid];
    [[HttpManager alloc] initWithURL:[NSURL URLWithString:url] delegate:self];
}

#pragma mark Tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FriendTag *tag = [_friendsList objectAtIndex:indexPath.row];
    [delegate addFriend:tag];
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (IBAction)back:(id)sender {
        [self dismissViewControllerAnimated:YES completion:Nil];
}


#pragma mark http manager delegate
- (void) connectionDidFinish:(HttpManager *)theConnection{
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:theConnection.receivedData options:kNilOptions error:&error];
    NSArray *objs = [dict objectForKey:@"friends"];
    [_friendsList removeAllObjects];
    for (NSDictionary *friends in objs) {
        FriendTag *tag = [[FriendTag alloc] init];
        tag.userid = [friends objectForKey:@"fid"];
        tag.name = [friends objectForKey:@"fname"];
        tag.fstatus = [friends objectForKey:@"fstatus"];
        tag.lstatus = [friends objectForKey:@"lstatus"];
        [_friendsList addObject:tag];
    }
    [self.userlistTable reloadData];
}

-(void) connectionDidFail:(HttpManager *)theConnection{
    
}
@end


