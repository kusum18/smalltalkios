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
#import "QuestionCell.h"

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
-(void) setFrame:(UILabel *)_label{
    CGRect frame = _label.frame;
    frame.size.width = 276;
    _label.frame = frame;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"QuestionCell";
    
    QuestionCell *cell = (QuestionCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    QA *qa = [_notifications objectAtIndex:indexPath.row];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"QuestionCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        [cell.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    }
    [cell.titleLabel setText:[NSString stringWithFormat:@"Posted by: %@",[qa userinfo]]];
    [cell.postme setText:[qa postText]];
    [cell.postme setNumberOfLines:0];
    [self setFrame:cell.postme];
    [cell.postme sizeToFit];
    [cell.postme setLineBreakMode:NSLineBreakByWordWrapping];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [[_notifications objectAtIndex:indexPath.row] postText];
    CGSize textSize = [str sizeWithFont:[UIFont systemFontOfSize:18]
                      constrainedToSize:CGSizeMake(200, 2000)
                      lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(textSize.height+20,78);
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
