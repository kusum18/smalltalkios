    //
//  QAViewController.m
//  smalltalk
//
//  Created by App Jam on 5/25/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "QAViewController.h"
#import "Constants.h"
#import "AnswersParser.h"
#import "NewAnswerViewController.h"
#import "QACell.h"
#import "plist.h"

@interface QAViewController ()
{
    NSString *question_text;

    NSInteger _row;
    NSInteger accId;
    bool hasSentAcceptedAnswerReq;
    bool forwardFriendRequest;
}
@property (nonatomic,retain) NSMutableArray *posts;

@end

@implementation QAViewController

@synthesize posts=_posts,postTable,loader,question_id=_question_id;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _posts = [[NSMutableArray alloc] init];
        isSelected=NO;
        hasSentAcceptedAnswerReq = NO;
        accId=-1;
    }
    return self;
}

-(void)setQuestion_id:(QA *)question_id{
    _question_id = question_id;
}

-(void) getAllAnswers{
    NSString *url = [NSString stringWithFormat:@"%@/%@",AnswersURl,_question_id.postid];
    [[HttpManager alloc] initWithURL:[NSURL URLWithString:url] delegate:self];
    [self.loader startAnimating];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self getAllAnswers];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [self getAllAnswers];
    if([_question_id.acceptedAnswer caseInsensitiveCompare:@"-1"]==NSOrderedSame){
        [self.writeButton setHidden:NO];
    }else{
        [self.writeButton setHidden:YES];
    }
    hasSentAcceptedAnswerReq = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = [_posts count];
    return count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"QA";
    QACell *cell = (QACell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"QACell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.delegate = self;
        cell.acceptAnswer.tag = indexPath.row;
        [cell.answerLabel sizeToFit];
    }
    if([_question_id.owner_id caseInsensitiveCompare:[plist getValueforKey:C_UserId] ]==NSOrderedSame){
        [cell.acceptAnswer setHidden:NO];
    }else{
        [cell.acceptAnswer setHidden:YES];
    }
    
    if((isSelected && _row==indexPath.row ) || accId==[[[_posts objectAtIndex:indexPath.row] postid] intValue]){
        [cell.acceptAnswer setHidden:NO];
        [cell.acceptAnswer setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        //            [cell.acceptAnswer]
    }else{
        
    }
    QA *feed = [_posts objectAtIndex:indexPath.row];
    [cell.answerLabel setNumberOfLines:0];
    [cell.answerLabel sizeToFit];
    [cell.answerLabel setText:[feed postText]];
    [cell.acceptAnswer setTag:indexPath.row];
    [cell.usernameLabel setText:[feed userinfo]];
    cell.acceptAnswer.userInteractionEnabled = !(isSelected || accId!=-1);
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize textSize = [[[_posts objectAtIndex:indexPath.row] postText]  sizeWithFont:[UIFont boldSystemFontOfSize:15]
                        constrainedToSize:CGSizeMake(300, 2000)
                        lineBreakMode:UILineBreakModeWordWrap];
    return fmax(textSize.height+40, 60);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init]; 
    return view;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return question_text;
}


#pragma mark Answers delegate methods
-(void) answersList:(NSArray *)answers{
    _posts = [NSMutableArray arrayWithArray:answers];
    [self.postTable reloadData];
    
}

-(void)loadIntoPosts:(NSArray *)objs forType:(NSInteger)type{
    if (type==1){
        NSDictionary *qs = [objs objectAtIndex:0];
        question_text = [qs objectForKey:@"question_text"];
        accId = [[qs objectForKey:@"accepted_answer"] intValue];
    }else{
        for (NSDictionary *posts in objs) {
            QA *qa = [[QA alloc] init];
            qa.count = [posts objectForKey:@"count"];
            qa.postText = [posts objectForKey:@"post_text"];
            qa.userinfo = [posts objectForKey:@"user_info"];
            qa.postid = [posts objectForKey:@"id"];
            [_posts addObject:qa];
        }
    }
}

#pragma mark http manager delegate
- (void) connectionDidFinish:(HttpManager *)theConnection{
    if(hasSentAcceptedAnswerReq){
        hasSentAcceptedAnswerReq = NO;
    }else if(forwardFriendRequest){
        forwardFriendRequest = NO;
    }
    else{
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:theConnection.receivedData options:kNilOptions error:&error];
        [_posts removeAllObjects];
        
        NSArray *objs = [dict objectForKey:@"question"];
        [self loadIntoPosts:objs forType:1];
        
        objs = [dict objectForKey:@"answers"];
        [self loadIntoPosts:objs forType:2];
        
        [self.postTable setHidden:NO];
        [self.loader stopAnimating];
        [self.postTable reloadData];
        [self.loader stopAnimating];
        if([_posts count]==0){
            [self.noAnswerLabel setHidden:NO];
        }else{
            [self.noAnswerLabel setHidden:YES];
        }
    }
}
-(void) connectionDidFail:(HttpManager *)theConnection{
    NSLog(@"Error");
    [self.loader stopAnimating];
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Couldn't connect to server" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [view show];
}
-(void) acceptAnswer:(NSInteger)row{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@",AcceptedAnswerURL,_question_id.postid,[[_posts objectAtIndex:row] postid]];
    [[HttpManager alloc] initWithURL:[NSURL URLWithString:url] delegate:self];
    hasSentAcceptedAnswerReq = YES;
    [self.writeButton setHidden:YES];
    isSelected = YES;
    _row = row;
    [self.postTable reloadData];
}
#pragma mark user actions

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)writeAnswer:(id)sender {
    NewAnswerViewController *controller = [[NewAnswerViewController alloc] init];
    controller.question_id = _question_id.postid;
    controller.question_text = _question_id.postText;
    [self.navigationController pushViewController:controller animated:YES];
}


- (IBAction)tagFriends:(id)sender {
    MentionViewController *viewvc = [[MentionViewController alloc] init];
    viewvc.qid = _question_id.postid;
    [self.navigationController pushViewController:viewvc animated:YES];
}

-(void) addFriend:(FriendTag *)tag{
    NSString *urlstring = [NSString stringWithFormat:@"%@/%@/%@/%@",
                                                    peerForwardingURL,
                                                    _question_id.postid,
                                                    [plist getValueforKey:C_UserId],
                                                    tag.userid];
    [[HttpManager alloc] initWithURL:[NSURL URLWithString:urlstring] delegate:self];
    forwardFriendRequest = YES;
}


@end
