//
//  NotificationsViewController.m
//  smalltalk
//
//  Created by App Jam on 5/23/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "NotificationsViewController.h"
#import "HomeViewController.h"
#import "QA.h"
#import "plist.h"
#import "Constants.h"
#import "NotificationsCell.h"
#import "QAViewController.h"

@interface NotificationsViewController ()
{
    NSMutableArray *_notifications;
}

@end

@implementation NotificationsViewController

@synthesize notificationsTable,loadingIcon;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"speaker-electric.png"];
        self.tabBarItem.title=@"Notification";
        _notifications = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated{
    [self fetchAllNotifications ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchAllNotifications
{
    NSString *userid = [plist getValueforKey:C_UserId];
    NSString *url = [NSString stringWithFormat:@"%@/%@/0/10",notificationsURL,userid];
    [[HttpManager alloc] initWithURL:[NSURL URLWithString:url] delegate:self];
    [self.loadingIcon startAnimating];
}

- (IBAction)moveAround:(id)sender {
    HomeViewController *controller = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark http manger delegates

- (void) connectionDidFinish:(HttpManager *)theConnection{
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:theConnection.receivedData options:kNilOptions error:&error];
    NSString *jsontext = [[NSString alloc] initWithData:theConnection.receivedData encoding:NSUTF8StringEncoding];
    NSArray *objs = [dict objectForKey:@"questions"];
    [_notifications removeAllObjects];
    for (NSDictionary *posts in objs) {
        QA *qa = [[QA alloc] init];
//        qa.count = [posts objectForKey:@"count"];
        qa.postText = [posts objectForKey:@"post_text"];
        qa.userinfo = [posts objectForKey:@"owner_name"];
        qa.postid = [posts objectForKey:@"post_id"];
        qa.postTitle = [posts objectForKey:@"post_title"];
        qa.acceptedAnswer = [posts objectForKey:@"accepted_answer"];
        [_notifications addObject:qa];
    }
    [self.notificationsTable reloadData];
    [self.loadingIcon stopAnimating];
}

-(void) connectionDidFail:(HttpManager *)theConnection{
    NSLog(@"Error: Notifications");
    [self.loadingIcon stopAnimating];
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Couldn't conenct to server" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [view show];
}


#pragma mark tableview delegate methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_notifications count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"NotificationsCell";
    
    NotificationsCell *cell = (NotificationsCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NotificationsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell.postText setText:[[_notifications objectAtIndex:indexPath.row] postText]];
    [cell.postText setNumberOfLines:0];
    [cell.postText sizeToFit];
//    [cell.titleLabel setText:[[_notifications objectAtIndex:indexPath.row] postTitle]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}

#pragma mark Tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QAViewController *qavc = [[QAViewController alloc] init];
    qavc.question_id = [_notifications objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:qavc animated:YES];
    //    AnswersParser *p = [[AnswersParser alloc] init];
    //    [p getAllAnswersForQuestion:1];
}


@end
