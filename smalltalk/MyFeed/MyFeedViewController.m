//
//  MyFeedViewController.m
//  smalltalk
//
//  Created by App Jam on 5/10/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "MyFeedViewController.h"
#import "NewPostViewController.h"
#import "QAViewController.h"
#import "AnswersParser.h"
#import "QuestionCell.h"
#import "Constants.h"
#import "plist.h"
#import "QA.h"

@interface MyFeedViewController ()
{
    NSMutableArray *_feeds;
    NSInteger FriendsFeed;
    NSInteger UserQuestions;
    NSString *_url;
}

-(void) fetchAllPosts;

@end

@implementation MyFeedViewController

@synthesize postsTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"message.png"];
        self.tabBarItem.title=@"Browse Q's";
        self.postsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 10.0f)] ;
        _feeds = [[NSMutableArray alloc] init];
        _url = feedsURL;
        FriendsFeed = 0;
        UserQuestions = 1;
        [self.toggle setSelectedSegmentIndex:FriendsFeed];
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

-(void) viewWillAppear:(BOOL)animated{
        [self fetchAllPosts];
}

#pragma mark TableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_feeds count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"QuestionCell";
    
    QuestionCell *cell = (QuestionCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"QuestionCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    QA *feed = [_feeds objectAtIndex:indexPath.row];
    [cell.postme setText:[feed postText]];
    [cell.postme setNumberOfLines:0];
//    [cell.postme sizeToFit];
    [cell.titleLabel setText:[feed postTitle]];
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
    qavc.question_id = [[_feeds objectAtIndex:indexPath.row] postid];
    [self.navigationController pushViewController:qavc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)WriteQuestion:(id)sender {
    NewPostViewController *qa = [[NewPostViewController alloc] init];
    [self.navigationController pushViewController:qa animated:YES];
}

- (IBAction)toggleChange:(id)sender {
    UISegmentedControl *toggle = (UISegmentedControl *)sender;
    if (toggle.selectedSegmentIndex==FriendsFeed) {
        _url = feedsURL;
    }else{
        _url = selfQuestionsURL;
    }
    [self fetchAllPosts];
}

# pragma mark server api

-(void) fetchAllPosts{
    NSString *user_id = [plist getValueforKey:C_UserId];
    NSInteger startIndex = 0;
    NSInteger count = 15;
    NSString *url = [NSString stringWithFormat:@"%@/%@/%d/%d",_url,user_id,startIndex,count];
    [[HttpManager alloc] initWithURL:[NSURL URLWithString:url] delegate:self];
}

- (void) connectionDidFinish:(HttpManager *)theConnection{
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:theConnection.receivedData options:kNilOptions error:&error];
    
    NSArray *objs = [dict objectForKey:@"questions"];
    [_feeds removeAllObjects];
    for (NSDictionary *posts in objs) {
        QA *qa = [[QA alloc] init];
        qa.postText = [posts objectForKey:@"post_text"];
        qa.userinfo = [posts objectForKey:@"user_name"];
        qa.postid = [posts objectForKey:@"post_id"];
        qa.postTitle = [posts objectForKey:@"post_title"];
        qa.acceptedAnswer  = [posts objectForKey:@"accepted_answer"];
        qa.owner_name  = [posts objectForKey:@"owner_name"];
        qa.owner_id  = [posts objectForKey:@"owner_id"];
        [_feeds addObject:qa];
    }
    [self.feedTable reloadData];
}
-(void) connectionDidFail:(HttpManager *)theConnection{
    
}

@end
